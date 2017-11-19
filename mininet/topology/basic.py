#!/usr/bin/python

from mininet.cli import CLI
from mininet.log import setLogLevel
from mininet.net import Mininet
from mininet.topo import Topo
from mininet.node import RemoteController, OVSSwitch

#parameters
linkopts = dict(bw=10, delay='5ms', loss=10, max_queue_size=1000, use_htb=True)

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
	server = self.addHost( 'server' )


        # Create a switch
        s1 = self.addSwitch( 's1' )
        s2 = self.addSwitch( 's2' )

        # Add links between the switch and each host
        self.addLink( s1, h1 )
        self.addLink( s1, h2 )
        self.addLink( s1, h3 )
        self.addLink( s1, h4 )
        self.addLink( s1, h5 )
        self.addLink( s1, h6 )
        self.addLink( s1, h7 )
        self.addLink( s1, h8 )
        self.addLink( s1, s2, **linkopts )
        self.addLink( s2, server )


# Allows the file to be imported using `mn --custom <filename> --topo minimal`
topos = {
    'buffers': SizingBuffersTopo
}
