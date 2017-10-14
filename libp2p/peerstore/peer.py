from base58 import b58encode

class PeerId(object):
    """
    An object used to represent peers in the IPFS network.
    """
    def __init__(self, id_, public_key, private_key):
        self.id = id_
        self.public_key = public_key
        self.private_key = private_key

    def id_b58_encode(self):
        """Return b58-encoded string"""
        return b58encode(bytes(self.id))


class PeerInfo(object):
    """
    Key information about a peer in the system.

    PeerInfo is a small struct used to pass around a peer with a set of
    addresses (and later, keys?). This is not meant to be a complete view of
    the system, but rather to model updates to the peerstore. It is used by
    things like the routing system.

    Args:
      peerid (PeerID): A PeerID object denoting the id for the node
      multiaddrs (List): A list of Multiaddr objects
    """
    def __init__(self, peerid, multiaddrs):
        self.peerid = peerid
        self.addrs = multiaddrs
