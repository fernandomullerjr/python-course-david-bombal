import json
from napalm import get_network_driver
driver = get_network_driver('ios')
iosvl2 = driver('192.168.122.72', 'fernando', 'nemsei90')
iosvl2.open()

print ('Accessing 192.168.122.72')
iosvl2.load_merge_candidate(filename='/root/ACL1.cfg')
iosvl2.commit_config()
iosvl2.close()