Logging Locations
=================

API
---

``/services/api/logs/YYYY_MM_DD.request.log``

``/services/api/logs/api.log``

Console
-------

``/services/console/logs/YYYY_MM_DD.request.log``

``/services/console/logs/console.log``

Dispatcher
----------

``/services/dispatcher/logs/YYYY_MM_DD.request.log``

``/services/dispatcher/logs/dispatcher.log``

Key Manager
-----------

``/services/km/logs/YYYY_MM_DD.request.log``

``/services/km/logs/km.log``

Monitors
--------

``/services/monitor/logs/assign.log``

``/services/monitor/logs/monitor.log``

Workers
-------

``/services/worker/logs/pubsub.log``

Additional Logging
------------------

runit takes over stderr and stdout logging by default. 
The output from stderr and stdout is in
/etc/service/enstratus-<service name>/log/main/ in the file called current. Note that runit
automatically rotates this file.
