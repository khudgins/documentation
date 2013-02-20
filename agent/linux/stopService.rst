stopService
------------

Name
~~~~
stopService - Stops the selected service.

Synopsis
~~~~~~~~

stopService SERVICE_ID

Description
~~~~~~~~~~~

Stops the selected service by invoking the /mnt/services/$SERVICE_ID/bin/enstratus-stop custom script included in the service image.

Options
~~~~~~~~

SERVICE_ID
  ID of the service to be started.

Examples
~~~~~~~~

stopService a123 


Invocation
~~~~~~~~~~

This script is called automatically by enStratus when the server stops beings assoiated to the service, for instance when the deployment or server is terminated.

Dependencies
~~~~~~~~~~~~

* None.

Permission
~~~~~~~~~~

It is called by the enStratus user.

Overrides
~~~~~~~~~

Override: No

Replace: No
