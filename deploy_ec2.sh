#!/bin/bash 

role="server_ec2"

echo ""
echo "			Automated Deployment Run"
echo ""
echo "INFO: starting pre-configuration ..."

export DEBIAN_FRONTEND=noninteractive
version=`cat /etc/issue`

if [[ $version =~ "Ubuntu" ]]
then
	echo "INFO: running on Ubuntu ..."
	sudo aptitude update && sudo aptitude install -y libexpect-perl libxml-xpath-perl libtemplate-perl libmime-lite-perl ntpdate
	echo "INFO: extracting files ..."
	tail -n +32 $0 | tar xz
	sudo chmod u+x deploy.pl
	sudo ./deploy.pl $role

elif [[ $version =~ "Debian" ]]
then
	echo "INFO: running on Debian ..."
	aptitude update &&  aptitude install -y libexpect-perl libxml-xpath-perl libtemplate-perl libmime-lite-perl ntpdate
	echo "INFO: extracting files ..."
	tail -n +32 $0 | tar xz
        chmod u+x deploy.pl
        ./deploy.pl $role
fi
exit 0
� �G,L �;�s۶����+`��DM%JJ������a��3����^g���!��dҊ^���ow� )���e27#���X,�����I��$��۵��O�����'�/��O��0�4|4>�������!ME�E楌�����.��������~.��U�����j��s����`����e����\��+�g��s�[��fDOo��#�_����E�����ǣ�i�q���ק��
�����E`4z/�qd�yK.o�/�$�SM%_&���8�Ϸ@C ]f�;����<RS.VA6SKJ8��Z��A6`c����?i��2�΃�3��̶��dqz��P���r$�H�%;��}�9���@�Ȳd����p��M ���y�˳X����Q?I��loF��h��#w��/�����9'I|A4WS�Z�9�X S�.8���gS`�O5AIv��C> F���At=����-����q��8������>���: ��4�f}�w}�����(H��q�LP)~��_��(,���&�g�Q	�^	�C(�MQA8_�[Q0��)�_jiNI���	ܧ�=U�y�p!B���CF@	\�Q�Ϡo�J���������h��W�p��gG��ganZ��Jv�r��H�Wi�@O���&_���J�I�:��#/��x�>�� a���n�B���}r�V�g�	��Nw�uO���e�D~�Pv>�Z1'_��p���㔟@������9�62��H}oY����b�,[�-��LQȐ��5�qw��	Ԟ[�k�=�0��� /�~�Y'�c�l1�;]V�m���O��b}VL���V�Jo��Y8�sRc�E����`�&�`Μ������ۃmv�L�YȽ�]�<�?�c?���r��b�W�	г�<���	��1b��C��h�\�}!%�-C3���j@![�:�nqm���Rǥ�&���%*��������o�Gpy�(��l�E@aW�8�!�Y���3u�[��:9=�2��	�P��^�������=� 03��b����ͻK�=�h���f�e���?���0)���)n_1B3�(�|�'g�ތH�/d'o�'�
} /͸OdwI�z� ��U��5��������7g��gGL��K� �}�VA�+�E���p�Pe.;B�q.�����#�fD>�`J׊��� ʣeg@���p|�����vf�7˂�Vӵ����A�%>�$
������ɇk��_l5��(�"���N_�X��%�:vA��a���M?ʁ�&�6�;c�1([.Lʉ�g���c�9`�:��Z��?:ƕi��n{s�˓�ԃ�_C���`b
���q3Ku�4���
�)�rۚ](+�BE�B��������ž)נIYտ)�0N�� ^wj�[������I���@LŎZ��a�g��OS�'�*
c��H:�})m6b�4�e죮Q�Q�7Ⱥ�1x�~���Ds��� ��N�ģa�1�*}˷h�hJ%J ��o�l��-+�-)�]dt��&^�O%�2�AS��7��%TN�^����s�.V�Aa�!?�g���q��f>�3���y+1u�	�T3ċ��w����(A`������7[���9&R���ܡ!p.��r���������������1P����ƫ<����hw��l�~ �-�Te����;?[�lw#J��v�5l�*��1�>�`A��[�N@�݀���U`��GlY�_��O�G����_��_�#��o<��P_K�]��UoY)��@�2���B��^�n�WT�h���z�8�@G{0�4��(^���0�ȸ4�{��\&�w�[�־e4�J[��D�Y ��3����ћ�lm�7��z������B�� �z��vL���ȍN��*��UK݂�x 
%�lTŲ����;!��OS<�
�fIؗ� ��;UE�� v�R$�x���n- (��LPR:D�<����e"�fRXՔɘ�����2��⚧Ȥ��~;���u���|u�qk�#WP�S���R�9��u6���]_@�A���
B��D��w�a� O{�E~���@��t����y�֒�M�F�znk���ϓ3���,�69n�6$����nck��vL�ܠKYY��4�#t~|���R�x����a�o��k�]��8~#K�d<��B�Q��@,Ja���[��[r�`��q�n��L�笒?*��u{MZ>���4"��V)%ӕ�ȯH��&3V�h�!Q�Z�ښ�1��܎��U/��bD��z�R��q�ԬUUdAb�,�F�Q��,�*\󢨜�]��:�EII��z}	�U5�`�`)�a���H�ݍ�ԁE� ��o���p������c��A���f���Kp�u������]�8�Jwu(�՗Ĥ�[�(���2���>�J#���.�&Ȳ�$Ic�n���'�7�鰿���!���P�m��iqL�lh��QQ!(P+��L�>�}6KL:�:���dz��6 �H��S�u ��0�S�ڐ�i�7����{�2S;�1㍠�3��%�p`�"�_����B}���cބ����yxe�Z��TyM�
3���4) �Z��r+O-�����#�.H�/�y��0s	}o�X�Z�%B���>�~h��j�����>�ݐ1�M�h} ��-�n��7V�/Y��2����X�ݕ��ԋ��������a�"���Y ؗ:"z�{����y�w����౰�˲m�n��&[]���,�d5�T\�k��h��BX�y=��YJ46G�C8Q=>p"�j��I:��Ş�	������5�M��.��B\�ɣ�����o���Ru�30B~�[���ˢӞ>tͷ�r�?�Z6n`ʣ2k���8��)c�wct�`>����L�$Z�cbʩ.JahS`��p�r @�,o�MD�"g�:����,n��� �s��*U2�����cc4�
�-X�gI���W��Xī��%�s�V��	b���M�����Dg@L�A{��0F���>�	��V��C=�
D4P�[)RT�A��մ	@����7�B�N��.D�6(g�ڴb.��#�Q\�(L��wia2ژ~���C��A~�H~�ܰ��ɲ�(D�rJ�p���Ԓ_l����Mt��zJ�#�+���O�1e�$嶌`�%�^$V��� d(�QvP�!%Hb :\+���-#<T�p�&�
۷���Ö��(�U�Mg~��#�W!Wi�}�W�!�l��'��N��JC��7^Hu�k�Ou*����8㫈6�0�cpd�l���~��2�0at�)<�wu�+O C���N���'��� A9
��[S���+_�Gd�&9�*�L������|������`2�����T�Zr�*پ%h)p��*�@0����˷�J���څ2j��	i�m6��H3��ͽ�J4�o�| ��
�|oǻ
��X��MÇ$��B^��4��G�_��,��}��z��P��Vb����}*��+���[Q�v����0�k @��,퀨�L.��������+��O�_��'G�ٍ`>��y䏱BM���!Uv�㏸X��Jrߋ�aKiV��<U0��������>SP�b���=x�<v~R�$�DVy�57�]e�
,E?��`���TZ��3*�q���%�T�h:����Ȳ��=P/u�LXYpƶUmL�(1;S�Z�-DD�,��j5�D��z��ȍ
�{�vyW�t����^{�R��K�?��)�o����'�M5�۪�6Wsio�uC9W�2u;~��J�U��JrZZMDJ8jخS�Z%1f�)
	/��Y�4m԰
��Iém����V�ץs�Ň I�=
u��B}���n���pC&�ԵU{��-���pQy4t��A�s߇�m���\[!�{q!U�X��I{�Y�&�Se�,-U�5T�	��#DmS������A[��Q��
6k�_Z�&w_}��/���H�HP���Y8�A1�ŝS��S���I��Z��h�q�e+K�iD�<P�J��P����@]{S��(e��u9vEBu���&��q��X��5v��܊u�Nm��彣t�3�QRiM3��Fک: �<�q����՗�D]m�N�t*�N���[A�T1lK��@w��T�~��*￪���%�ܩ�ٞED8�~e&#�������cy�F%�����p/�ⷞ��!�Rv&fi��6�?���(R�x?u�m�^)��ś�t��u>�қ�]��[��;U����Y��RBXV;�c�/0d����0��bl��N�H�H�\��>��X]�"��o�)�	���/X�H���m���{�x�݃}ѿpm��F��b[�䘗ef<��8@\	�^ׂB��2��0,�n��C���$�
1��.۴uK���Q��I��\��/*�Q\B��T$�@ҍ�@ʬN����O3��'����);��z��!��wB�/�1�%��af��"Рi��V��{	����gǿ�\���k�����z!��?Mݵ]۵]۵]۵]۵]۵]۵]۵]۵]۵�l���/� P  