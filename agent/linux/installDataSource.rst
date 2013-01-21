installDataSource
--------------------

Name
~~~~
installDataSource - Installs the selected data source.

Synopsis
~~~~~~~~

installDataSource SERVICE_ID CONFIG_FILE IMAGE_FILE

Description
~~~~~~~~~~~

It invokes the script /mnt/services/$SERVICE_ID/bin/enstratus-installds , if
existent, to install a Data Source. enstratus-installDataSource is usually an ad-hoc script
included in the service image to install a specific kind of data source.

Options
~~~~~~~~

SERVICE_ID
  ID of the service to be installed. It's provided by enstratus. Service images are stored
  in /mnt/services/$SERVICE_ID

CONFIG_FILE
  Configuration file provided by enstratus. It contains information required to perform 
  the installation, such as credentials.

IMAGE_FILE
  Temporary file name containing the data source image.

Examples
~~~~~~~~

installDataSource a123 /mnt/services/a123/cfg/enstratus.cfg /mnt/tmp/123~testds~YYYYMMDD~ID.zip


Invocation
~~~~~~~~~~

This script is called automatically by enstratus during a deployment start for services with a data source.


Dependencies
~~~~~~~~~~~~

* None

Permission
~~~~~~~~~~

It is called by the enstratus user.


Overrides
~~~~~~~~~

Override: No

Replace: No
