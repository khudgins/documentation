.. _workers:

Workers
=======

.. figure:: ./images/monitorWorker.png
   :height: 300 px
   :width: 450 px
   :scale: 70 %
   :alt: Monitors/Workers Service
   :align: center

   Monitors/Workers Service Connections

Overview
--------

The Enstratius worker service consists of two components, a publisher and a subscriber. At a very high level,
these components:

1. Publisher

  - The publisher is responsible for pushing actions onto the Enstratius message queue.

2. Subscriber

  - The subscriber is responsible for taking actions off of the queue and acting accordingly.

The Enstratius workers service will eventually assume all of the responsibilities of the
Enstratius monitor service, which will then be deprecated.

This transition is underway, and the workers already are responsible for handling
several processes that allow the automation and orchestration features of Enstratius.

During automated server launches, the Enstratius workers service is responsible for
initiating the API call to the cloud provider API for server launch. During standalone
server launches, this activity is handled by the Enstratius dispatcher service.

The workers service does not listen for incoming connections.

Installation
------------

Installation of the Enstratius worker service is best handled by using a configuration
management system such as Chef or Puppet.

Software Requirements
---------------------

The KM service depends on the Open JDK.

Incoming Connections
--------------------

None.


Outgoing Connections
--------------------

#. Cloud API

   The worker service connects to the cloud provider API to discover changes, track the
   completion of jobs initiated by the dispatcher, and maintain cloud state.

   The worker service also initiates calls to the cloud provider API to launch servers
   during automated server starts.

#. Riak and MySQL

   The worker service connects to the Riak and MySQL databases for the purposes of pushing
   state information. Enstratius workers also connect directly to the cloud provider API and
   poll to discover changes. 
   
   The polling interval for each Enstratius worker varies depending on the cloud service
   being monitored. Cloud resources that require up-to-the-minute monitoring, for example
   when firewall changes occur, will be polled more rapidly than less critical resources such as
   changes to budget state.

#. Guest VM

   The worker service will also poll guest VM running in the cloud for the purpose of
   collecting logs.

Starting Worker
---------------

To start the worker service:

.. code-block:: bash

	/etc/init.d/enstratus-workers start

Stopping Worker
---------------

To stop the worker service:

.. code-block:: bash

	/etc/init.d/enstratus-workers stop

Logging
-------

Logging for the workers service is done to:

``/services/worker/logs/pubsub.log``

Monitoring
----------

.. _worker_backups:

Backups
-------

Service
~~~~~~~

The Enstratius worker service files should be backed up before and after any changes, and
once/day during steady-state operations. Backups should be performed on
/services/worker.

An example of how to backup the worker service is shown here, in this case excluding the
log directory.

.. code-block:: bash

   #!/bin/bash
   
   TAR=/bin/tar
   GZIP=/bin/gzip
   
   DIR=/var/enstratus/backups
   BASE=worker
   DA=`date +%Y%m%d-%H%M%S`
   
   FILE=${DIR}/${BASE}-${DA}.tar.gz
   
   find ${DIR} -type f -iname "*.gz" -mtime +2 | xargs rm -f
   
   FILE=${DIR}/${BASE}-${DA}.tar.gz
   
   cd /services/worker/
   $TAR -czf ${FILE}  --exclude='log/*' . > /dev/null 2>&1
   chmod 700 ${FILE}

Databases
~~~~~~~~~

The Enstratius monitor service depends on the provisioning and analytics databases along
with the Enstratius dispatcher service. Backups of these database are discussed in the

Configuration Files
-------------------

The Enstratius workers service has 9 configuration files in /services/worker/

.. hlist::
   :columns: 3

   * resources/log4j.properties
   * resources/dasein-persistence.properties
   * resources/enstratus-km-client.cfg
   * resources/enstratus-provisioning.cfg
   * resources/mq.cfg
   * resources/worker.properties

log4j.properties
~~~~~~~~~~~~~~~~

Path:

  ``/services/worker/resources/log4j.properties``

This file is responsible for controlling the logging behavior for the worker service.

dasein-persistence.properties
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Path:

  ``/services/worker/resources/dasein-persistence.properties``

This file defines the connection to the dasein persistence layer of Enstratius. It also
specifies the connection point to the Riak database service.

enstratus-km-client.cfg
~~~~~~~~~~~~~~~~~~~~~~~

Path:

  ``/services/worker/resources/enstratus-km-client.cfg``

This file controls the connection to the KM service by the workers. 

enstratus-provisioning.cfg
~~~~~~~~~~~~~~~~~~~~~~~~~~

Path:

  ``/services/worker/resources/enstratus-provisioning.cfg``

This file is a general control point for several items, the most important of which is the
encryption key for encrypting connections to the KM service. This is also where a setting
called SOURCE_CIDR is made, which specifies IP addresses from which Enstratius will make
connections to guest VM.

worker.properties
~~~~~~~~~~~~~~~~~

Path:

  ``/services/worker/resources/worker.properties``

This file is used to define the connection points for the worker processes
to connect to the provisioning and analytics MySQL databases.

mq.cfg
~~~~~~

Path:

  ``/services/worker/resources/mq.cfg``

This file controls how the monitor service connects to the mq service.
