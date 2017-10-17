class PeerRouter(object):
    def __init__(self):
        pass

    def find_peers(self, key):
        """
        A valid (read: that follows this abstraction) stream muxer, must
        implement the following API:
          Find peers 'responsible' or 'closest' to a given key

        In Node.js

            peerRouting.findPeers(key, function (err, peersPriorityQueue) {})

        In a peer to peer context, the concept of 'responsability' or
        'closeness' for a given key translates to having a way to find
        deterministically or that at least there is a significant overlap
        between searches, the same group of peers when searching for the same
        given key.

        This method will query the network (route it) and return a Priority
        Queue datastructe with a list of PeerInfo objects, ordered by
        'closeness'.

        Args:
          key: is a multihash
        """
        raise NotImplementedError
