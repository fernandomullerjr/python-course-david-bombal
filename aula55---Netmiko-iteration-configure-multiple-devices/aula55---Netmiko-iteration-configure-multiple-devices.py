# 55. Netmiko Iteration (Script 3): Configure multiple devices using a file of devices
# Configurando multiplos dispositivos usando uma lista de dispositivos.

from netmiko import ConnectHandler

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
        'username': 'fernando',
        'password': 'nemsei90'
    }

    net_connect = ConnectHandler(**ios_device)
    output = net_connect.send_config_set(commands_list)
    print (output)