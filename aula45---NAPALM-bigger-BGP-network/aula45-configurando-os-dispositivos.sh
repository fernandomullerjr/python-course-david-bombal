

-Configurar usuários, configurar modo de conexão e gerar chave rsa:

enable
nemsei90
conf t
username fernando password nemsei90
username fernando priv 15
username datacenter password nemsei90
username datacenter priv 15
enable secret nemsei90
line vty 0 4
login local
transport input all
ip domain-name cciepython.com
crypto key generate rsa
1024
end
wr


#! -No Roteador r1:

conf t
hostname r1
interface gig0/0
ip address 192.168.122.167 255.255.255.0
no shutdown
interface gig0/1
ip address 17.1.1.1 255.255.255.0
no shutdown
router bgp 65001
neighbor 17.1.1.2 remote-as 65001
network 192.168.122.0 mask 255.255.255.0
network 17.1.1.0 mask 255.255.255.0
end
wr

#! -No Roteador r2:

conf t
hostname r2
interface gig0/1
ip address 17.1.1.2 255.255.255.0
no shutdown
interface gig0/2
ip address 8.8.8.1 255.255.255.252
no shutdown
router bgp 65001
neighbor 17.1.1.1 remote-as 65001
neighbor 8.8.8.2 remote-as 65002
network 17.1.1.0 mask 255.255.255.0
network 8.8.8.0 mask 255.255.255.252
end
wr


#! -No Roteador r3:

conf t
hostname r3
interface gig0/3
ip address 15.1.1.1 255.255.255.0
no shutdown
interface gig0/2
ip address 8.8.8.2 255.255.255.252
no shutdown
router bgp 65002
neighbor 8.8.8.1 remote-as 65001
neighbor 15.1.1.2 remote-as 65002
network 15.1.1.0 mask 255.255.255.0
network 8.8.8.0 mask 255.255.255.252
end
wr

#! -No Roteador r4:

conf t
hostname r4
interface gig0/3
ip address 15.1.1.2 255.255.255.0
no shutdown
router bgp 65002
neighbor 15.1.1.1 remote-as 65002
network 15.1.1.0 mask 255.255.255.0
end
wr



-Rota estática adicionada no Ubuntu, para alcançar o roteador no AS 65001:

route add -net 17.1.1.0 netmask 255.255.255.0 gw 192.168.122.167




post-up route add -net 17.1.1.0 netmask 255.255.255.0 gw 192.168.122.167


root@Ubuntu-1:~# python3 aula45---NAPALM-bigger-network.py
Traceback (most recent call last):
  File "aula45---NAPALM-bigger-network.py", line 2, in <module>
    from napalm import get_network_driver
ImportError: No module named 'napalm'
root@Ubuntu-1:~#


ImportError: No module named 'napalm'
pip3 install napalm