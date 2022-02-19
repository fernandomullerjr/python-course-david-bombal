# Neste programa o NAPALM só vai auditar a ACL e imprimir as diferenças entre o arquivo de ACL1.cfg e a ACL 100 no equipamento
import json
from napalm import get_network_driver
driver = get_network_driver('ios')
iosvl2 = driver('192.168.122.72', 'fernando', 'nemsei90')
iosvl2.open()

print ('Accessing 192.168.122.72')
iosvl2.load_merge_candidate(filename='/root/ACL1.cfg')

diffs = iosvl2.compare_config()
if len(diffs) > 0:
    f = open("testfile2.txt", "w")
    f.write(diffs)
    f.close()
else:
    print('No changes required.')
    iosvl2.discard_config()

iosvl2.close()