startService
----------------

Name
~~~~
startService - Starts the selected service.

Synopsis
~~~~~~~~

startService SERVICE_ID

Description
~~~~~~~~~~~

It starts the selected service by invoking the /mnt/services/$SERVICE_ID/bin/enstratus-start custom script included in the service image.

Options
~~~~~~~~

SERVICE_ID
  ID of the service to be started.

Examples
~~~~~~~~

startService a123 


Invocation
~~~~~~~~~~

This script is called automatically by enstratus during the deployment start for services with a service image.


Dependencies
~~~~~~~~~~~~

* None.

Permission
~~~~~~~~~~

It is called by the enstratus user.


Overrides
~~~~~~~~~

Override: No

Replace: No
