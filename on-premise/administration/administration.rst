.. _administration:

Administration
==============

The enStratus cloud management software consists of several components, along with some
supporting software. The purpose of this section is to give an administrator of enStratus
systems an overview of the installed components and how to manage them.

+-------------------------------------+-------------------------+
| **Core enStratus Software**         | **Supporting Software** |
+=====================================+=========================+
| Key Manager (credentials subsystem) | MySQL                   |
+-------------------------------------+-------------------------+
| Dispatcher                          | Riak                    |
+-------------------------------------+-------------------------+
| Monitors                            | Rabbit MQ               |
+-------------------------------------+-------------------------+
| Workers                             | Open JDK                |
+-------------------------------------+-------------------------+
| Console                             | Jetty                   |
+-------------------------------------+-------------------------+
| API                                 |                         |
+-------------------------------------+-------------------------+
| Console Worker (LDAP/AD Module)     |                         |
+-------------------------------------+-------------------------+

Recent Changes
--------------

* Tomcat is replaced by Jetty
* JSVC is replaced by custom launchers for monitors and workers
* SunJDK is gone replaced by OpenJDK
* JCE download is no longer needed
* All startup scripts are replaced by runit

Jetty
~~~~~

Jetty and non-Jetty applications share a common layout.

Logging
~~~~~~~

Jetty logging uses the same log configuration file type and format as non-Jetty apps. All
applications ship with the EXACT same log4j.properties file.

Logs are much quieter and run by default with a log level of ERROR. Specific classes that
provide useful information have been set to appropriate levels.

Default logging configurations ships with defined but commented stanzas explaining how to
configure wire logging and more verbose logging options.

All logs are in /services/<appname>/logs

The only exception is that stdout and stderr are handled by the runit init system. See
under runit for more information.

Configuration Files
~~~~~~~~~~~~~~~~~~~

All relevant configuration files are now stored in /services/<appname>/resources

For former-Tomcat-now-Jetty apps, webapps/ROOT/WEB-INF/classes no longer exists. Those
files are now in the resources directory excepting a few cases. The files in those cases
are not configurable on premise anyway.

Jetty Applications
~~~~~~~~~~~~~~~~~~

The Jetty applications are:

#. API
#. Console
#. KM
#. Dispatcher

The layout of the Jetty applications is:

* bin
* contexts
* default
* etc
* lib
* logs
* resources
* tmp
* webapps

Non-Jetty Applications
~~~~~~~~~~~~~~~~~~~~~~

The non-Jetty applications are:

#. Monitor
#. Worker

The layout of the non-Jetty applications is:

* bin
* lib
* logs
* resources
* etc
* tmp

JSVC
~~~~

JSVC is no longer used. JSVC has been replaced by a launcher process for monitors and
workers.

These "launchers" (one for worker, two for monitors), work similar to JSVC but with the
benefit of not spawning multiple JVMs. They also accept appropriate options for our
applications.

There are some specifics around each launcher described below.

runit
~~~~~

Instead of writing and maintaining three distinct startup scripts (upstart on Ubuntu,
sysvinit on RHEL5 and systemd on RHEL6), all the enstratus-specific process supervision is
done by runit. 

The "startup script" for each component is in /etc/service/enstratus-<service name>

runit takes over stderr and stdout logging by default. This is fine as we're now using
log4j to log to rotating files. The output from stderr and stdout is in
/etc/service/enstratus-<service name>/log/main/ in the file called current. Note that runit
automatically rotates this file so you don't need to worry about it.

Normally you should NOT need to look at that log file but in some cases you might so it's
mentioned.

Remember runit is a process supervisor. This means if the process it started DIES,
it will restart it.

You can stop and start services the traditional way (service foo stop, service foo start,
/etc/init.d/service [stop|start]) and restart also works for all applications since runit
just kills the process if it doesn't stop cleanly and starts it back up for a restart.

To check the status of an enStratus process being managed by runit, issue the command:

.. code-block:: bash

   sv status enstratus-${service}

where ``${service}`` evaluates to one of the following:

#. dispatcher
#. km
#. console
#. api

Here is sample output for the dispatcher service:

.. code-block:: bash

   # sv status enstratus-dispatcher
   run: enstratus-dispatcher: (pid 962) 29075s; run: log: (pid 901) 29075s

There are no default packages for runit under RHEL5 clones (either in main repo or in
EPEL). We have packaged a version of runit for both RHEL6 clones and RHEL5 clones.

bin scripts
~~~~~~~~~~~

The bin script situation is greatly simplified and does most of the magic for you. Each
bin script also supports overrides via an external configuration file. Let's use the
monitors as an example:

By default we start 29 monitors (though in the same JVM process). In an on-premise
environment, we might not need all of them for various reasons.

With the new system, the way you override this is to create the following file:

``/services/monitor/default/monitor``

The file should be named after the bin script that is used to start it.

If you look at the bin script for the monitors, it does this:

``ALL_MONITORS=`awk -vORS=, '{ print $1 }' ${ES_RESDIR}/monitors.cfg | sed 's/,$/\n/'```

This is basically reading the current-shipped monitors.cfg and joining the lines with
commas. This is then passed into the launcher.

If, in your ``/services/monitor/default/monitor`` file you add:

``ALL_MONITORS=Server,Image,Budget``

Then those will override and ONLY those three monitors will be started.

But let's assume you just want to limit the amount of memory workers use to simulate an
OOM sooner for debugging. There are two special settings that are added to the JVM
invocation if they are found:

* JMX_OPTS
* USER_JAVA_OPTS

If you set those in the ``/services/worker/default/<scriptname>`` file, they will inherit and
become active.

.. toctree::
   :maxdepth: 1
   :hidden:

   km
   dispatcher
   monitors
   workers
   console
   api
   cwrkr
   mysql
   riak
   rabbit_mq
   certificates
   init
   logging
