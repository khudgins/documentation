terminate
----------

NAME
~~~~

terminate - Stops Enstratius agent and installed services.

SYNOPSIS
~~~~~~~~

terminate

DESCRIPTION
~~~~~~~~~~~

Triggers orderly termination of existing services in /mnt/services and the Enstratius agent.

OPTIONS
~~~~~~~

None.

INVOCATION
~~~~~~~~~~

This script is called when by Enstratius before shutting down a server.


DEPENDENCIES
~~~~~~~~~~~~

* sudo

PERMISSIONS
~~~~~~~~~~~

Launched by the Enstratius user. It needs sudo authority for creating the user.


OVERRIDES
~~~~~~~~~

Override: No

Replace: Yes
