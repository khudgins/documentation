rename
-------

NAME
~~~~

rename - Renames the server.

DESCRIPTION
~~~~~~~~~~~

Updates the hostname for the server. Additionally may re-configure other services that rely on the hostname for their proper operation.


OPTIONS
~~~~~~~

NAME
	New name for the server.

LOCAL_IP
	Local IP address.	


INVOCATION
~~~~~~~~~~

This script is called automatically on server start to set the hostname, or manually when the server is renamed from the Server List in the Enstratius console.


DEPENDENCIES
~~~~~~~~~~~~

sudo

PERMISSIONS
~~~~~~~~~~~

Launched by the Enstratius user. Needs sudo authority for updating the hostname.


OVERRIDES
~~~~~~~~~

Override: Yes, pre and post

Replace: Yes
