import json
from napalm import get_network_driver
driver = get_network_driver('ios')
iosv = driver('17.1.1.2', 'fernando', 'nemsei90')
iosv.open()

ios_output = iosv.get_bgp_neighbors()
print (json.dumps(ios_output, indent=4))

iosv.close()