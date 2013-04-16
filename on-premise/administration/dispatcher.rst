.. _dispatcher:

Dispatcher
==========

The Enstratius Dispatcher service is a jetty service installed to /services/dispatcher.

.. figure:: ./images/dispatcher.png
   :height: 300 px
   :width: 550 px
   :scale: 70 %
   :alt: Dispatcher Service
   :align: center

   Dispatcher Service Connections

Overview
--------

The Enstratius dispatcher service is a jetty process that listens on port 3302,
configurable. It accepts connections from Enstratius components that have as an operational
requirement to interact with cloud providers, and from guest virtual machines that have
the Enstratius agent installed.

The dispatcher service is in a sense the heart of the Enstratius cloud management system.
It is responsible for carrying out the actions initiated by end users via the Enstratius
console or via the API.

When actions are taken by users, an Enstratius job is created, and a message is pushed onto
the message queue for action by the Enstratius monitor and worker systems.

The completion of a job is determined by the result discovered by the Enstratius monitor or
workers systems and depends on the type of job initiated.

When actions that require accessing cloud or other credentials stored in the credentials
database are initiated by users or triggered in an automated way, the dispatcher
service contacts the Enstratius Key Management (KM) service, which in turn access the
information contained in the credentials database.

Communication to and from the dispatcher service to the KM service is encrypted.

The dispatcher service interacts with two MySQL databases: provisioning and analytics.

Provisioning Database
---------------------

The provisioning database stores cloud-related information. As Enstratius interacts with
cloud providers, information discovered about the clouds capabilities, user subscriptions,
accounts, permissions, and infrastructure are stored in this database.

Some examples of the type of information stored in this database are:

#. Cloud "subscriptions".
 
   A cloud "subscription" is a mechanism Enstratius uses to track the capabilities provided
   by the cloud account being integrated into the Enstratius cloud management system. It is
   possible, for example, to connect an EC2 account to Enstratius that has not yet signed up
   for the Amazon S3 service. Enstratius will not present the Platform > Files option to the
   end user in this case.

   Should the administrator of the Amazon account later subscribe to the S3 service, no
   changes are required in Enstratius. Enstratius will automatically detect this change and
   present the Platform > Files option in the console. Please note that changes like this may
   take a few hours to be discovered.

#. Accounts.

   Enstratius tracks cloud accounts in the provisioning database. Each cloud account 
   connected to Enstratius will carry with it unique information such as the cloud regions 
   visible for the credentials entered and the default budget code assigned to
   infrastructure discovered.

#. Users, groups, roles.

   Enstratius stores information related to users that access the Enstratius cloud
   management system such as the user id, any groups of which the Enstratius user is a part,
   and any budget codes to which the user has access.

   The provisioning database is also where the mapping of an Enstratius group to an
   Enstratius role is made

#. Budget Codes and their state.

   The provisioning database contains information about the costs being incurred as part
   of operating in cloud environments. For example, it is possible to assign a unique cost
   identifier to a cloud product such as a server and have the operational costs tracked
   using the Enstratius budget feature.

#. Clouds

   The provisioning database contains information that defines the connection point to
   cloud providers. 

There is no inherently sensitive information stored in the provisioning database. Account
information discussed above does not include credentials. User information such as email
addresses used to access Enstratius are stored in the provisioning database.

The provisioning database must allow access from the dispatcher service, and all monitor
and worker servers.

The provisioning database should be considered to be critical to the operation of the
Enstratius cloud management system. 

Analytics Database
------------------

The Enstratius analytics database contains information gathered by Enstratius to perform
analysis of server operations and other metrics.

The analytics database must allow access from the dispatcher service, and all monitor
and worker servers.

The analytics database contains no sensitive information and should not be considered to
be critical to the operation of the Enstratius cloud management system.

Installation
------------

Installation of the Enstratius dispatcher service is best handled by using a configuration
management system such as Chef or Puppet.

Software Requirements
---------------------

The dispatcher service depends on the Open JDK and runs as a Jetty service.

Incoming Connections
--------------------

The dispatcher service is primarily responsible for carrying out the actions initiated by
users via the console or the Enstratius API.

#. Console

   The Enstratius console system connects to the dispatcher service via a webservices
   endpoint, defined on the console service in:
  
   /services/console/resources/enstratus-webservices.cfg

#. API

   The Enstratius API system connects to the dispatcher service via a webservices
   endpoint, defined on the api service in:
  
   /services/api/resources/enstratus-webservices.cfg

#. Guest VM running in a cloud that have the Enstratius agent installed will attempt to
   connect to the Enstratius dispatcher service on port 3302. This connection is defined on
   the guest VM in:

   /enstratus/ws/tomcat/webapps/ROOT/WEB-INF/classes/enstratus-webservices.cfg

   Although the communication is bi-directional, the only time a guest VM will initiate a
   connection to the Enstratius dispatcher service is upon agent start. The remainder of the
   communications are from the dispatcher to the agent.

Outgoing Connections
--------------------

#. Cloud API
   
   The dispatcher service initiates communication to the cloud provider's API to take
   actions on behalf of users utilizing the Enstratius console or API.

#. Guest VM

   The dispatcher service will initiates connections to the Enstratius agent running on
   guest VM in the cloud as necessary to trigger automated and user-initiated actions.

#. KM
   
   The dispatcher requires a connection to the Enstratius KM system to perform actions that
   require credentials. A webservices call is made to the Enstratius KM service to retrieve
   the credentials. This communication is encrypted using industry standard AES-256
   encryption.

#. Riak

   The dispatcher service connects to the Riak database to store and retrieve persistent
   information about cloud resources, among other things.

#. MySQL
 
   The dispatcher service connects to the MySQL database to store and retrieve persistent
   information about cloud resources, among other things.
   
Customizing
-----------

The service port upon which the Enstratius dispatcher service listens and the Java options it uses
to start the jetty service can be modified.

Service Port
~~~~~~~~~~~~

The service port upon which the dispatcher service operates is defined in:

/services/dispatcher/bin/dispatcher

Logging
-------

Logging for the dispatcher service is done to:

``/services/dispatcher/logs/YYYY_MM_DD.request.log``

``/services/dispatcher/logs/dispatcher.log``

``/etc/service/enstratus-dispatcher/log/main/current``

.. _dispatcher_backups:

Backups
-------

Service
~~~~~~~

The Enstratius dispatcher service files should be backed up before and after any changes, and
once/day during steady-state operations. An example of a backup is shown here, excluding
the log files in this case.

.. code-block:: bash

   #!/bin/bash
   
   TAR=/bin/tar
   GZIP=/bin/gzip
   
   DIR=/var/enstratus/backups
   BASE=dispatcher
   DA=`date +%Y%m%d-%H%M%S`
   
   FILE=${DIR}/${BASE}-${DA}.tar.gz
   
   find ${DIR} -type f -iname "*.gz" -mtime +2 | xargs rm -f
   
   cd /services/${BASE}
   $TAR -czf ${FILE}  --exclude='jetty/temp/*' --exclude='jetty/logs/*' . > /dev/null 2>&1
   chmod 700 ${FILE}

Databases
~~~~~~~~~

The frequency with which the Enstratius provisioning database is backed up is determined
primarily by the number of writes being made to the database. Enstratius environments where
there are many new accounts being joined to Enstratius, many new users being added or
modified should conduct backups more frequently than environments where these events are
less frequent.

As a general best practice guideline, backups should be done no less frequent than twice
daily, every four hours in heavily utilized systems, or more frequently as the situation
dictates.

Backups should be encrypted and stored in a geographically unique location from the
primary data source.

The expected time to run a backup of the provisioning database can vary greatly. In
Enstratius deployments that have been running for a very long period of time, the backup
may take between 10 and 40 minutes.

The expected time to restore the provisioning database can vary depending on the length of
time of the existence of the provisioning database, the amount of hardware backing the db,
and the amount of data contained. Restoration may take over an hour, but probably less.

The same principles apply for the analytics database, although it typically has less
information in it than the provisioning database.

Starting Dispatcher
-------------------

To start the Dispatcher service:

.. code-block:: bash

	/etc/init.d/enstratus-dispatcher start

.. code-block:: bash

	netstat -tnlup | grep 3302
	tcp6       0      0 :::3302                 :::*                    LISTEN 7199/java  

Stopping Dispatcher
-------------------

To stop the Dispatcher service:

.. code-block:: bash

	/etc/init.d/enstratus-dispatcher stop

Dispatcher Troubleshooting
--------------------------

The dispatcher is a very stable process and does not require much attention. However,
here are some areas to consider when managing the dispatcher process.

1. Restarting the Dispatcher

.. note:: Stopping the dispatcher service will cause Enstratius to be unusable. 

Here are some helpful commands to stop and start the dispatcher service, as well as
tail the logs. Put these commands in your .bashrc as an alias or a function.

  1. alias startDispatcher='/etc/init.d/enstratus-dispatcher start'

  2. alias stopDispatcher='/etc/init.d/enstratus-dispatcher stop'

  3. alias tailDispatcher='tail -f /services/dispatcher/logs/dispatcher.out'

Once these are set, start the dispatcher process like this:

.. code-block:: bash

  startDispatcher && tailDispatcher

And you'll be able to start and tail the logs in one line. Very helpful. Why is tailing
the log useful?

2. Registering for the first time

3. Entering Cloud Credentials

   It can be helpful to watch the dispatcher logs when entering cloud credentials.

4. Log sizes 

   If the installation is new, it is quite likely that the logging levels are set high

Configuration Files
-------------------

The dispatcher service has configuration files in /services/dispatcher/


#. resources/log4j.xml
#. contexts/enstratus-context.xml
#. resources/dasein-persistence.properties
#. resources/enstratus-km-client.cfg
#. resources/enstratus-provisioning.cfg
#. resources/mq.cfg

log4j.xml
~~~~~~~~~

``/services/dispatcher/resources/log4j.xml``

This file is responsible for controlling the logging behavior for the dispatcher service.

enstratus-context.xml
~~~~~~~~~~~~~~~~~~~~~

``/services/dispatcher/contexts/enstratus-context.xml``

This file controls how the dispatcher service connects to its associated databases:
provisioning and analytics.

dasein-persistence.properties
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``/services/dispatcher/resources/dasein-persistence.properties``

This file defines the connection to the dasein persistence layer of Enstratius. It also
specifies the connection point to the Riak database service.

enstratus-km-client.cfg
~~~~~~~~~~~~~~~~~~~~~~~

``/services/dispatcher/resources/enstratus-km-client.cfg``

This file controls the connection to the KM service by the dispatcher.

enstratus-provisioning.cfg
~~~~~~~~~~~~~~~~~~~~~~~~~~

``/services/dispatcher/resources/enstratus-provisioning.cfg``

This file is a general control point for several items, the most important of which is the
encryption key for encrypting connections to the KM service.

mq.cfg
~~~~~~

``/services/dispatcher/resources/mq.cfg``

This file controls how the dispatcher service connects to the mq service.
