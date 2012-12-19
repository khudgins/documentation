Software
--------

enStratus leverages several open-source technologies as part of the overall cloud
management solution.

Use of these technologies is **required** for installing and running the enStratus cloud
management software.

The installation and configuration of these components is handled by the configuration
management installation service provided by enStratus.

Operating System
~~~~~~~~~~~~~~~~

enStratus installation requires the Linux operating system. Supported distributions
include:

* Ubuntu 10.04, 12.04 LTS
* Centos 6
* Red Hat Enterprise Linux 6

Recommended distribution is Ubuntu 12.04 LTS. 

Required CPU architecture is x86_64

Riak
~~~~

enStratus is in the process of transitioning to using Riak for the database backend.

MySQL
~~~~~

enStratus was originally designed to use MySQL. The use of this software will be slowly
replaced as the transition to Riak happens.

Open JDK
~~~~~~~~

enStratus uses the Java Open JDK.

Jetty
~~~~~

enStratus uses Jetty as an HTTP and servlet container.


Rabbit MQ
~~~~~~~~~

enStratus uses Rabbit as the message queue.
