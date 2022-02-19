root@NetworkAutomation-1:~# python3 aula58-teste3.py
Digite o seu usuario SSH: fernando
Digite sua senha:
Connecting to device" 192.168.122.72
Checking for teste3
Did not find teste3
Checking for prod_rel_team
Did not find prod_rel_team
Checking for C1900-UNIVERSALK9-M
Did not find C1900-UNIVERSALK9-M
Checking for C3750-ADVIPSERVICESK9-M
Did not find C3750-ADVIPSERVICESK9-M
Running C3750-ADVIPSERVICESK9-M commands
configure terminal
Enter configuration commands, one per line.  End with CNTL/Z.
S1(config)#ip name-server 8.8.8.8
S1(config)#ip domain-lookup
S1(config)#vlan 10
S1(config-vlan)#name Python_VLAN_10
S1(config-vlan)#vlan 20
S1(config-vlan)#name Python_VLAN_20
S1(config-vlan)#vlan 30
S1(config-vlan)#name Python_VLAN_30
S1(config-vlan)#username suporte password datacenter
S1(config)#username avell password notebook
S1(config)#router ospf 1
S1(config-router)#network 0.0.0.0 255.255.255.255 area 0
S1(config-router)#end
S1#
Connecting to device" 192.168.122.71
Checking for teste3
Did not find teste3
Checking for prod_rel_team
Software version found: prod_rel_team
Running prod_rel_team commands
configure terminal
Enter configuration commands, one per line.  End with CNTL/Z.
R1(config)#ip name-server 8.8.8.8
R1(config)#ip domain-lookup
R1(config)#username suporte password datacenter
R1(config)#username avell password notebook
R1(config)#router ospf 1
R1(config-router)#network 0.0.0.0 255.255.255.255 area 0
R1(config-router)#interface Loopback65
R1(config-if)#ip address 65.65.65.65 255.255.255.255
R1(config-if)#interface Loopback77
R1(config-if)#ip address 65.65.65.77 255.255.255.255
R1(config-if)#end
R1#
Connecting to device" 192.168.122.81
Checking for teste3
Did not find teste3
Checking for prod_rel_team
Did not find prod_rel_team
Checking for C1900-UNIVERSALK9-M
Did not find C1900-UNIVERSALK9-M
Checking for C3750-ADVIPSERVICESK9-M
Did not find C3750-ADVIPSERVICESK9-M
Running C3750-ADVIPSERVICESK9-M commands
configure terminal
Enter configuration commands, one per line.  End with CNTL/Z.
s3(config)#ip name-server 8.8.8.8
s3(config)#ip domain-lookup
s3(config)#vlan 10
s3(config-vlan)#name Python_VLAN_10
s3(config-vlan)#vlan 20
s3(config-vlan)#name Python_VLAN_20
s3(config-vlan)#vlan 30
s3(config-vlan)#name Python_VLAN_30
s3(config-vlan)#username suporte password datacenter
s3(config)#username avell password notebook
s3(config)#router ospf 1
s3(config-router)#network 0.0.0.0 255.255.255.255 area 0
s3(config-router)#end
s3#
Connecting to device" 192.168.122.82
Timeout to device: 192.168.122.82
root@NetworkAutomation-1:~#







################ SOLUÇÃO
-Foi necessário definir um outro valor para a variável software_ver no else do laço for. Pois o laço percorre todos os valores e
o último valor estava ficando definido para software_ver.
-Além disto, foi necessário definir um valor para a variável output, pois quando o if não atende aos requisitos, a output estava ficando
sem algum valor definido e ao tentar imprimir ela ao final do código apresentava erro.


-APÓS OS AJUSTES:


root@NetworkAutomation-1:~# ^C
root@NetworkAutomation-1:~# ^C
root@NetworkAutomation-1:~# python3 aula58-teste3.py
Digite o seu usuario SSH: fernando
Digite sua senha:
Connecting to device" 192.168.122.72
Checking for teste3
Did not find teste3
Checking for prod_rel_team
Did not find prod_rel_team
Checking for C1900-UNIVERSALK9-M
Did not find C1900-UNIVERSALK9-M
Checking for C3750-ADVIPSERVICESK9-M
Did not find C3750-ADVIPSERVICESK9-M
Nao foi executado devido a versao VersaoNaoEncontrada
Saida vazia, pois nao atendeu a condicional.
Connecting to device" 192.168.122.71
Checking for teste3
Did not find teste3
Checking for prod_rel_team
Software version found: prod_rel_team
Running prod_rel_team commands
configure terminal
Enter configuration commands, one per line.  End with CNTL/Z.
R1(config)#ip name-server 8.8.8.8
R1(config)#ip domain-lookup
R1(config)#username suporte password datacenter
R1(config)#username avell password notebook
R1(config)#router ospf 1
R1(config-router)#network 0.0.0.0 255.255.255.255 area 0
R1(config-router)#interface Loopback65
R1(config-if)#ip address 65.65.65.65 255.255.255.255
R1(config-if)#interface Loopback77
R1(config-if)#ip address 65.65.65.77 255.255.255.255
R1(config-if)#end
R1#
Connecting to device" 192.168.122.81
Checking for teste3
Did not find teste3
Checking for prod_rel_team
Did not find prod_rel_team
Checking for C1900-UNIVERSALK9-M
Did not find C1900-UNIVERSALK9-M
Checking for C3750-ADVIPSERVICESK9-M
Did not find C3750-ADVIPSERVICESK9-M
Nao foi executado devido a versao VersaoNaoEncontrada
Saida vazia, pois nao atendeu a condicional.
Connecting to device" 192.168.122.82
Checking for teste3
Did not find teste3
Checking for prod_rel_team
Did not find prod_rel_team
Checking for C1900-UNIVERSALK9-M
Did not find C1900-UNIVERSALK9-M
Checking for C3750-ADVIPSERVICESK9-M
Did not find C3750-ADVIPSERVICESK9-M
Nao foi executado devido a versao VersaoNaoEncontrada
Saida vazia, pois nao atendeu a condicional.
root@NetworkAutomation-1:~# ^C
root@NetworkAutomation-1:~#
