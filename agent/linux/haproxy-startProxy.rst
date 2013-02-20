haproxy-startProxy
--------------------

NAME
~~~~

haproxy-startProxy - Adds nodes to HAProxy.

SYNOPSIS
~~~~~~~~

haproxy-startProxy SERVICE PRIMARY_NAME SECONDARY_NAME IP_ADDRESS REMOTE_ADDRESS REMOTE_PORT [ SSL_CERT SSL_KEY SSL_CHAINED ] 

DESCRIPTION
~~~~~~~~~~~

Initially configures HAProxy for use as an http load balancer (if not already configured) and adds the selected server to the 
list of active nodes. Additionally, if the load balancer has been selected to act as an SSL terminator it configures Apache to 
unencrypt https requests and forward them to HAProxy.

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

* HAProxy
* Apache + mod_jk + mod_proxy_http for SSL termination.

PERMISSIONS
~~~~~~~~~~~

It is launched by the enStratus user.


OVERRIDES
~~~~~~~~~

Override: No

Replace: No
