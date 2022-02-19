#Remover vlans usando a saída linha por linha, line by line, usando o read_very_eager(), TESTE !!!!!
import getpass
import telnetlib

HOST = "192.168.122.72"
user = input("Enter your telnet username: ")
password = getpass.getpass()

tn = telnetlib.Telnet(HOST)

tn.read_until(b"Username: ")
tn.write(user.encode('ascii') + b"\n")
if password:
    tn.read_until(b"Password: ")
    tn.write(password.encode('ascii') + b"\n")

tn.write(b"enable\n")
tn.write(b"nemsei90\n") #Script ficava parado dando erro, é porque a senha estava como cisco ao invés de nemsei90.
tn.write(b"conf t\n")  ### aqui já tem o conf t, não precisa de outro conf t dentro do loop

#No código abaixo o range vai ditar que o n vai de 2 até 20.
#Na linha da vlan, o script vai digitar vlan, converter o inteiro do n para string e codificar em ascii, e depois bater o enter, a letra b antes da string
#transforma ela em Bytes. Na outra linha a idéia é a mesma.
for n in range (2,21):
    tn.write(b"no vlan " + str(n).encode('ascii') + b"\n")


tn.write(b"end\n")
tn.write(b"wr\n")
tn.write(b"exit\n")

print(tn.read_very_eager())