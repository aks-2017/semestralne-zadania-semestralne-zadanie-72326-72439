This directory contains SDN files:
* scripts

Walkthrough - setup VM Mininet Topology:
* install Mininet VM
* in Mininet VM install Ryu controller
* connect via SSH, user/passwd - ```mininet/mininet```
* start Ryu controller -> ```ryu-manager ryu.app.simple_switch_13 ryu.app.ofctl_rest```
* start Mininet custom topology -> ```sudo mn --custom toplogy_file.py --topo topology_name --mac --switch ovs,protocols=OpenFlow13 --controller remote```
