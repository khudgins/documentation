enstratus-service
-----------------

Name
~~~~

enstratus-service - Manages the Enstratius agent daemon

Synopsis
~~~~~~~~

enstratus-service ACTION

Description
~~~~~~~~~~~

It starts or stops the Enstratius agent.

Options
~~~~~~~

ACTION
	start for starting the Enstratius agent
	stop for stopping the Enstratius agent
	
Examples
~~~~~~~~

.. code-block:: bash

	$ /enstratus/bin/enstratus-service stop

	Using CATALINA_BASE:   /enstratus/ws/tomcat
	Using CATALINA_HOME:   /enstratus/ws/tomcat
	Using CATALINA_TMPDIR: /enstratus/ws/tomcat/temp
	Using JRE_HOME:       /usr/java/jdk

	$ /enstratus/bin/enstratus-service start

	Using CATALINA_BASE:   /enstratus/ws/tomcat
	Using CATALINA_HOME:   /enstratus/ws/tomcat
	Using CATALINA_TMPDIR: /enstratus/ws/tomcat/temp
	Using JRE_HOME:       /usr/java/jdk


Invocation
~~~~~~~~~~

This script is called by /etc/init.d/tomcat-enstratus on server boot to start the Enstratius agent. It can also be run manually to start/stop the agent.


Dependencies
~~~~~~~~~~~~

* Enstratius agent requires JDK

Permission
~~~~~~~~~~

It is called by the Enstratius user.


Overrides
~~~~~~~~~

Override: No

Replace: No
