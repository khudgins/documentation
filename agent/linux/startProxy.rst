startProxy
-----------

NAME
~~~~

startProxy - Adds nodes to a load balancer.

SYNOPSIS
~~~~~~~~

startProxy SERVICE PRIMARY_NAME SECONDARY_NAME IP_ADDRESS REMOTE_ADDRESS REMOTE_PORT [ SSL_CERT SSL_KEY SSL_CHAINED ] 

DESCRIPTION
~~~~~~~~~~~

startProxy is a generic wrapper script for adding nodes to a software load balancer (HAProxy, Zeus or Apache mod_jk).

OPTIONS
~~~~~~~

SERVICE
	Id of the service. 

PRIMARY_NAME
	Domain name.

SECONDARY_NAME
	Additional domain names, or NONE.

IP_ADDRESS
	IP Address of the load balancer.

REMOTE_ADDRESS
	IP address of the node to be added. 

REMOTE_PORT
	TCP port to forward to the remote node.

SSL_CERT
	(Optional) SSL certificate

SSL_KEY
	(Optional) SSL certificate private key

SSL_CHAINED
	(Optional) Additional CA certificate.

INVOCATION
~~~~~~~~~~

This script is called in static or dynamic Load Balancers every time a new node is added to the configured tier. 

DEPENDENCIES
~~~~~~~~~~~~

* None

PERMISSIONS
~~~~~~~~~~~

It is launched by the enStratus user.


OVERRIDES
~~~~~~~~~

Override: Yes, pre and post

Replace: Yes
