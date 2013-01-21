terminate
----------

NAME
~~~~

terminate - Stops enStratus agent and installed services.

SYNOPSIS
~~~~~~~~

terminate

DESCRIPTION
~~~~~~~~~~~

It orderly terminates existing services in /mnt/services, and the enStratus agent.

OPTIONS
~~~~~~~

None.

INVOCATION
~~~~~~~~~~

This script is called when by enStratus before shutting down a server.


DEPENDENCIES
~~~~~~~~~~~~

* sudo

PERMISSIONS
~~~~~~~~~~~

It is launched by the enStratus user. It needs sudo authority for creating the user.


OVERRIDES
~~~~~~~~~

Override: No

Replace: Yes
