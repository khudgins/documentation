Console
=======

The Enstratius console is a jetty service installed to /services/console.

.. figure:: ./images/console.png
   :height: 250 px
   :width: 450 px
   :scale: 70 %
   :alt: Console Service
   :align: center

   Console Service Connections

Console Overview
----------------

The Enstratius console service is a jetty service that provides the web front-end, or
Enstratius user console. The Enstratius console is a content management system designed to
provide users with a means to interact with multiple clouds through a single interface.

The Enstratius console listens on port 443 for https connections and connects to the
Enstratius dispatcher service via a webservices call to initiate user actions.

The jetty service providing the Enstratius console can be load balanced by load balancing
software such as Apache, HA-Proxy, F5, nginx, among others.

The Enstratius console service currently depends on 3 databases:

#. console
#. enstratus_console
#. Riak

In the near future, these three databases will be merged into one: Riak.

console Database
----------------

The Enstratius console database contains the content for driving the web interface of the
Enstratius console. 

enstratus_console Database
--------------------------

The enstratus_console database is primarily engaged in user management and contains
information related to users and accounts.

Riak
----

The Riak database service is assuming both of the responsibilities currently being
performed by the console and enstratus_console database.

Installation
------------

Installation of the Enstratius console service is best handled by using a configuration
management system such as Chef or Puppet.

Software Requirements
---------------------

The dispatcher service depends on the Open JDK and runs as a Jetty service.

Incoming Connections
--------------------

#. Users

   The only incoming connections handled by the Enstratius console service are those
   initiated by users interacting with the Enstratius console.

Outgoing Connections
--------------------

#. Dispatcher

   The console service interacts with the dispatcher service via a webservices call
   configured in the file:

   ``/services/console/jetty/webapps/ROOT/WEB-INF/classes/enstratus-webservices.cfg``

   This communication is encrypted using industry standard AES-256 encryption.

#. Riak and MySQL

Starting Console
----------------

To start the console service:

.. code-block:: bash

	/etc/init.d/enstratus-console start

Console Start Process
~~~~~~~~~~~~~~~~~~~~~

Stopping Console
----------------

To stop the console service:

.. code-block:: bash

	/etc/init.d/enstratus-console stop

Console Stop Process
~~~~~~~~~~~~~~~~~~~~

Logging
-------

Logging for the Console service is done to:

``/services/console/logs/YYYY_MM_DD.request.log``

``/services/console/logs/console.log``

Monitoring
----------

.. _console_backups:

Backups
-------

Service
~~~~~~~

The Enstratius console service files should be backed up before and after any changes, and
once/day during steady-state operations. Backups should be performed on /services/console.
An example of a backup is shown here, excluding the log files in this case.

.. code-block:: bash

   #!/bin/bash
   
   TAR=/bin/tar
   GZIP=/bin/gzip
   
   DIR=/var/enstratus/backups
   BASE=console
   DA=`date +%Y%m%d-%H%M%S`
   
   FILE=${DIR}/${BASE}-${DA}.tar.gz
   
   find ${DIR} -type f -iname "*.gz" -mtime +2 | xargs rm -f
   
   cd /services/${BASE}
   $TAR -czf ${FILE}  --exclude='content/content/*' --exclude='content/page/*' --exclude='logs/*' . > /dev/null 2>&1
   chmod 700 ${FILE}

Databases
~~~~~~~~~

The frequency with which the Enstratius console database is backed up is determined
primarily by the number of writes being made to the database. Enstratius environments where
there are many new accounts being joined to Enstratius, many new users being added or
modified should conduct backups more frequently than environments where these events are
less frequent.

As a general best practice guideline, backups should be done no less frequent than twice
daily, every four hours in heavily utilized systems, or more frequently as the situation
dictates.

Backups should be encrypted and stored in a geographically unique location from the
primary data source.

The expected time to run a backup of the console database can vary greatly. In
Enstratius deployments that have been running for a very long period of time, the backup
may take between 2 and 5 minutes.

The expected time to restore the console database can vary depending on the length of
time of the existence of the provisioning database, the amount of hardware backing the db,
and the amount of data contained. Restoration may take over an hour, but probably less.

The same principles apply for the enstratus_console database, although it typically has less
information in it than the provisioning database. Expect backups and restoration of the
enstratus_console database to take less than one minute.

An example of how to run a backup of databases is shown in this script:

.. code-block:: bash

   #!/bin/bash
   
   #
   # Setup configuration values
   #
   HOST=$(hostname)
   USER=dbuser
   PASSWORD=abcdef12345
   DA=$(date +%Y%m%d-%H%M%S)
   MYSQL=/usr/bin/mysql
   MYSQLDUMP=/usr/bin/mysqldump
   GZIP=/bin/gzip
   PGP=/usr/bin/gpg
   
   CONFIG=/etc/mysql/my.cnf
   
   if [ $# -gt 0 ] ; then
     CONFIG=$1
   fi
   
   BASE=$(basename ${CONFIG} .cnf)
   LOGFILE=/var/log/backups-${BASE}.log
   DATABASES=$(${MYSQL} --defaults-file=${CONFIG} -u${USER} -p${PASSWORD} -Bse 'show databases')
   DIR=/backups/db
   
   echo "" >> ${LOGFILE}
   echo "Starting MySQL database backup for ${DA}..." >> ${LOGFILE}
   
   # 
   # Make sure the directory exists
   #
   if [ ! -d ${DIR} ] ; then
       mkdir ${DIR}
       chmod 700 ${DIR}
       chown enstratus ${DIR}
   fi
   
   # 
   # Delete all old files
   #
   find ${DIR} -type f -mtime +2 | xargs rm -f
   
   #
   # Backup each database
   #
   for db in ${DATABASES}
   do
       sleep 10
       NOW=$(date +%Y%m%d-%H%M%S)
       echo -n "        Backing up: ${db} at ${NOW}... " >> ${LOGFILE}
       FILE=${DIR}/${db}-${DA}.sql.gpg.gz
       $MYSQLDUMP --defaults-file=${CONFIG} --single-transaction -u${USER} -p${PASSWORD} $db | $PGP -r enstratusBackup@enstratus.com -e | $GZIP -9 > ${FILE}
       chown enstratus ${FILE}
       chmod 700 ${FILE}
       NOW=$(date +%Y%m%d-%H%M%S)
       echo "Done at ${NOW}." >> ${LOGFILE}
   done
   
   echo "MySQL database backup complete at ${NOW}." >> ${LOGFILE}
   echo "" >> ${LOGFILE}

Configuration Files
-------------------

The Enstratius console service has configuration files /services/console:

#. /resources/log4j.xml
#. /resources/directory.properties
#. /bin/dirsync
#. /contexts/enstratus-context.xml
#. /resources/dasein-persistence.properties
#. /resources/enstratus-console.cfg
#. /resources/enstratus-webservices.cfg
#. /resources/custom/networks.cfg

log4j.xml
~~~~~~~~~

``/services/console/resources/log4j.xml``

This file is responsible for controlling the logging behavior for the console service.

directory.properties
~~~~~~~~~~~~~~~~~~~~

``/services/console/resources/directory.properties``

This file is responsible for defining the database and message queue connections for the
console service.

dirsync
~~~~~~~

``/services/console/bin/dirsync``

This file is a script used to initiate a synchronization event with the LDAP/AD service,
if it exists.

enstratus-context.xml
~~~~~~~~~~~~~~~~~~~~~

``/services/console/contexts/enstratus-context.xml``

This file controls how the API service connects to its associated databases:
console and enstratus_console.

dasein-persistence.properties
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``/services/console/resources/dasein-persistence.properties``

This file defines the connection to the dasein persistence layer of Enstratius. It also
specifies the connection point to the Riak database service.

enstratus-console.cfg
~~~~~~~~~~~~~~~~~~~~~

``/services/console/resources/enstratus-console.cfg``

This file is used to define the url to which the console will respond.

enstratus-webservices.cfg
~~~~~~~~~~~~~~~~~~~~~~~~~

``/services/console/resources/enstratus-webservices.cfg``

This file defines the webservices endpoints for the API service to connect to the
Enstratius dispatcher service.

networks.cfg
~~~~~~~~~~~~

``/services/console/resources/custom/networks``

This file is a general control point for several items, the most important of which is the
encryption key for encrypting connections to the dispatcher web services.
