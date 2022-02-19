import codecs
from getpass import getpass
from netmiko import ConnectHandler
from netmiko.ssh_exception import NetMikoTimeoutException
from paramiko.ssh_exception import SSHException
from netmiko.ssh_exception import AuthenticationException
import os
import locale


username = input('Digite o seu usuário SSH: ')
password = getpass('Digite sua senha: ')

with open('commands_file_switch') as f:
    commands_list_switch = f.read().splitlines()

with open('commands_file_router') as f:
    commands_list_router = f.read().splitlines()

with open('commands_file_phyrouter') as f:
    commands_list_phyrouter = f.read().splitlines()

with open('devices_file') as f:
    devices_list = f.read().splitlines()

for devices in devices_list:
    print ('Conectando no dispositivo:" ' + devices)
    ip_address_of_device = devices
    ios_device = {
        'device_type': 'cisco_ios',
        'ip': ip_address_of_device, 
        'username': username,
        'password': password
    }

    try:
        net_connect = ConnectHandler(**ios_device)
    except (AuthenticationException):
        print ('Falha de autenticação: ' + ip_address_of_device)
        continue
    except (NetMikoTimeoutException):
        print ('Dispositivo apresentou Timeout: ' + ip_address_of_device)
        continue
    except (EOFError):
        print ('Fim do arquivo enquanto tenta o dispositivo ' + ip_address_of_device)
        continue
    except (SSHException):
        print ('Problema no SSH. O SSH está habilitado? ' + ip_address_of_device)
        continue
    except Exception as unknown_error:
        print ('Algum outro erro: ' + str(unknown_error))
        continue

    list_versions = {'teste3' : 'commands_list_switch', 
                     'prod_rel_team' : 'commands_list_router',
                     'C1900-UNIVERSALK9-M' : 'commands_list_phyrouter',
                     'C3750-ADVIPSERVICESK9-M' : 'commands_list_switch'
                    }

    for software_ver in list_versions:
        print ('Checking for ' + software_ver)
        output_version = net_connect.send_command('show version')
        int_version = 0
        int_version = output_version.find(software_ver)
        if int_version > 0:
            print ('Software version found: ' + software_ver)
            print ('Running ' + software_ver + ' commands')
            output = net_connect.send_config_set(list_versions[software_ver])
            print (output)
            break
        else:
            print ('Did not find ' + software_ver)