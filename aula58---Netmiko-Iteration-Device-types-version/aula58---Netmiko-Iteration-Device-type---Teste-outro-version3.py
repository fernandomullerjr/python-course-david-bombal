from getpass import getpass
from netmiko import ConnectHandler
from netmiko.ssh_exception import NetMikoTimeoutException
from paramiko.ssh_exception import SSHException
from netmiko.ssh_exception import AuthenticationException

username = input('Digite o seu usuario SSH: ')
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
    print ('Connecting to device" ' + devices)
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
        print ('Authentication failure: ' + ip_address_of_device)
        continue
    except (NetMikoTimeoutException):
        print ('Timeout to device: ' + ip_address_of_device)
        continue
    except (EOFError):
        print ('End of file while attempting device ' + ip_address_of_device)
        continue
    except (SSHException):
        print ('SSH Issue. Are you sure SSH is enabled? ' + ip_address_of_device)
        continue
    except Exception as unknown_error:
        print ('Some other error: ' + str(unknown_error))
        continue

    list_versions = ['teste3', 
                     'prod_rel_team',
                     'C1900-UNIVERSALK9-M',
                     'C3750-ADVIPSERVICESK9-M'
                     ]

    for software_ver in list_versions:
        print ('Checking for ' + software_ver)
        output_version = net_connect.send_command('show version')
        int_version = 0
        int_version = output_version.find(software_ver)
        if int_version > 0:
            print ('Software version found: ' + software_ver)
            break
        else:
            print ('Did not find ' + software_ver)
            software_ver = 'VersaoNaoEncontrada'

    if software_ver == 'teste3':
        print ('Running ' + software_ver + ' commands')
        output = net_connect.send_config_set(commands_list_switch)
    elif software_ver == 'prod_rel_team':
        print ('Running ' + software_ver + ' commands')
        output = net_connect.send_config_set(commands_list_router)
    elif software_ver == 'C1900-UNIVERSALK9-M':
        print ('Running ' + software_ver + ' commands')
        output = net_connect.send_config_set(commands_list_phyrouter)
    elif software_ver == 'C3750-ADVIPSERVICESK9-M':
        print ('Running ' + software_ver + ' commands')
        output = net_connect.send_config_set(commands_list_switch)
    else:
        print ('Nao foi executado devido a versao ' + software_ver)
        output = 'Saida vazia, pois nao atendeu a condicional.'
    print (output)