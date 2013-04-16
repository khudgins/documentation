API
===

The Enstratius console is a jetty service installed to /services/api.

.. figure:: ./images/api.png
   :height: 250 px
   :width: 450 px
   :scale: 70 %
   :alt: API Service
   :align: center

   API Service Connections


Overview
--------

Installation
------------

Incoming Connections
--------------------

User initiated. 

Outgoing Connections
--------------------

Starting API
------------

.. code-block:: bash

	/etc/init.d/enstratus-api start

There should be a java process listening on port 15000, for a default installation.

.. code-block:: bash

  netstat -tnlup | grep java
  tcp6       0      0 :::15000                :::*                    LISTEN      5647/java       
  tcp6       0      0 127.0.0.1:16099         :::*                    LISTEN      5647/java  

Stopping API
------------

.. code-block:: bash

	/etc/init.d/enstratus-api stop

Logging
-------

Logging for the API service is done to:

``/services/api/logs/YYYY_MM_DD.request.log``

``/services/api/logs/api.log``

Monitoring
----------

.. _api_backups:

Backups
-------

Service
~~~~~~~

.. code-block:: bash

   #!/bin/bash
   
   TAR=/bin/tar
   GZIP=/bin/gzip
   
   DIR=/var/enstratus/backups

   BASE=api
   DA=`date +%Y%m%d-%H%M%S`
   
   FILE=${DIR}/${BASE}-${DA}.tar.gz
   find ${DIR} -type f -iname "*.gz" -mtime +2 | xargs rm -f
   
   cd /services/${BASE}
   $TAR -czf ${FILE}  --exclude='logs/*' . > /dev/null 2>&1
   chmod 700 ${FILE}

Configuration Files
-------------------

The Enstratius api service has configuration files in /services/api

#. /resources/log4j.xml
#. /contexts/enstratus-context.xml
#. /resources/custom/networks.cfg
#. /resources/dasein-persistence.properties
#. /resources/enstratus-webservices.cfg

log4j.xml
~~~~~~~~~

``/services/api/resources/log4j.xml``

enstratus-context.xml
~~~~~~~~~~~~~~~~~~~~~

``/services/api/contexts/enstratus-context.xml``

This file controls how the API service connects to its associated databases:
console and enstratus_console.

enstratus-webservices.cfg
~~~~~~~~~~~~~~~~~~~~~~~~~

``/services/api/resources/enstratus-webservices.cfg``

This file defines the webservices endpoints for the API service to connect to the
Enstratius dispatcher service.

dasein-persistence.properties
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``/services/api/resources/dasein-persistence.properties``

This file defines the connection to the dasein persistence layer of Enstratius. It also
specifies the connection point to the Riak database service.

networks.cfg
~~~~~~~~~~~~

``/services/api/resources/custom/networks.cfg``

This file is a general control point for several items, the most important of which is the
encryption key for encrypting connections to the dispatcher web services.

