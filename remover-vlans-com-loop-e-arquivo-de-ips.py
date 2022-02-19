#remover-vlans-com-loop-e-arquivo-de-ips.py - Script que executa a remoção das VLANs de 2 a 90, usando um loop e acessando os Switches mencionados
#no arquivo myswitches
import getpass
import telnetlib

HOST = "localhost"
user = input("Enter your remote account: ")
password = getpass.getpass()

f = open ('myswitches')

for IP in f:
    IP=IP.strip()
    print ("Configuring Switch " + (IP))
    HOST = IP
    tn = telnetlib.Telnet(HOST)
    tn.read_until(b"Username: ")
    tn.write(user.encode('ascii') + b"\n")
    if password:
        tn.read_until(b"Password: ")
        tn.write(password.encode('ascii') + b"\n")

    tn.write(b"enable\n")
    tn.write(b"nemsei90\n")
    tn.write(b"conf t\n")

    for n in range (2,91):
        tn.write(b"no vlan " + str(n).encode('ascii') + b"\n")

    tn.write(b"end\n")
    tn.write(b"wr\n")
    tn.write(b"exit\n")
    print(tn.read_all().decode('ascii'))