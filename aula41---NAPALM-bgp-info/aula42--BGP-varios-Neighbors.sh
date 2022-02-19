

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!! #### Usando a topologia do GNS3 "Topologia-3-BGP"
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


################  Configurando o BGP:

-No sw1
conf t
router bgp 65000
neighbor 192.168.122.74 remote-as 65001


-Sessão BGP não é estabelecida, visto que o BGP não está configurado no outro lado:

S1#show ip bgp sum
BGP router identifier 1.1.1.1, local AS number 65000
BGP table version is 4, main routing table version 4
3 network entries using 432 bytes of memory
3 path entries using 240 bytes of memory
2/2 BGP path/bestpath attribute entries using 304 bytes of memory
0 BGP route-map cache entries using 0 bytes of memory
0 BGP filter-list cache entries using 0 bytes of memory
BGP using 976 total bytes of memory
BGP activity 3/0 prefixes, 3/0 paths, scan interval 60 secs

Neighbor        V           AS MsgRcvd MsgSent   TblVer  InQ OutQ Up/Down  State/PfxRcd
192.168.122.71  4        65000      14      14        4    0    0 00:09:49        2
192.168.122.74  4        65001       0       0        1    0    0 never    Active
S1#




-Executar o script da aula41:

root@NetworkAutomation-1:~# cat aula41-NAPALM-BGP-info.py
import json
from napalm import get_network_driver
driver = get_network_driver('ios')
iosvl2 = driver('192.168.122.72', 'fernando', 'nemsei90')
iosvl2.open()

bgp_neighbors = iosvl2.get_bgp_neighbors()
print (json.dumps(bgp_neighbors, indent=4))

iosvl2.close()
root@NetworkAutomation-1:~#



-Saída do script em JSON, informando os detalhes das sessões BGP, inclusive da que foi configurada agora e não estabeleceu:

root@NetworkAutomation-1:~# python3 aula41-NAPALM-BGP-info.py
{
    "global": {
        "router_id": "1.1.1.1",
        "peers": {
            "192.168.122.71": {
                "local_as": 65000,
                "remote_as": 65000,
                "remote_id": "2.2.2.2",
                "is_up": true,
                "is_enabled": true,
                "description": "",
                "uptime": 479,
                "address_family": {
                    "ipv4 unicast": {
                        "received_prefixes": 2,
                        "accepted_prefixes": 2,
                        "sent_prefixes": 1
                    }
                }
            },
            "192.168.122.74": {
                "local_as": 65000,
                "remote_as": 65001,
                "remote_id": "0.0.0.0",
                "is_up": false,
                "is_enabled": true,
                "description": "",
                "uptime": -1,
                "address_family": {
                    "ipv4 unicast": {
                        "received_prefixes": -1,
                        "accepted_prefixes": -1,
                        "sent_prefixes": -1
                    }
                }
            }
        }
    }
}
root@NetworkAutomation-1:~#
