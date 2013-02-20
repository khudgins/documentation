installService
----------------

Name
~~~~
installService - Installs the selected service image.

Synopsis
~~~~~~~~

installService SERVICE_ID CUSTOMER_ID USER_ID RESTORE_FILE

Description
~~~~~~~~~~~

Uncompresses the service image file to /mnt/services/$SERVICE_ID, and assigns the proper
ownership and permission to its content.

Options
~~~~~~~~

SERVICE_ID
  ID of the service to be installed. It's provided by enStratus. Service images are stored
  in /mnt/services/$SERVICE_ID

CUST_ID
	Customer id within enStratus.

USER_ID
	User name that will own service image files.

SERVICE_IMAGE_FILE
	Temporary compressed file containing the service image. Supported formats are tar.gz, tar.bz2, .tgz and .zip .

Examples
~~~~~~~~

installService a123 c100 c200 /mnt/tmp/service-YYYYMMDD~ID.zip


Invocation
~~~~~~~~~~

This script is called automatically by enStratus during the deployment start for services with a service image.


Dependencies
~~~~~~~~~~~~

The server requires support for uncompressing the service image file (ie unzip/gzip/bzip2)

Permission
~~~~~~~~~~

It is called by the enstratus user.


Overrides
~~~~~~~~~

Override: No

Replace: No
