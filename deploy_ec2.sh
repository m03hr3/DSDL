#!/bin/bash 

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
	tail -n +30 $0 | tar xz
	sudo chmod u+x deploy.pl
	sudo ./deploy.pl

elif [[ $version =~ "Debian" ]]
then
	echo "INFO: running on Debian ..."
	aptitude update &&  aptitude install -y libexpect-perl libxml-xpath-perl libtemplate-perl libmime-lite-perl ntpdate
	echo "INFO: extracting files ..."
	tail -n +30 $0 | tar xz
        chmod u+x deploy.pl
        ./deploy.pl
fi
exit 0
� $�L �;ks�8��J�
�ю���󘹑O�db��U�������̩h�x�H� -k3�߾�x��C���Tꮌ��%���nt7��O�0޸I��۵!��_�Ŀ�?���=����'��/�������'C�2|B�ߐ��e�{)!O�p��������to��tpD���!�[�����4��~�
Vt4����2�i�,(���}oC��4�8Mo��+�߄c��%O3������$�T~���	~���F�o�_� F�7�jG�����,�f�2K�8�T�Uzz���>�R�����ۄ"m��N��ڐv��"cb3���S:{f� ��C@�7S�����U8�!%���z���.#(�I<�`�r {�y2����dv���>x�e� $ip����Ls�h��g��O����_~1g�$�/��j�}�ק�`Jѥx�yL�`5A	���}> F��ӏA���A8�d`��{Q=�è�l�t�#������4�����z{u>=��l�P�7�:~ʦ�p��9L�<���d���8��-L5@8_�h�0�O�0��H��� �f�	�$���hF=��|nYAB,>vڝ^ˊм�V}���R��cf�^{�Ӻ;hY-�]��V�B�lu�q�+��)=�~ nx`���7����,R�[V���>�}J�2`d�>#�>2��y� >�KH�@qs��qI�ID�� ��<N������H!	��^g<�/J��?����ժ��@�Pb]\�]���,�Is2[zт��]�%"[�'4f(Q
ҲD��㓣�� i��TzS,�R �(����\���1xEDv�;�W�g� �d�k�V�O�?�x��0)����/3�����ǧo�FB/$���cd���r꓀���ԟI�.@	DC�~=~}:}{qvzutzHXL��<�)YaH�)��>��0�"�.9D�q�������!P3"�x0��ґ5�g1I��@�c�J,�?G��\��n܉�H�ތ7��(J+t/�A8�>z� K�|�u����C�Y��/�β�t�b�ن�kiY�c�d*2!����l�þ��٠J�B�E�בtp�~����ՈT1���l6�l8��~�l⌤q�����{���h胴�9�g�"�����"1�LL.S�{4�4w&NmJ���
,���B]�*z��=�"�M��C�bK{�6(��[�@�S9����ګ�=`@#��9q�^���bG-��ϵ=Qރ�)��x���
�y���#1�M죯Q�(���*�ù�{�.Q_�� ����Sp���W�j�ȹ1��
	�>�ɱ�9�W�-+ܭp.��ġT��d�?��@O����dW�rj����� s�

c_�w��,[�s;
)�q��Wr�)l!F�	��O`���~�\y�ɝ�� ��#,�ț-e�I)H�y;b�`��$t<>:9zwtz5==;<@������:�ϝ.��0���@l9��QU���	�4�v��u��q� �"V��f�2�����PN4s�ߨoq�el�I<ѱ����1CnBO�	� �x�ƫ��)ǧ���kk%�k��v��|Ek=��_��)����������ߜV�
��Kg��@���D{��s0����ņ|�#�o{�@ei��ԓF#ϗ�s�@*��=dϯ�܌�,	�f���F�l�j)C�$�;�U&�����+��E�<�6m}U��4Y�Q~���tNo9�F��˶���&�д�V��� D�9!�q,ö��0Q@���"�`e�P�v���D�^=e�5�j�h4�m��b"oJ���T�n��H��.�4(�đ�pZ+��XI�`�o��#��
w���か���'�0j���tt��%Wq����H9m>ĭ��@)�!�[زP�������
I��xG�&��� �xND�@�<�����hl�78:/���RDs�]�Rd&l[�j�Շ�x�O������MuV���Yb�q�+��s#��������m���zPͩ�OD?*���ϑ�\��Uw�Vɤ���D\�G� 18).9��^U"�.aQ��cQ�ZƢs4_�,5,��X�$�m`12;�c^�n	��/"��G$S��A�P#&��{�~�s�p�u��miv��.��O�����ڛ� ���4*B�<u)���!���<w��~0`J���ږ!}a���vm��5�C�����S�3�t�@��"v�c�Z�-�N���4M��k�bj�&���* m<A|�}8�*g+ٟ�?��xt�"_�C�d�u۶M0���-}�N�+�TA�?[��_[��)�Cn��k鰮���O'n�B\���k�F����R��%s���'I˜X3�p�5j��?D�] ٲ���M�Ӣ��P;��QQ"(PK|4�����3b�x�Ј�~�P:��57U�9U ����q5�w�����K��^���*�Y5��-��a|
w�B}���b2UdC0�P~�R��V~�,�IFyЍ���	 �Z����M9Qo�p�Z~���Z+�;�RlcD�L_��ޝ|�P~��o����͸/�*%���~�1&�Ӗ�~UR�҂�^u@��*�e��{0	��U����4p�z�f�e�P�7"z:=E0��!���G�;\��9'�E�w�6vq������~߼�h��"��ʳ=1��j�6Gg�p�zS�q"�j�
�.|�X{�	�hė�����>rg<�4�z�]{`�j?�g�򛔮�������O��^�ɴ�����aϬ(�	�3m�fv�{����5%�Xd��������2��<*Q��v��v�˃'ط�I��ViP MVX�',�֑��Q���pڊc6�pY ��,����0/f?�Qz��A<Qd��8�I�^�)�l�#�gpD��]Mw�`χ��P�}��(��@0����|_�]�w
@��a5�2�_��(�7�j�D��3
���Ђ9�*W��<��io�m��'.qD܋����bK>^� 
AѠ<��?JoH��lYY�J9�P�P�ٰGԒͷE����O���jV�+�U�~*^|����"{�T��Elq@�R��BڥZ)PR	JD�o��N νL���@�� ��q;�$�э'���
���?U�u���<��^�4&Q��ܰzㅂ�.q��~M�!��g|���l۰uY���s���BF�yO���`�^P�U� R��
(G��(�8Hp�KI7���+��ݣJ��\�P���E�t���+C�/�⚂o�U�=�H�n��U�}�M%ǅ���F G���/�K�<y��ɝQ��G'?�:F���c>�|�t�Ж/��Q��Y��7h���A���Ćp�!�d���\�_z£��Yₐ5�7.��WQ�H��KA�\�} .��+y��\A�܎��`�1g`�qXڔ���KkO.�#39���K�ɦ��<@�t��o2�̧�8��1Vr�c��gH����#.6����lp�R�UC)?/j���Ǯ[�w@�����w����s��B���c�T�a2�]u�2��xE�nW`���o�Z��3:�q�������pD̈́�'�����*�Ʉ��d[�`cV&G�)�2֢�1'"Ⲙ��ʅ��D�(E <�!W#/�}�mg�w-I׈��=���'E��$�bNV�#��[UT14�^o��l���ќ�Ԇ��z�v��	��]JI�S�
l��VI�Y-+�����Y�i�P�zL�GN퐵�� x%S�b.��$IQ� �e�ÝP��]ݏ�U���+������#��$�[>M D��,�E��}����Wsm��%3�VU/�b�tT�Ӎ�Z����E��N��BB��Q���T�O��p���R�?��U���:Ղw�ɽ�'u��)te!��@�)-,ջ��:`�d����VA\�Z�-�!_�k�*��N����+����Ez��Ly��]{F��JC�,S&�*stBU�!̨��CF	�Sư-�h�_�V*ѨO+��Z�\"�U�N��,���$�19�/����Ĕo�n�ju[�NL>��]n�_��oB*~�A�,t\�Xe���R�Pؖ�_'Ȋ�~:s���|��
�8�N�@٦�W�xq�SdK)a��bL��Wࣼ�m�H���"qc�F��-�*M�UF�a�����u�
�2��_���	�˕qXU/�\�3׶���'_��"�& ��[j:'�&H��7X�0ܲʦۊ&�V*��	M�Z
7.�
4HB/�Ě��Sԭ�r��_��(%A0r4Y���N{�p�xA�e��>ҥ2�&�]�O$6G��p�AL� �cq��8�@8ăV�x{k)̓�קG�_���٨��������-�c{l���=�����c{l���=�����c����	헰� P  