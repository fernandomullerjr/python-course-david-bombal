###############################################################################
##### Neste script o usuario e a senha serão armazenados numa variável.
##### O usuário será solicitado no inicio do script.
##### Foi usado o modulo getpass, que esconde a senha ao perguntar a senha no prompt

from getpass import getpass
from netmiko import ConnectHandler

username = input('Digite o seu usuario SSH: ')
password = getpass('Digite sua senha: ')

with open('commands_file') as f:
    commands_list = f.read().splitlines()

with open('devices_file') as f:
    devices_list = f.read().splitlines()

for devices in devices_list:
    print ('Connecting to device" ' + devices)
    ip_address_of_device = devices
    ios_device = {
        'device_type': 'cisco_ios',
        'ip': ip_address_of_device, 
        'username': username,
        'password': password
    }

    net_connect = ConnectHandler(**ios_device)
    output = net_connect.send_config_set(commands_list)
    print (output)