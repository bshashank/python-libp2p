"""
TODO: implement this?

mDNS or Multicast DNS can be used to discover services on the local network
without the use of an authoritative DNS server. This enables peer-to-peer
discovery. It is important to note that many networks restrict the use of
multicasting, which prevents mDNS from functioning. Notably, multicast cannot
be used in any sort of cloud, or shared infrastructure environment. However it
works well in most office, home, or private infrastructure environments.
"""

from _router import PeerRouter

class mdnsRouter(PeerRouter):
    pass
