revokeDatabaseAccess
----------------------

Name
~~~~

revokeDatabaseAccess - Triggers a service-specific script for removing database access to a client.

Synopsis
~~~~~~~~

revokeDatabaseAccess SERVICE_ID CONFIG_FILE 

Description
~~~~~~~~~~~

Invokes the script /mnt/services/$SERVICE_ID/bin/enstratus-dbrevoke, if existent, to remove access to a database from another server.


Options
~~~~~~~

SERVICE_ID
	ID of the service. It's provided by enStratus. Service images are stored in /mnt/services/$SERVICE_ID


CONFIG_FILE
	Configuration file provided by enStratus. It contains information required to revoke access to a data source, like the remote server IP, database name and credentials .


Examples
~~~~~~~~

revokeDatabaseAccess a123 /enstratus/ws/tomcat/temp/database6625343243682788319.cfg


Invocation
~~~~~~~~~~

This script is called automatically by enStratus during a deployment when a server that had been granted access to a datasource no longer exists.


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
