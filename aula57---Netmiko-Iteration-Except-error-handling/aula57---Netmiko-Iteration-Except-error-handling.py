#### aula57---Netmiko-Iteration-Except-error-handling
#### Neste script usando o Error Handling o script trata alguns cenários de erros, apresentando uma mensagem se encontrar algum erro
#### Caso o device esteja com problemas, ele segue para o próximo device, evitando que o script quebre e pare a execução!

#!/usr/bin/env python

from getpass import getpass
from netmiko import ConnectHandler
from netmiko.ssh_exception import NetMikoTimeoutException
from paramiko.ssh_exception import SSHException
from netmiko.ssh_exception import AuthenticationException

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
######## We're going to use try an exception handling to continue running the script. So if we can't connect to 
######## one device, we'll just take note of that by printing, for instance, and
######## authentication error message, but then will continue running the rest of the program.
########  Python uses exceptions.
########  In other words, code that is executed when an associated error occurs, we going to run this code if a specific 
# error occurs, in this case, authentication, or in this case, a timeout. It's good practice to add exception handling to 
# your scripts, especially when you have to connect to a remote device that may be turned off or where there's an authentication problem.
# You don't want your entire script to break.
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
# If there are no errors, this entire code will be skipped and the commands list will be run against
    output = net_connect.send_config_set(commands_list)
    print (output)