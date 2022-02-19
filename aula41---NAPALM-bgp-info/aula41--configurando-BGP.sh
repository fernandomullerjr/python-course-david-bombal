

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!! #### Usando a topologia do GNS3 "Topologia-3-BGP"
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


################  Configurando o BGP:

-No sw1
conf t
router bgp 65000
neighbor 192.168.122.71 remote-as 65000

-No r1
conf t
router bgp 65000
neighbor 192.168.122.72 remote-as 65000



S1#show ip bgp
% BGP not active

S1#


-Removendo neighbor obsoleto:
conf t
router bgp 65000
no neighbor 192.168.122.73 remote-as 65000



S1#show ip bgp sum
BGP router identifier 1.1.1.1, local AS number 65000
BGP table version is 1, main routing table version 1

Neighbor        V           AS MsgRcvd MsgSent   TblVer  InQ OutQ Up/Down  State/PfxRcd
192.168.122.71  4        65000       5       5        1    0    0 00:01:18        0
S1#


-Anunciando rotas no BGP:
-No R1:
conf t
router bgp 65000
neighbor 192.168.122.72 remote-as 65000
network 192.168.122.0 mask 255.255.255.0




-Conferindo que o sw1 recebeu 1 prefixo:

S1#show ip bgp sum
BGP router identifier 1.1.1.1, local AS number 65000
BGP table version is 2, main routing table version 2
1 network entries using 144 bytes of memory
1 path entries using 80 bytes of memory
1/1 BGP path/bestpath attribute entries using 152 bytes of memory
0 BGP route-map cache entries using 0 bytes of memory
0 BGP filter-list cache entries using 0 bytes of memory
BGP using 376 total bytes of memory
BGP activity 1/0 prefixes, 1/0 paths, scan interval 60 secs

Neighbor        V           AS MsgRcvd MsgSent   TblVer  InQ OutQ Up/Down  State/PfxRcd
192.168.122.71  4        65000      17      16        2    0    0 00:10:57        1
S1#



-Criar loopback no R1 e anunciar no BGP:
conf t
interface loopback 0
ip address 2.2.2.2 255.255.255.255 
no shut
end
wr
conf t
router bgp 65000
neighbor 192.168.122.72 remote-as 65000
network 2.2.2.2 mask 255.255.255.255
end
wr



-Criar loopback no sw1 e anunciar no BGP:
conf t
interface loopback 0
ip address 1.1.1.1 255.255.255.255 
no shut
end
wr
conf t
router bgp 65000
neighbor 192.168.122.71 remote-as 65000
network 1.1.1.1 mask 255.255.255.255
end
wr




-Prefixos sendo recebidos:

S1#show ip bgp
BGP table version is 4, local router ID is 1.1.1.1
Status codes: s suppressed, d damped, h history, * valid, > best, i - internal,
              r RIB-failure, S Stale, m multipath, b backup-path, f RT-Filter,
              x best-external, a additional-path, c RIB-compressed,
Origin codes: i - IGP, e - EGP, ? - incomplete
RPKI validation codes: V valid, I invalid, N Not found

     Network          Next Hop            Metric LocPrf Weight Path
 *>  1.1.1.1/32       0.0.0.0                  0         32768 i
 *>i 2.2.2.2/32       192.168.122.71           0    100      0 i
 r>i 192.168.122.0    192.168.122.71           0    100      0 i
S1#

R1#show ip bgp sum
BGP router identifier 2.2.2.2, local AS number 65000
BGP table version is 4, main routing table version 4
3 network entries using 432 bytes of memory
3 path entries using 240 bytes of memory
2/2 BGP path/bestpath attribute entries using 304 bytes of memory
0 BGP route-map cache entries using 0 bytes of memory
0 BGP filter-list cache entries using 0 bytes of memory
BGP using 976 total bytes of memory
BGP activity 3/0 prefixes, 3/0 paths, scan interval 60 secs

Neighbor        V           AS MsgRcvd MsgSent   TblVer  InQ OutQ Up/Down  State/PfxRcd
192.168.122.72  4        65000      14      15        4    0    0 00:10:07        1
R1#show ip bgp
BGP table version is 4, local router ID is 2.2.2.2
Status codes: s suppressed, d damped, h history, * valid, > best, i - internal,
              r RIB-failure, S Stale, m multipath, b backup-path, f RT-Filter,
              x best-external, a additional-path, c RIB-compressed,
Origin codes: i - IGP, e - EGP, ? - incomplete
RPKI validation codes: V valid, I invalid, N Not found

     Network          Next Hop            Metric LocPrf Weight Path
 r>i 1.1.1.1/32       192.168.122.72           0    100      0 i
 *>  2.2.2.2/32       0.0.0.0                  0         32768 i
 *>  192.168.122.0    0.0.0.0                  0         32768 i
R1#


-Saída do script aula41-NAPALM-BGP-info.py, que coleta as informações usando o NAPALM e formata usando o JSON:

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
                "uptime": 659,
                "address_family": {
                    "ipv4 unicast": {
                        "received_prefixes": 2,
                        "accepted_prefixes": 2,
                        "sent_prefixes": 1
                    }
                }
            }
        }
    }
}
root@NetworkAutomation-1:~#
