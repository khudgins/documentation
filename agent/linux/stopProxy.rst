stopProxy
-----------

NAME
~~~~

stopProxy - Removes a node from a load balancer.

SYNOPSIS
~~~~~~~~

stopProxy IP_ADDRESS 

DESCRIPTION
~~~~~~~~~~~

stopProxy is a generic wrapper script to remove nodes from a software load balancer (HAProxy, Zeus or Apache mod_jk).

OPTIONS
~~~~~~~

IP_ADDRESS
	IP Address of the node to be removed from the load balancing.

INVOCATION
~~~~~~~~~~

This script is called in static or dynamic Load Balancers every time a node stops belonging to the configured tier.

DEPENDENCIES
~~~~~~~~~~~~

* None

PERMISSIONS
~~~~~~~~~~~

It is launched by the Enstratius user.


OVERRIDES
~~~~~~~~~

Override: Yes, pre and post

Replace: Yes
