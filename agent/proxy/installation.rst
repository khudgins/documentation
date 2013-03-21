.. _agent_proxy_installation:

Installation
------------

Before letting Enstratius know about an agent proxy (:ref:`Registration
<agent_proxy_registration>`), you must get it running on a node.

The agent proxy is packaged as a war file with all dependencies included. The
war file is also itself executable: it has an embedded Jetty server. So there is
no need to install anything. For more deployment and operations background,
see the :ref:`Operations <agent_proxy_operations>` section.

In the current version of these instructions we will not run it as an OS service
but rather as a script for testing purposes. (This should be fixed after
introduction of ``runit``.)

1. Download
~~~~~~~~~~~

`Agent Proxy <http://es-download.s3.amazonaws.com/es-agentproxy.tar.gz>`_

In this tarball are some configuration scripts that need some editing, a ".war"
file which is the application, and ``agent-proxy.sh`` which is what you run.

2. Edit agentproxy.properties
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the ``agentproxy.properties`` file, find ``upstreamHostPort``. This is set to
``provisioning.enstratus.com:3302`` by default which is the Enstratius SaaS
handshake endpoint. If you are working with an alternate Enstratius installation,
use the host:port combination given to you.

Also in this file is ``agentProxyId``. For this configuration, pick a unique ID
for every agent proxy you install. A random string like ``45BCEBB32AA9`` works
well for this value. When working over the public internet, an even longer
random string is better.

Also in this file is ``disableUpstreamValidation``. You will want to change this
to ``true`` for initial setup and testing. If left with its default value
``false``, the agent proxy will expect to validate the SSL chain of the upstream
Enstratius installation when it relays agent handshakes. During setup and
testing, you should remove this security barrier to make sure everything else is
working first.

3. Setup SSL
~~~~~~~~~~~~

The last configuration you need to make is setting up an SSL certificate for the
agent proxy itself. This involves creating a certificate and then converting
that to a Java keystore.

3.1. Create a certificate
^^^^^^^^^^^^^^^^^^^^^^^^^

This will only be a self-signed certificate for now. It is better to have a bona fide trust
chain for the agent proxy certificate but we are more concerned with getting the system
running at this moment.

Run the following command in the agent proxy directory:

.. code-block:: bash

    openssl genrsa -out agentkey.pem 2048

In the next command, the answer to the "Country?" "State?" questions are
whatever you want them to be, they will not have an effect on the system. A good
answer to "Common Name (eg, YOUR name)?" is "agentproxy" for debugging purposes.

.. code-block:: bash

    openssl req -new -x509 -key agentkey.pem -out agentcert.pem -days 730

Now both ``agentkey.pem`` and ``agentcert.pem`` should be present.

3.2. Create a keystore
^^^^^^^^^^^^^^^^^^^^^^

Included in the agent proxy distribution is a versioned file like
``keystoretool-1.0.jar``. We will now use this tool (via a script) to quickly
create a keystore.

Run the following commands:

.. code-block:: bash

    ./pem-to-jks.sh agentcert.pem agentkey.pem
    cp keystore.jks truststore.jks

Now ``keystore.jks`` and ``truststore.jks`` will be present, both of which need
to be in the agent proxy directory for it to run.

4. Start the agent proxy
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    ./agent-proxy.sh

5. Register the agent with Enstratius
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Instructions to register the agent with Enstratius are in the
:ref:`Registration <agent_proxy_registration>` section.

6. Test the agent proxy
~~~~~~~~~~~~~~~~~~~~~~~

The Enstratius :ref:`agent <agent>` now needs to be configured to handshake via
this server instead of the Enstratius installation. To reconfigure it, find this
file on the VM:

.. code-block:: text

    /enstratus/ws/tomcat/webapps/ROOT/WEB-INF/classes/enstratus-webservices.cfg

Inside this file, change "environment" to "staging". And change
"provisioningProxy" to the IP address of the agent proxy (and make sure it is
not commented out). For example:

.. code-block:: text

    cloud=VMware
    environment=staging
    provisioningProxy=10.10.10.10:2002

Now you will need to make a new machine image. When it is launched, this IP:port
combination will be used to handshake, not the default address. The agent does
not realize it is talking to an agent proxy and not Enstratius proper.

To test that everything is communicating, look at the logging (testing
communication from the VM to Enstratius) and then try to add a user to the VM
(testing the opposite direction).

