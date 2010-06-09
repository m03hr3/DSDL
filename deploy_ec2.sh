#!/bin/bash 

echo ""
echo "			Automated Deployment Run"
echo ""
echo "INFO: installing needed system packages ..."

export DEBIAN_FRONTEND=noninteractive
version=`cat /etc/issue`

tail -n +30 $0 | tar xz 

if [[ $version =~ "Ubuntu" ]]
then
	echo "INFO: running on Ubuntu ..."
	sudo update && sudo aptitude install -y libexpect-perl libxml-xpath-perl libtemplate-perl libmime-lite-perl
	sudo chmod u+x deploy_ec2.pl
	sudo ./deploy_ec2.pl

elif [[ $version =~ "Debian" ]]
then
	echo "INFO: running on Debian ..."
	aptitude update &&  aptitude install -y libexpect-perl libxml-xpath-perl libtemplate-perl libmime-lite-perl
        chmod u+x deploy_ec2.pl
        ./deploy_ec2.pl
fi
echo "INFO: extracting files ..."

exit 0
� 5YL �;s۶����0�W�W�����*?��ʜg;c��:����"$�B���K}��v 	R���6����X���b
y��?�����z�^��#�=|�c������/_|wx�����/z/�������X�+�Sk��A��wA</�{j��i���"��DI7�y�:w��n!82��򨅟��9���3��}��\J�I'a�`�v%��A����ā��������a�I��������_������-��o��<M���`�E��U�ein���,�g��h��Kw\�Er���3�����|��ys�3W �<�3�m� �=@�[�����<M��3l�j1����U 9��Q;� ܙ�Y��-�X���m$"釼2U�]�����-~FRW��ß����w�����=��ZG�i����:��������c�LGa���r����&�quN̂�w�;J&���H*��.��.v��y{�~t�K�� �������F+J�8���,��1��@�r7KHf҇n���ǅ(�O����B�zp2Z��;M��$c~Ȁ��e�a��w�rTmu��%��xP~���:��}m=���(n
�s�� /I1�q�3��9?�~ �wd����m���"��[N���C����,l�ơ`�,6N�I4e!�K(�Hs	s��q��� �w�b��i�\�z�����A�=`%���>���.���PkjjԄg������qȒT��,H��ɴ��>�����4�	0Ùօ�C=oOφ��a ��j�X�M�P΁L�����;jg�`�ّF�]]�\�r���p6OC�{����IY!f^�i�̀�瞞���.DA�N߳@�;4�A.y�"�g�mPgen] $$;�|��|�����zx~�DʂLF�9����p�-ZZ��@E"}v�2��B��� ���f%!`��c��tdx��ύU���4!��et��4U���_qL��L� ,+�ӽf��������|)I;,B�y�Q=��Nð�����������1��q̃��u�#鹯����&�Q��\L �����EZ�<M���A�H��h0�"��|�#�(S�Զ�EZoiJg�-+�bۈ+/M�&Q��Pf�A�s#Ⱖ�`Uhg!\`o�*���W�@�Q�@��$,�X���g��>Xgp!��y:������OS���9��æa�h�]�j�X`LF��M��R'�,��ԯN+��,�'���Br�
T��1( �P��1N���:�r��!M=_��dc��7�7UѕV�QN[�d�ߚ��@�I�^�,j8��1���!�u���9�a���z�U����)��Y
��,��s���R;���i�c�1����%�{������l�nx~=:�8�,Aa-�A1<���0���5�	�\F#0��k�g�K~/Ah�!S	�vP&����A�Us}˙ ��c�JB��T���Q���IX���W�N����D�5�SSj+f*N��_d�*�+T"]�8�@8ҠP
G�����]b$q���-���
4�y���׻^�rCE���d��om����u�~���2@��+�B���H�*ex��u��*I���L M�m0���N�:��V���Ƴ�-��*L�h�L�Cau��8~Uܐi1RWE����Xjc>�Ԯ9�s�Ʒ�Yd�kf���Y���O*"��Њ>����~����S���vTYQ��!��R�kٜ:�#�TfF����T�T�ґ}^u�ְ��ͱhe�c1ڗ`��j	v~�2�s-,V^�8�J�%Џ�P^	a%��Q��D��J���0���W���9����\�1P��TP����eP�oΓ�����5��n��B/�<���￷`���R��a�:@���B�h�����N{�`��t��Ŀ�ʱ���L ]!�g�"v<r��W��t�G��?мVL��JuͲH=�
�����o���G�O]�� ��;�N�k�m�K���ҧpl���"1m�*h��v��%j��g-�4�z���	�Z�SW�����C,'݃��x�7A���Few�����A��Kzk�`��/Q��~���m���y��B�_1*�E�����QQ#(�k|�&�H��3;b�x��~�P���Kf�is� `��S�ZQ�Y.C�X��O,eW��1�58s�X�g�>��bC�.YXF_'=�q�T�2C�t���V�D���2�F�r
H�ַ�ct��\2}��i�U:�wX՚C�� Q�6&,(L����������L��/��/�*e��m9��&ba��_́��� �k(�8��B�z�P��������A��pl����{���@�/͇�_En�$�u9+'�E޻歭]�,�P���Z��ی�/��T���I�Ҫ��S�FmÉ���<�'�0Z{�	���+u�_��<R���P���n���~��f�7%]�Y�7��W���'���K�{�`5��}��]=��@�۹�l�RU�o����D�/��2���o��<X�C�r$�C[�A�4���3Yp�x�9گf���f�=����)8����j�.��[,�GՐ{����
}�p��e�Yz�089i.�.8AwݝA�N��&z=H�� Q����;V�3C�t��8���"�P�*~�Rt�O�j��t�*{o�h��~U��
��,2U��5.]���Q�(/���� ���T@��Ay�D�?ZoX��0�HbT)�
'5���^ru�hVq�;���~����
���K7!�M�CU=�Ud�����G�C��ua���PR�%�ㅎ7O�3]N`ޣL�ֳ����ͻ(;�"��m�U��%�r]��եu�
��xJO���DW�˃��� &����~��m
���r�"�^º!�-a[g]]�C�(�����P�xr`��E0�4m�(�TG����v2I����[���'�ȗ�QW�LdO���F�6����.aRq��6�*x��l���L�^rЪľ&S)q��:�H0�����W���k�2��+��+#�����Y�����嫇��|u	�
��#��ǳ
��X]�@l�Ifw3u��ݐ��,z8g>Yp��%�6����#%f�|�������خ"���������&kn�ց�͹,�: j8i��%�2�^O��3	��c�hR���=�M�4��h�Ix�︴����d�@?���u��"�����e5P��c�z�����LC9Z8�C���o?��/�=�!�귎��Tg�������̷�<�ި~����g�>��ՄGo&y6�<co!�`���glݫ��U�%�d�X��M%�T�|:���tQ@O ]��պO��"	n������S�%K��!��w$j��W�^^�{9��ŗ��hSW<�Z~��?]Aؐ�YJ��k"R���6�!jU�����P(x����ʧ��/�8�4����t�`��E��|v�1ʲ�M�uԽ�P�_\?��U��<*���՚�n,��V�3Qy2��s4���a˻����F,�'3�V5d�'U�|AV+��_�)e�ꍷ�
	�D�Rb �Y�YK���&g�Ӈ����߉�H��������I5qB�UW$���[�	�$;}f�Yu�L����'�b�%t}BlˁJO%-�Ի��&`6d)o��q+W�Vm{ʖ�ź
a�Y�Ng_��W�r//���(Xe����\{��Us(KE$U!�1�Tu���������֕m��_�՞h,O���P�$���,���U6�S�IVb�j�_��l���ܖ�0-��2���� �����{G�E���7�<��p�_W�9س4��[3��nY����c?l�)T��hp�����TyK�N�d�li%�Wc��=Lqo����TՈ�~o���*��y��`篪_��U/D����8��=����W����5��}׵��y�
�� �?�pP��x�7�D$~�yt�-�~�`[�H�����q�*V��F�fq%���?��w+�!��HTV�D#�@��_�ҁLx�y��aF�H��b�`v�3P�<"�<�-�؃LC�%�'`#2�G����ػT�<�>�zz�o� _躄������ݶm۶m۶m۶m۶m۶m۶m۶m۶m۶m۶m��j�9P�� P  