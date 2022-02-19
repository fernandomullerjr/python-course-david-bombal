


###### Exemplo de teste condicional por versão do equipamento.

O script encontrou corretamente a palavra "prod_rel_team" no show version.
Porém o script está com problema, pois está executando os comandos C3750-ADVIPSERVICESK9-M em todos os equipamentos, mesmo que não
atendam a condição.

Dispositivo alterado com sucesso:
192.168.122.71


root@NetworkAutomation-1:~# python3 aula58-teste.py
Digite o seu usuario SSH: fernando
Digite sua senha:
Connecting to device" 192.168.122.72
Checking for prod_rel_team
Did not find prod_rel_team
Checking for terra
Did not find terra
Checking for C1900-UNIVERSALK9-M
Did not find C1900-UNIVERSALK9-M
Checking for C3750-ADVIPSERVICESK9-M
Did not find C3750-ADVIPSERVICESK9-M
Running C3750-ADVIPSERVICESK9-M commands
configure terminal
Enter configuration commands, one per line.  End with CNTL/Z.
S1(config)#interface Loopback65
S1(config-if)#ip address 65.65.65.65 255.255.255.255
S1(config-if)#interface Loopback77
S1(config-if)#ip address 65.65.65.77 255.255.255.255
S1(config-if)#end
S1#
Connecting to device" 192.168.122.71
Checking for prod_rel_team
Software version found: prod_rel_team
Running prod_rel_team commands
configure terminal
Enter configuration commands, one per line.  End with CNTL/Z.
R1(config)#interface Loopback65
R1(config-if)#ip address 65.65.65.65 255.255.255.255
R1(config-if)#interface Loopback77
R1(config-if)#ip address 65.65.65.77 255.255.255.255
R1(config-if)#end
R1#
Connecting to device" 192.168.122.81
Checking for prod_rel_team
Did not find prod_rel_team
Checking for terra
Did not find terra
Checking for C1900-UNIVERSALK9-M
Did not find C1900-UNIVERSALK9-M
Checking for C3750-ADVIPSERVICESK9-M
Did not find C3750-ADVIPSERVICESK9-M
Running C3750-ADVIPSERVICESK9-M commands
configure terminal
Enter configuration commands, one per line.  End with CNTL/Z.
s3(config)#interface Loopback65
s3(config-if)#ip address 65.65.65.65 255.255.255.255
s3(config-if)#interface Loopback77
s3(config-if)#ip address 65.65.65.77 255.255.255.255
s3(config-if)#end
s3#
Connecting to device" 192.168.122.82
Checking for prod_rel_team
Did not find prod_rel_team
Checking for terra
Did not find terra
Checking for C1900-UNIVERSALK9-M
Did not find C1900-UNIVERSALK9-M
Checking for C3750-ADVIPSERVICESK9-M
Did not find C3750-ADVIPSERVICESK9-M
Running C3750-ADVIPSERVICESK9-M commands
configure terminal
Enter configuration commands, one per line.  End with CNTL/Z.
s4(config)#interface Loopback65
s4(config-if)#ip address 65.65.65.65 255.255.255.255
s4(config-if)#interface Loopback77
s4(config-if)#ip address 65.65.65.77 255.255.255.255
s4(config-if)#end
s4#
root@NetworkAutomation-1:~# ^C



-Necessário verificar porque o terceiro elif continua sendo executado, mesmo sem atender a condição!






################################################################
################################################################
################################################################
################ SOLUÇÃO

-Versão ok:
aula58-teste5.py

-Foi necessário definir um outro valor para a variável software_ver no else do laço for. Pois o laço percorre todos os valores e
o último valor estava ficando definido "C3750-ADVIPSERVICESK9-M"  para software_ver.

-Além disto, foi necessário definir um valor para a variável output, pois quando o if  e os elif não atendem aos requisitos, a  variável
output estava ficando sem algum valor definido e ao tentar imprimir ela ao final do código apresentava erro.

- Ajustada a acentuação e traduzidas saídas dos prints. Foi necessário ajustar a variável de ambiente sobre o encode, devido falha de
ascii. Executado o comando "export PYTHONIOENCODING=utf-8".