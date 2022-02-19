# aula28-Netmiko-Multiple-devices

from netmiko import ConnectHandler

iosv_l2_s1 = {
    'device_type': 'cisco_ios',
    'ip': '192.168.122.72',
    'username': 'david',
    'password': 'cisco' # A virgula não é necessária porque esse item é a última entrada do dicionário!!!
}

iosv_l2_s2 = {
    'device_type': 'cisco_ios',
    'ip': '192.168.122.82',
    'username': 'david',
    'password': 'cisco' # A virgula não é necessária porque esse item é a última entrada do dicionário!!!
}

iosv_l2_s3 = {
    'device_type': 'cisco_ios',
    'ip': '192.168.122.83',
    'username': 'david',
    'password': 'cisco' # A virgula não é necessária porque esse item é a última entrada do dicionário!!!
}

all_devices = [iosv_l2_s1, iosv_l2_s2, iosv_l2_s3]

for devices in all_devices:
    net_connect = ConnectHandler(**devices)
    for n in range (2,21):
        print ("Creating VLAN " + str(n))
        config_commands = ['vlan ' + str(n), 'name Python_VLAN ' + str(n)]
        output = net_connect.send_config_set(config_commands)
        print (output)