#!/usr/bin/perl -w

#use strict;
use Time::HiRes qw(gettimeofday tv_interval);
use Class::Struct;
#use MIME::Lite;
use XML::LibXML;
use XML::XPath;
use XML::LibXML::Common;
use XML::NamespaceSupport;
use Template;
use LWP::Simple;
use LWP::UserAgent;
use Switch;
use Expect;

my $t0 = [gettimeofday];
my $xml_file        = "";
my $monitorEmail    = '';
my $report	    = 0;
my $updateinfo_url  = "http://update.pcvisit.de/";
my $updateinfo_file = "updateinfo.xml";
my $time_server     = "ptbtime1.ptb.de";
my $working_dir     = "/tmp/";
my $timezone_dir    = "/usr/share/zoneinfo/";
my $init_dir        = "/etc/init.d/";
my $FTP_Dir_Roles   = "roles/";
my $FTP_Dir_Tmpl    = "templates/";
my $locatime_file   = "/etc/localtime";
my $logfile         = "deploy.log";
my $http_user	    = "pcvisit";
my $http_pass       = "visit-27";
my $name_interfaces = "interfaces"; 
my $path_interfaces = "/etc/network/";
my $name_resolv     = "resolv.conf";
my $path_resolv     = "/etc/";
my $xmlschema	    = "";
my $xsd_file	    = "dsdl.xsd";
my @DLfiles         = ();
my @Logfiles        = ();
my $browser = LWP::UserAgent->new;

struct InstanceData => {
	ip 		=> '$',
	nameserver	=> '$',
	network		=> '$',
	netmask		=> '$',
	gateway		=> '$'
};
	
sub init{

	my $numPkgBeforeInit = 0;
	my $numPkgAfterInit  = 0;
	my $count            = 0;
	my $parser           = "";
	my $struct           = "";

	$|=1;
	
	 # this holds network config data for this instance
        $this = InstanceData->new(ip => getIp("eth0"), nameserver => "", network=>"",netmask=>"",gateway=>"");

	$browser->agent('ReportsBot/1.01');

	if ($#ARGV != 0){
		cleanUpAndExit("ABORT: No role specified. Usage is: deploy.pl <role> ...\n");
	}

	$role     = $ARGV[0];
	$xml_file = $role.".xml";
	push(@DLfiles,$xml_file);
	push(@DLfiles,$xsd_file);
	
	chdir $working_dir or die "ERROR: could not change to $working_dir ... \n";

	# open the logfile
	open FILE, "+>", $logfile or die "ERROR: Could not create Logfile: $! \n";
	close FILE;
	open (STDOUT, ">>$logfile");

	chmod 0644,$logfile;
	push(@Logfiles,$logfile);

	print "INFO: initial IP as we started is: ",$this->ip," ... \n";

	# changing DEBIAN_FRONTEND so aptitude will be completely silent. Dangerous!!!
	# TODO: find a better way to run aptitude total silent
	$ENV{DEBIAN_FRONTEND}='noninteractive';

	# count installed packages
	$numPkgBeforeInit = qx(dpkg -l | wc -l);
		
	# update the system
	system("aptitude update  > /dev/null 2>&1")== 0 or cleanUpAndExit("ABORT: aptitude update not succesfull! (are you root?) ...\n");
	system("aptitude -y safe-upgrade > /dev/null 2>&1")== 0 or cleanUpAndExit("ABORT: aptitude upgrade not succesfull! (are you root?) ...\n");

	$numPkgAfterInit = qx(dpkg -l | wc -l);
	$count = ($numPkgAfterInit - $numPkgBeforeInit);

	print "INFO: system update run successfull! $count system packages were updated... \n";

	#get updateinfo.xml
        $status = getstore($updateinfo_url.$updateinfo_file, $updateinfo_file,);
        	if ( !is_success($status)) { cleanUpAndExit("ERROR: error downloading file '$updateinfo_url.$updateinfo_file' : Error Code: $status ... \n");
        }
	print "INFO: fetched '$updateinfo_url$updateinfo_file' ... \n";

	# new parser for updateinfo.xml
	my $updateParser =  new XML::LibXML;
	if (! -e $updateinfo_file){
                cleanUpAndExit("ERROR: Could not find XML Config $updateinfo_file ... \n");
        }
        my $updateStruct = $updateParser -> parse_file($updateinfo_file);
	my $UpdateRoot	 = $updateStruct -> getDocumentElement();
	my @UpdateNodes  = $UpdateRoot   ->getElementsByTagName('repository');

	foreach $repo (@UpdateNodes){
		if($repo->nodeType==ELEMENT_NODE){
			if($repo->getAttribute('name') eq "serverrepo"){
				print "INFO: repository URL is ".$repo->getAttribute('url')." ... \n";
				$repo_url = $repo->getAttribute('url');
			}
		}
	} 
	
	$browser->credentials(
  		'80.237.225.181:80',
  		'Repository',
  		$http_user => $http_pass
	);

	# get the XML File for the role we are acting as
	foreach $file (@DLfiles){
		getFileFromRepo($FTP_Dir_Roles.$file,$file);
	}

	$parser = new XML::LibXML;

        if (! -e $xml_file){
                cleanUpAndExit("ERROR: Could not find XML Config $xml_file ... \n");
        }
        $struct = $parser -> parse_file($xml_file);

        $xmlschema = XML::LibXML::Schema->new( location => $xsd_file ) or cleanUpAndExit("ABORT: XSD not found ...\n");
        eval { $xmlschema->validate( $struct ); };

        if($@) { cleanUpAndExit("ABORT: $xml_file seems not to be valid DSDL! \n\n $@ \n") }
        else{ print "INFO: $xml_file seems to be valid DSDL document! Starting deployment ...\n";}

}

#################################################################################################
#												#
# get an artifact from the XML DOM								#
#												#
#################################################################################################

sub parseAndExecuteXML{

	$parser = new XML::LibXML;

	if (! -e $xml_file){
		cleanUpAndExit("ERROR: Could not find XML Config $xml_file ... \n");
	}
	$struct = $parser -> parse_file($xml_file);
	$rootel = $struct -> getDocumentElement();
	@nodes  = $rootel -> getChildNodes();

	foreach $node (@nodes){

  		if($node->nodeType==ELEMENT_NODE){
			switch ($node->nodeName()){

				case "report" {
					$monitorEmail = $node->textContent();
					$report = 1;
					print "INFO: set report rcpt to: ".$node->textContent()." ... \n";
				}			
				case "timezone" {
					setTimezone($node->textContent());
					print "INFO: timezone set to: ".$node->textContent()." ... \n";
				}
				case "aptitude" {
					aptInstall($node->textContent());
				}

				case "copy" {
                                        copyFile($node);
                                }

				case "command" {
					sysExec($node->textContent());
				}
				case "install" {
                                        pcvInstall($node);
                                }
				case "ipconfig" {
					setupNetworking($node);
					print "INFO: interfaces configured ... \n"
				}
				case "sysvinit" {
					sysvInit($node);
				}
			}
		}
	}
	print "RESULT: deployment run completed successfully. Took ".tv_interval($t0)." Seconds to finish ... \n";
}
#################################################################################################
#												#
# set up interface configuration via template of /etc/network/interfaces			#
#												#
#################################################################################################

sub setupNetworking{
	
	my $tt = Template->new;
        my $Subnode         = "";
	my @Subnodes        = "";

	@Subnodes  = $_[0]->getChildNodes();

	foreach $Subnode (@Subnodes){

		if($Subnode->nodeType==ELEMENT_NODE){
	
			switch ($Subnode ->nodeName()){
				
				case "ip"         { $this::ip         = $Subnode->textContent();}
				case "gateway"    { $this::gateway    = $Subnode->textContent();}
				case "network"    { $this::network    = $Subnode->textContent();}
				case "netmask"    { $this::netmask    = $Subnode->textContent();}
				case "nameserver" { $this::nameserver = $Subnode->textContent();}
			}
		}	
	}
	my %data = ( ip_address  => $this::ip,
                     ip_network  => $this::network,
                     ip_netmask  => $this::netmask,
		     ip_gateway  => $this::gateway );
	
	getFileFromRepo($FTP_Dir_Tmpl.$name_interfaces.".tt",$name_interfaces.".tt");
	getFileFromRepo($FTP_Dir_Tmpl.$name_resolv.".tt",$name_resolv.".tt");

	$tt->process($name_interfaces.".tt", \%data,$name_interfaces) || die $tt->error;

	my %ns_data = ( nameserver =>$this::nameserver);

	$tt->process($name_resolv.".tt", \%ns_data,$name_resolv) || die $tt->error;

        # cp interfaces to given path
        system("cp $name_interfaces $path_interfaces$name_interfaces") == 0
        or cleanUpAndExit("ERROR: Could not cp $name_interfaces to $path_interfaces$name_interfaces ...\n");

	# cp resolv.conf to given path
	system("cp $name_resolv $path_resolv$name_resolv") == 0
        or cleanUpAndExit("ERROR: Could not cp $name_resolv to $path_resolv$name_resolv ...\n");

	# reload the new network configuration
	sysExec("/etc/init.d/networking restart");	

}
#################################################################################################
#												#
# installiert pcvisit Server Software mit Parametern aus config.XML				#
#												#
#################################################################################################

sub pcvInstall{

	my $leaf          = "";
	my $step          = "";
        my $Subnode       = "";
	my $artefact      = "";
	my $revision      = "";
	my $config	  = "";
	my $cust	  = "";
	my $filename      = "";
	my $osname        = "";
	my $branch        = "";	
        my @Subnodes      = "";
	my @expat_steps   = "";

	@Subnodes  = $_[0]->getChildNodes();

        foreach $Subnode (@Subnodes){

                if($Subnode->nodeType==ELEMENT_NODE){

                        switch ($Subnode -> nodeName()){
                                case "name" { $artefact = $Subnode->textContent();}
				case "branch" { $branch = $Subnode->textContent();}
                                case "revision" { $revision = $Subnode->textContent();}
				case "os" { $osname = $Subnode->textContent();}
				case "config"  { $config = $Subnode->textContent();}
				case "customization" { $cust = $Subnode->textContent();}
                                case "file" { $filename = $Subnode->textContent();}
                        }
                }
        }

	getFileFromRepo("private/".$artefact."/".$branch."/".$revision."/".$osname."/".$config."/".$cust."/".$filename,$filename);

        chmod 0750,$working_dir.$filename;

	@expat_steps = $_[0]->getChildrenByTagName("expat_steps");

	# we got an <expat_steps> Tag so use Expat to process install
	if(@expat_steps == "1"){

	        $command = Expect->spawn($working_dir.$filename)
	        or cleanUpAndExit("Couldn't start program: $!\n");
	
	        # prevent the program's output from being shown on our STDOUT
		$command->log_stdout(0);

		# log session to logfile and add $logile to list of logfiles
		$command->log_file($artefact.".log");
		push(@Logfiles,$artefact.".log");

		my $leaf  = $expat_steps[0];
		my @steps = $leaf->getChildNodes();
		
		foreach my $step (@steps){
		 	if($step->nodeType==ELEMENT_NODE){

				#get question and send it to install 
        			unless ($command->expect(30, $step->getElementsByTagName("question")->item(0)->textContent())) {
			                # timed out
        			}
				
				# send answer either parse $InstanceData or send directly given IP 
				if ($step->getElementsByTagName("answer")->item(0)->textContent() =~ m/\$this/){
					my $var =  $step->getElementsByTagName("answer")->item(0)->textContent();
					#print "pattern matched $InstanceData \n";
					print $command (eval $var) ."\r";
				}else{
					print $command $step->getElementsByTagName("answer")->item(0)->textContent()."\r";
				}
			}
		}
		# if the program will terminate by itself, finish up with
	        $command->soft_close();

	# no <expat_steps> so simply run the file to install
	}elsif(@expat_steps == "0"){

		sysExec($filename);

	# there should be only one <expat_steps> Tag in an <install>
	}else{
		cleanUpAndExit("ERROR: only one Tag <expat_steps> is allowed \n");
	}
	print "INFO: artefact '$artefact' revision '$revision' installed successfully ... \n";
}

################################################################################################
#											       #
# gets associated IP of an interface -> usefull when IP should be that of dhcp.lease	       #
#											       #
################################################################################################

sub getIp {

	my $ip = "0.0.0.0"; # Default-IP
	my $interface = shift || "lo"; # Default-Interface

	return $ip if $>; # nur r00t geht weiter

	@ifconfig = qx(ifconfig);

	$if_found=0;
	foreach(@ifconfig) {
		$if_found++ if /^$interface\s/;
		if ($if_found) {
			if ( /(\d+).(\d+).(\d+).(\d+)/ ) {
				$ip = "$1.$2.$3.$4";
				last;
			}
		}
	}
	return $ip;
}

################################################################################################
#											       #
# 				setting timezone					       #
#											       #
################################################################################################

sub setTimezone{

	my $zonefile=$timezone_dir.$_[0];

	if( -e $zonefile){
		system("cp $zonefile $locatime_file >> $logfile") == 0 or cleanUpAndExit("ERROR: Could not cp $zonefile to $locatime_file ...\n");
		system("ntpdate -s $time_server >> $logfile") == 0  or cleanUpAndExit("ERROR: Could not set time via ntpdate ...\n");
	}else{
		cleanUpAndExit("ERROR: unable to set timezone! Make sure $zonefile exists ... \n");
	}
}

sub aptInstall{

	my $numPkgBefore = qx(dpkg -l | wc -l);

	system("aptitude -y install $_[0] > /dev/null 2>&1");
	my $numPkgAfter = qx(dpkg -l | wc -l);

	if(($numPkgAfter - $numPkgBefore) == 0){

		my $dpkg = qx(dpkg -l | grep $_[0] | wc -l);
		if ($dpkg == "1") {print  "INFO: packet '$_[0]' was already installed. Skipped ... \n";}
		if ($dpkg == "0") {print  "INFO: packet '$_[0]' was NOT installed. Skipped ... \n";}

	}elsif(($numPkgAfter - $numPkgBefore) > 0){
	
		print "INFO: packet '$_[0]' and dependencies were installed. Added ".($numPkgAfter - $numPkgBefore)." packets ... \n";
	}
}

sub getFileFromRepo{

	$response = $browser->mirror($repo_url.$_[0],$_[1]);

	if( $response->is_error( ) ){
 		cleanUpAndExit("ERROR: error downloading file '$_[0]' : Error Code: $status ... \n"); 
    		$response->status_line;
	}
}

sub sysExec(){
	
	 my $output = system("$_[0] >> $logfile");

	 if($output == 0){
		print "INFO: command '$_[0]' returned with Code $output ... \n";
	 }else{
		cleanUpAndExit("ERROR: command '$_[0]' returned Code $output ... \n");
	}
}

sub sysvInit(){

	my @sysv_subnodes = "";
	my $sysv_filename = "";
	my $sysv_sourcefile = "";
	my $sysv_position = "";
	my $sysv_subnode  = "";


	@sysv_subnodes = $_[0]->getChildNodes();

	foreach $sysv_subnode (@sysv_subnodes){

                if($sysv_subnode->nodeType==ELEMENT_NODE){
			
			switch ($sysv_subnode->nodeName()){
				case "sourcefile" { $sysv_sourcefile = $sysv_subnode->textContent();}
				case "sysvname"   { $sysv_filename   = $sysv_subnode->textContent();}
				case "position"   { $sysv_position   = $sysv_subnode->textContent();}
			}
		}
	}
	print "INFO: installing SysV-style init script '$init_dir$sysv_filename' ... \n";
	system("cp $sysv_sourcefile $init_dir$sysv_filename");
	system("update-rc.d $sysv_filename defaults $sysv_position");
}
sub cleanUpAndExit{

	my $logString = $_[0];

	print $logString;

	if ($report){
		my $message = MIME::Lite->new(
        		To      => $monitorEmail,
        		Subject => "Deployment run for role \"$role\" on ip ".$this->ip."",
        		Data    => 'logfiles attached',
			Type    =>'multipart/mixed'
		);

		foreach $line (@Logfiles) {
			$part = MIME::Lite->new(
				Type => 'text/plain',
				Path => $working_dir.$line,
				Disposition => 'attachment'
			)or die "Error adding the text message part: $!\n";
			$message->attach($part);
		}
		$message->send;
	}
	exit 0;
}

sub copyFile {

	my $src	     = "";
	my $dest     = "";
	my $subnode  = "";
	my @subnodes = ();

	@subnodes = $_[0]->getChildNodes();

	foreach $item (@subnodes){
		
		if($item->nodeType==ELEMENT_NODE){
			
			switch ($item->nodeName()){
				case "sourcefile" { $src  = $item->textContent();}
				case "destfile"	  { $dest = $item->textContent();} 
			}
		}
	}

	getFileFromRepo($src,$dest);
	print "INFO: copied $src from repository to $dest ... \n";
}

init();
parseAndExecuteXML();
cleanUpAndExit("CLEANEXIT: run successfully finished ...\n");

