#Telnet Example

#A simple example illustrating typical use:

import getpass
import telnetlib

HOST = "192.168.122.71"
user = input("Enter your telnet username: ")
password = getpass.getpass()

tn = telnetlib.Telnet(HOST)

tn.read_until(b"Username: ")
tn.write(user.encode('ascii') + b"\n")
if password:
    tn.read_until(b"Password: ")
    tn.write(password.encode('ascii') + b"\n")

tn.write(b"enable\n")
tn.write(b"nemsei90\n")
tn.write(b"conf t\n")
tn.write(b"interface loopback 33\n")
tn.write(b"ip address 3.3.3.3 255.255.255.255\n")
tn.write(b"interface loopback 44\n")
tn.write(b"ip address 4.4.4.4 255.255.255.255\n")
tn.write(b"router ospf 1\n")
tn.write(b"network 0.0.0.0 255.255.255.255 area 0\n")
tn.write(b"end\n")
tn.write(b"exit\n")

print(tn.read_all().decode('ascii'))