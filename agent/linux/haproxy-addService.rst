haproxy-addService
--------------------

NAME
~~~~

haproxy-addService - Adds the selected node to HAProxy configuration.


SYNOPSIS
~~~~~~~~

haproxy-addService $SERVICE_ID $REMOTE_ADDRESS $REMOVE_PORT $HAPCFG

DESCRIPTION
~~~~~~~~~~~

It adds the specified IP to the list of backend server in HAProxy configuration file.


OPTIONS
~~~~~~~

SERVICE
	Id of the service. 
REMOTE_ADDRESS
	IP address of the node to be added. 
REMOTE_PORT
	TCP port to forward to the remote node.
HAPCFG
	Path of the HAProxy configuration file.


INVOCATION
~~~~~~~~~~

This script is called by haproxy-startProxy as a part of the HAProxy configuration.

DEPENDENCIES
~~~~~~~~~~~~

* HAProxy

PERMISSIONS
~~~~~~~~~~~

It is launched by the enStratus user. It uses sudo to edit the /etc/default/haproxy configuration file.

OVERRIDES
~~~~~~~~~

Override: No

Replace: No
