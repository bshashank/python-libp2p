libp2p for Python
=================
An experiment to see if i can understand the [specs of
libp2p](https://github.com/libp2p/specs/) protocol and then try to implement it
in python. this was forked from
[amstocker/python-libp2p](https://github.com/amstocker/python-libp2p)

This is what I want to currently **only** implements:
 - [Interface peer routing](https://github.com/libp2p/interface-peer-routing)
   A valid (read: that follows this abstraction) stream muxer, must implement
   the following API. Find peers 'responsible' or 'closest' to a given key:

    ```python
    PeerRouting.find_peers(key)
        """
        Args:
          key: key is a multihash (https://github.com/multiformats/multihash)
        Returns:
          An iterable of peers ordered by closeness
        """
    ```

    In a peer to peer context, the concept of 'responsability' or 'closeness'
    for a given key translates to having a way to find deterministically or that
    at least there is a significant overlap between searches, the same group of
    peers when searching for the same given key.

    This method will query the network (route it) and return a Priority Queue
    datastructe with a list of PeerInfo objects, ordered by 'closeness'.
