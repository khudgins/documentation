haproxy-runLb
--------------

NAME
~~~~

haproxy-runLb - Configures the HAProxy service to start automatically on server restart.


SYNOPSIS
~~~~~~~~

haproxy-runLb

DESCRIPTION
~~~~~~~~~~~

It enables the HAProxy service in /etc/default/haproxy so it can be started (Ubuntu only).

OPTIONS
~~~~~~~

None.

INVOCATION
~~~~~~~~~~

This script is called by haproxy-startProxy as part of the HAProxy configuration.

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
