

! Usada a topologia Topologia-3-BGP

- o recurso do NAPALM compare_config não consegue identificar se um index foi removido da ACL. Ele consegue identificar se a ACL
existe ou não nas configurações.
- Após novos testes, funcionou a identificação de um index faltante, o recurso do NAPALM compare_config conseguiu 
adicionar o index que foi removido.



Extended IP access list 100
    10 permit icmp any any
    30 permit tcp any any eq www
    40 permit tcp any any eq 443
    50 permit tcp any any eq domain
S1#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
S1(config)#ip access
S1(config)#ip access-list ex
S1(config)#ip access-list extended 100
S1(config-ext-nacl)#no 50
S1(config-ext-nacl)#


conf t
ip access-list extended 100
no 20
no 30
no 40
no 50