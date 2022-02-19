import getpass
import telnetlib

user = input('Enter your telnet username: ')
password = getpass.getpass()

f = open('myswitches')

for IP in f:
    IP=IP.strip()
    print ('Get running config from Switch ' + (IP))
    HOST = IP
    tn = telnetlib.Telnet(HOST)
    tn.read_until(b'Username: ')
    tn.write(user.encode('ascii') + b'\n')
    if password:
        tn.read_until(b'Password: ')
        tn.write(password.encode('ascii') + b'\n')  
    tn.write(b"enable\n")
    tn.write(b"nemsei90\n")
    tn.write(b"terminal length 0\n")
    tn.write(b"show run\n")
    tn.write(b'exit\n')

    readoutput = tn.read_all()  # Gravar a saída dos comandos numa variável.
    saveoutput =  open("switch" + HOST, "w") # Abrir um arquivo chamado switch+IPdoEquipamento e no modo Write.
    saveoutput.write(readoutput.decode('ascii')) # Transformar a saída dos comandos no modo ASCII.
    saveoutput.write("\n") # Apertar o ENTER.
    saveoutput.close # Fechar o arquivo.