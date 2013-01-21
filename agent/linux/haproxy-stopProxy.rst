haproxy-stopProxy
-------------------

NAME
~~~~

haproxy-stopProxy - Removes a node from HAProxy.

SYNOPSIS
~~~~~~~~

haproxy-stopProxy IP_ADDRESS 

DESCRIPTION
~~~~~~~~~~~

It removes the selected node from HAProxy configuration and reloads the service.

OPTIONS
~~~~~~~

IP_ADDRESS
	IP Address of the node to be removed from HAProxy.

INVOCATION
~~~~~~~~~~

This script is called in static or dynamic Load Balancers every time a node stops belonging to the configured tier.

DEPENDENCIES
~~~~~~~~~~~~

* None

PERMISSIONS
~~~~~~~~~~~

It is launched by the enStratus user.


OVERRIDES
~~~~~~~~~

Override: No.

Replace: No.
