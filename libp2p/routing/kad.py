"""
kad-routing implements the Kademlia Routing table, where each peer holds a set
of k-buckets, each of them containing several PeerInfo objects from other peers
in the network.
"""
from _router import PeerRouter

class KadRouter(PeerRouter):
    """
    This implemenation is mostly from:
      https://github.com/libp2p/js-libp2p-kad-routing/blob/master/src/index.js
    """

    def __init__(self, peer_id, k_bucket_size=20):
        self.peer_id = peer_id
        self.k_bucket_size = k_bucket_size
