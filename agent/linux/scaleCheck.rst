scaleCheck
------------

NAME
~~~~

scaleCheck - Custom scaling script

SYNOPSIS
~~~~~~~~

scaleCheck 

DESCRIPTION
~~~~~~~~~~~

For servers in a tier configured to use Custom scaling rules, the scaleCheck script 
reports the current server's vote to trigger an scaling event.
By default scaleCheck is a place-holder that needs to be tailored according to the
scaling rules to be implemented. enStratus will use the return code of the script 
to determine the need for a scale up or down event:

* 1 : The tier should scale up
* -1 : The tier should scale down
* 0 : No scaling necessary.

For a lengthier explanation on the auto scaling mechanism in deployment check http://docs.enstratus.com/automation/deployment_configuration/tier.html .

OPTIONS
~~~~~~~

None.

INVOCATION
~~~~~~~~~~

This script is called periodically by enStratus in servers within a tier set to use Custom scaling rules.


DEPENDENCIES
~~~~~~~~~~~~

None

PERMISSIONS
~~~~~~~~~~~

It is launched by the enStratus user.


OVERRIDES
~~~~~~~~~

Override: None

Replace: None
