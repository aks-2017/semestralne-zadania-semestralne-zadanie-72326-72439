#!/usr/bin/python

from mininet.cli import CLI
from mininet.log import setLogLevel
from mininet.net import Mininet
from mininet.topo import Topo
from mininet.node import RemoteController, OVSSwitch
from mininet.link import TCLink
from mininet.node import CPULimitedHost

#parameters
linkopts = dict(bw=6, delay='40ms', max_queue_size=240)


class SizingBuffersTopo( Topo ):
    "Minimal topology with a single switch and two hosts"

    def build( self ):
        # Create hosts.
        h1 = self.addHost( 'h1' )
        h2 = self.addHost( 'h2' )
        h3 = self.addHost( 'h3' )
        h4 = self.addHost( 'h4' )
        h5 = self.addHost( 'h5' )
        h6 = self.addHost( 'h6' )
	      h7 = self.addHost( 'h7' )
	      h8 = self.addHost( 'h8' )
      	h9 = self.addHost( 'h9' )
      	h10 = self.addHost( 'h10' )	
	server = self.addHost( 'server' )


        # Create a switch
        s1 = self.addSwitch( 's1' )
        s2 = self.addSwitch( 's2' )

        # Add links between the switch and each host
        l1 = self.addLink( s1, h1 )
        l2 = self.addLink( s1, h2 )
        l3 = self.addLink( s1, h3 )
        l4 = self.addLink( s1, h4 )
        l5 = self.addLink( s1, h5 )
        l6 = self.addLink( s1, h6 )
	      l7 = self.addLink( s1, h7 )
	      l8 = self.addLink( s1, h8 )
	l9 = self.addLink( s1, h9 )
	l10 = self.addLink( s1, h10 )
        l11 = self.addLink( s1, s2, **linkopts )
        l12 = self.addLink( s2, server )
        
def runTopo():
    "Bootstrap a Mininet network using the Minimal Topology"
 
    # Create an instance of our topology
    topo = SizingBuffersTopo()
 
    # Create a network based on the topology using OVS and controlled by
    # a remote controller.
    net = Mininet(
        topo=topo, link=TCLink )
 
    # Actually start the network
    net.start()
    
    # Drop the user in to a CLI so user can run commands.
    CLI( net )
 
    # After the user exits the CLI, shutdown the network.
    net.stop()
 
if __name__ == '__main__':
    # This runs if this file is executed directly
    setLogLevel( 'info' )
    runTopo()


# Allows the file to be imported using `mn --custom <filename> --topo minimal`
topos = {
    'buffers': SizingBuffersTopo
}



