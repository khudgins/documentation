.. _saas_puppet:

Puppet
======

.. _puppet_prerequisites:

Prerequisites
-------------

There are a few prerequisites required for end-to-end automation using Puppet with
Enstratius:

* A working PE2.5 Server
* The Enstratius ``espm`` agent installed on the SAME server as PE2.5
* Python 2.6 on the PE2.5 server (for ``espm``)
* A registered image in the cloud with Enstratius agent v17 or higher

.. _saas_puppet_espm:

ESPM
----

Before Enstratius can be used with a Puppet Enterprise 2.5 server, it is necessary to have
a small agent running on the server.

Why an agent?
~~~~~~~~~~~~~

To understand why an agent is needed, it's important to understand a bit about how
Enstratius chooses to interact with CM systems.  One of the primary goals when initially
adding support for third-party CM systems to Enstratius was that Enstratius allowed you to
use your CM system as the "source of truth" about a system's configuration. Enstratius is
largely unopinionated in the matter. While we have our own CM system (ObjectStore), we
understand that it cannot meet the needs of all users and that asking users to switch to
OUR configuration management system would be wrong.

Another goal is that you would not be forced to use Enstratius to interact with your CM
system. You should not need to do anything special for Enstratius to use your CM system and
you shouldn't have to jump through hoops to disconnect Enstratius from your CM system. The
nature of CM systems is that they likely aren't just being used for cloud resources via
Enstratius.

The final goal is that you should be able to manage the configuration of your systems
using the tools provided by your CM product.

When we looked at the various approaches for integrating Enstratius with Puppet, we had
several choices in front of us:

- Force you to use Enstratius as an ENC
- Integrate Enstratius with Hiera
- Use the unstable puppet-dashboard REST API
- Use the Enstratius agent

The first option was eliminated quickly as it violated all of the goals above. The second
option would only provide limited integration.  The third option was appealing but due to
the volatility of the puppet-dashboard HTTP API (and lack of certain functionality), it
was ruled out.

That leaves us with using the Enstratius agent. The problem here is that the Enstratius
agent is designed to work specifically with cloud instances. It is highly likely that
users would not even have the Puppet Master managed by Enstratius. The only remaining
option, and one that has been suggested by Puppet Labs, was to create a custom agent with
very specific set of functionality. That's what ``espm`` is.

Internals
~~~~~~~~~

``espm`` is a very small lightweight Python daemon. It requires Python 2.6 (due to some
internal dependencies) and leverages the PE2.5 puppet-dashboard rake tasks as well as the
native puppet ``cert`` face.

``espm`` has been tested on the following distributions:

* Ubuntu 10.04-12.04
* CentOS 5 (with python26 from the EPEL repository)

Specifically for each distro:

Ubuntu
^^^^^^

* build-essential
* python-setuptools
* python-dev

CentOS5
^^^^^^^

* openssl-devel
* gcc
* gcc-c++
* python26 (from EPEL)
* python26-devel (from EPEL)
* python26-distribute


``espm`` exposes an HTTP interface that Enstratius uses to perform the following tasks:

* List groups and classes
* Add nodes to the PE2.5 ENC
* Assign groups, classes and parameters to nodes it creates
* Delete nodes that it creates
* Use native puppet commands to generate and revoke client certificates

``espm`` will never touch any existing node and you cannot use it to create new classes or
groups. It can't even list existing nodes. The functionality isn't exposed. The only
reason ``espm`` exists is so that you can perform automation within Enstratius and use
Puppet to configure the systems in the same automated fashion.

``ESPM`` Installation
~~~~~~~~~~~~~~~~~~~~~

Currently ``espm`` is made available on request to Enstratius customers. The reason for
this is so that we want to be aware so we can ensure that we provide the best support
possible during the integration. Requesting ``espm`` is simply a matter of opening a
support ticket within Enstratius.

Assuming you have the prerequisites for your distro above installed and have extracted
``espm`` to ``/usr/src/espm``, you would run:

``python setup.py install`` (for Ubuntu)
or
``python26 setup.py install`` (for CentOS5-EPEL)

This will pull the appropriate dependencies and install ``espm``.

``ESPM`` Setup
~~~~~~~~~~~~~~

Two commands will now be available to you:

* espm
* espm_setup

``espm_setup`` has full help output but the primary options you'll need to worry about are:

* ``-d <some directory>`` This is where the configuration file will be stored
* ``-c <cert directory`` This is where certificates used by ``espm`` and Enstratius will be written

By default, setup will write a configuration file to ``/opt/espm/etc``, create
certificates in ``/opt/espm/etc/certs`` and will listen on port 8443. These directories
must exist in advance:

.. code-block:: bash

	mkdir -p /opt/espm/etc/certs
	espm_setup

will result in:

::

	Preshared Key:
	b48hJWAW4Kicp74I-DCHdyYdrFfxijuaI2_CW0nb8HHxvA9Z

	Certificate:
	-----BEGIN CERTIFICATE-----
	MIIDeTCCAmECAgPoMA0GCSqGSIb3DQEBBQUAMIGBMQswCQYDVQQGEwJVUzESMBAG
	A1UECBMJTWlubmVzb3RhMRQwEgYDVQQHEwtNaW5uZWFwb2xpczEhMB8GA1UEChMY
	ZW5TdHJhdHVzIE5ldHdvcmtzLCBJbmMuMQ0wCwYDVQQLEwRlc3BtMRYwFAYDVQQD
	Ew1jZW50b3M1LXg4NjY0MB4XDTEyMDkwNjAzMTIyMloXDTIyMDkwNDAzMTIyMlow
	gYExCzAJBgNVBAYTAlVTMRIwEAYDVQQIEwlNaW5uZXNvdGExFDASBgNVBAcTC01p
	bm5lYXBvbGlzMSEwHwYDVQQKExhlblN0cmF0dXMgTmV0d29ya3MsIEluYy4xDTAL
	BgNVBAsTBGVzcG0xFjAUBgNVBAMTDWNlbnRvczUteDg2NjQwggEiMA0GCSqGSIb3
	DQEBAQUAA4IBDwAwggEKAoIBAQC1wP6evkhgycdHUSskbX7119HXL5xVSYLFpdq4
	2JV1p/2csMeWCoWQ4usWwe63AImKAW48HRlUut5IKXz/9vnIGm7/v71Zl5i4oWhl
	mR8icQSGjlxJrteJk6iGfeuwxxFwsOdePINti1yzsJw6K4xJm9OipyYOuEY/Nk7z
	83XA3WC4AmToVg7+EIhruRWbwrTgcnHqGSUZ479Nwb2NNb1FodxykG77PeHh79un
	p3RzIm4a04+mBUYFNsWBCCjNiPVN6Vew0vC2/1+aIWM6TzU5YYWT1mz5dPZUNdJe
	SEK8lNa4Yc5AXNY5fIx2/SLsYKOvOBq2KhCKR9QQiWDM3/iTAgMBAAEwDQYJKoZI
	hvcNAQEFBQADggEBAJLts1+LE7xkaTdo+IclJTg7kAza3RoviDw/LCJ4e1KDNWNW
	Zgs9CK8enpXYyD4dslKS87BO/T9Sh4qlgW2pu37YY7HM9WyECMdbDhqzD+mP2LlV
	BGf5q6K/D+raSY+/6Hkq9jpopw8q0giAgUic8ZM3L4l4YFG1KLTfY2Pr3nPhcX3B
	D/Y/PcJL15/nZj477s0SiwQSFIY5mS5JzqRe4RQcsRDafDFuhj7RCi2Yeplypxqm
	iXaeR8WZSTyE7QVBpfQOeMKgdGvascvmtFlkMbzShc+azV5JcChP0CK/yPQx5Dhu
	1TXCf+YarUm6s4MlC1eRxtWQwFmdRPIrh0vGXXg=
	-----END CERTIFICATE-----


	Please use these values in the appropriate form fields
	when adding your Puppet account to Enstratius
	        
	Writing config to: /opt/espm/etc/espm.ini


Make note of the PSK and the certificate, you will need to provide these to Enstratius. 

.. warning:: ``espm`` will refuse to overwrite any existing settings or certificates. The
   generated PSK and certificate are unique to each run of ``espm_setup``. If you change
   these or regenerate them, Enstratius will no longer be able to communicate with the agent.
   You will have to delete and recreate the account in Enstratius with the new values.

Starting up
~~~~~~~~~~~

At this point you can simply run:

``espm -c /opt/espm/etc/espm.ini``

which starts ``espm`` in the foreground

::

	[06/Sep/2012:03:15:31] ENGINE Listening for SIGHUP.
	[06/Sep/2012:03:15:31] ENGINE Listening for SIGTERM.
	[06/Sep/2012:03:15:31] ENGINE Listening for SIGUSR1.
	[06/Sep/2012:03:15:31] ENGINE Bus STARTING
	[06/Sep/2012:03:15:31] ENGINE Started monitor thread '_TimeoutMonitor'.
	[06/Sep/2012:03:15:31] ENGINE Started monitor thread 'Autoreloader'.
	[06/Sep/2012:03:15:32] ENGINE Serving on 0.0.0.0:8443
	[06/Sep/2012:03:15:32] ENGINE Bus STARTED


We do not provide any sort of init script and logging is done to STDOUT. You are free to
wrap ``espm`` in the process monitor/init system of your choosing. Enstratius will be happy,
however, to work with you on getting it running with your init system.

Security
~~~~~~~~

Every attempt has been made to ensure that ``espm`` does not contain any security flaws.
This is especially important since it has to run as root to interact with the PE2.5 rake
tasks and puppet commands.

However the only thing that needs to communicate with ``espm`` is Enstratius. You are
welcome to firewall off access to ``espm`` except from the Enstratius provisioning system.
We can provide you those IP addresses on request.

The PSK exists to authenticate Enstratius to the agent. The certificate exists to ensure
that Enstratius is talking to the correct agent.


.. _saas_puppet_console_account:

Adding to Enstratius
--------------------

Once you've installed ``espm`` and generated the appropriate credentials, you can add that
to the Enstratius console:

* Navigate to Configuration Management > Accounts

.. figure:: ./images/cm-menu.png
   :alt: Configuration Management Menu
   :align: center

* Click the link on the right side to "Add A New Configuration Management Account"

.. figure:: ./images/add-new-cm-account.png
   :alt: Configuration Management Menu
   :align: center

* Select "Puppet" from the "Configuration Management System" drop-down menu
* Fill in the fields as described.
	Note that specifically to Enstratius, the following fields are required:
   
	* Budget Codes
	* Name
	* Description

.. figure:: ./images/add-new-puppet-account.png
   :alt: Configuration Management Menu
   :align: center

.. note:: The Puppet Master Agent URL field is the ip or hostname and port that you
   configured ``espm`` to listen on and **NOT** the port Puppet clients communicate to the
   Puppet master over.

* Click "Save"
 
At this point, Enstratius will now begin discovery of your ``groups`` and ``classes``.

.. _saas_puppet_console_discovery:

Checking the status of discovery
--------------------------------

Once you've registered your account with Enstratius, a background thread will undertake the
task of enumerating the following information from your Puppet server:

* groups
* classes

Currently there is no visible progress on this action for the user. To check the progress
of discovery, do the following:

* Navigate to "Configuration Management" -> "Components"

.. figure:: ./images/cm-menu-components.png
   :alt: Configuration Management Menu
   :align: center

* Select your Puppet server from the drop-down titled "Select Configuration Management
  Account"

.. figure:: ./images/cm-components-account-menu-puppet.png
   :alt: Components Account Menu
   :align: center

The page will redraw and display a list of any ``groups`` and ``classes`` discovered along
with the date and time of discovery

.. figure:: ./images/puppet-cm-components-page.png
   :height: 900 px
   :width: 1400 px
   :alt: Discovery
   :align: center
   :scale: 50%

Asynchronous Discovery
~~~~~~~~~~~~~~~~~~~~~~

.. warning:: Because discovery is asynchronous, you might not immediately see all the data
   you expect to see.  As the page says, changes on the Puppet server may not be immediately
   reflected.  Currently there is no way to force a refresh of the discovery process.

Note that the asynchronous nature ONLY affects the ability of Enstratius to know what
objects are available for assignment when launching a server.  Enstratius discovers names of groups and classes but not the actual content. If you make a change to the content of an existing group or class that Enstratius has discovered, you do not need to wait for Enstratius to rediscover that group or class. However if you add a new group or class, it will not be immediately visible in Enstratius. The same applies for deleting groups and roles from Puppet.

This will become clearer when you launch a server the first time.

.. tip:: When making frequent changes to your modules, it can be difficult to test those
   especially when creating new groups and they have yet to be discovered by Enstratius (and
   thus are not visible in the ``Launch`` dialog for new instances). To work around this
   limitation, you can create a few empty test groups with no classes or parameters in them
   before registering the account with Enstratius. Now you can change the contents of those
   groups at will on the dashboard without Enstratius needing to know anything more than they
   exist.


.. _saas_puppet_agent:

Prepping an image
-----------------

To be able to launch an instance with Puppet (or any CM for that matter), you must meet
the following criteria:

* Your image has v17 of the Enstratius agent
* Your image shows as "registered" in the Enstratius Console under "Machine Images" (has the Enstratius logo)
* Your image has PE2.5 client installed with the appropriate template configuration files

Depending on your cloud provider and other factors (such as region), Enstratius may have
already made an image publicly available with the agent installed.

.. note:: There is an entire guide dedicated to the enStatus agent, however there are a few bits
   of information worth recapping here specifically as it relates to interaction with Puppet.

Differences from manual provisioning
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Simply put, Enstratius does not use SSH to interact with servers. All communication
(outside of the initial 'phone-home') is driven from Enstratius to launched instances via
the Enstratius agent.

The Enstratius agent is a Java application that is built around a series of extensible
shell scripts. This has its benefits in that what the agent does, can be customized by the
user.

In the case of a freshly launched instance, once it has sent its "alive" packet back to
Enstratius provisioning, Enstratius will, via the agent, run the following script:

``/enstratus/bin/runConfigurationManagement-PUPPET``

This script will get information passed to it via the Enstratius agent about your Puppet
account as well as your pregenerated and signed client certificates. By default, this
script will perform the following actions:

* Inspect the data passed down from Enstratius about the Puppet master. If the value is an
  IP address, a hosts file entry will be created pointing the names ``puppet`` and
  ``puppetmaster`` to that IP address. This is beneficial when you don't yet have a DNS
  entry pointing to your Puppet server.

At this point the agent expects to find the following files and directories on the filesystem:

* /etc/puppetlabs/puppet/puppet.conf
* /etc/puppetlabs/puppet/ssl/certs/
* /etc/puppetlabs/puppet/ssl/private_keys/

It expects the puppet.conf file to look like so:

::

   [main]
       vardir = /var/opt/lib/pe-puppet
       logdir = /var/log/pe-puppet
       rundir = /var/run/pe-puppet
       modulepath = /etc/puppetlabs/puppet/modules:/opt/puppet/share/puppet/modules
       user = pe-puppet
       group = pe-puppet
       archive_files = true
       archive_file_server = ES_PUPPET_MASTER

   [agent]
       certname = ES_NODE_NAME
       server = ES_PUPPET_MASTER
       report = true
       classfile = $vardir/classes.txt
       localconfig = $vardir/localconfig
       graph = true
       pluginsync = true

Technically the only critical values are the templates for ``ES_NODE_NAME`` and
``ES_PUPPET_MASTER``. Those will be replaced with the name assigned in the Enstratius
console and the host portion of the value you entered for the Puppet URL when adding the
configuration account. If the host portion was an IP address, this will be set to
``puppet`` and, as mentioned previously, a hosts file entry will be created to support
that.

* The pregenerated client certificate and key will be copied into the appropriate
  directories.

Finally the puppet client will be run with the following invocation:

``sudo puppet agent --onetime --no-daemonize --detailed-exitcodes --logdest=/mnt/tmp/es-puppet-firstrun.log``

.. note:: Detailed exit codes are used due to the fact that the launched instance may be
   part of an Enstratius deployment. The assumption is that if any part of the catalog fails
   to apply, the system is likely not in a state to serve its purpose. For that reason, any
   exit code of ``4``, ``6`` or ``1`` will be considered a failure to configure.

.. note:: Enstratius does not set up any cron jobs or run ``puppet agent`` in daemon mode.
   This is a site-specific setting and should be managed in your Puppet modules. Enstratius is
   only concerned about the initial bootstrap at this point. Enstratius does not currently initiate any
   puppet runs outside of this initial bootstrap except when used in Deployments.

It's worth noting here that Enstratius has removed the certificate signing step entirely.
Since we generate and sign the certificates BEFORE we launch the instance, the initial run
will not be blocked waiting on someone to sign the certificates nor will you have to turn
on auto-signing or use wildcards.

When terminating a server in Enstratius, it will also make a call back to the ``espm``
agent to delete the node from the ENC as well as revoke its certificates.

Customizing the bootstrap
~~~~~~~~~~~~~~~~~~~~~~~~~~

You can customize the ``/enstratus/bin/runConfigurationManagement-PUPPET`` script as
needed. Enstratius ships "opinionated" scripts but you can customize them as you see fit.
Enstratius only tests with the shipped scripts.

Making an Image available
~~~~~~~~~~~~~~~~~~~~~~~~~~

As stated, all interaction with instances from Enstratius is via the agent. Because of
this, Enstratius needs guarantees that the image can be trusted to have the Agent
installed.  To this end, there's a process that must be used:

Launch any public or Enstratius public machine image
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

As stated, Enstratius has been making updated images available with v17 of the agent
installed. You are also free to install the agent yourself.

Regardless of which image you launch (public, enstratus or preexisting), the image will be
untrusted. To create a "registered" image, you must image a running server from within
Enstratius. Depending on the cloud provider and the type of imaging (i.e. EBS root vs.
instance storage), Enstratius will perform the imaging process on any running instance that
it believes has the agent installed. Let's use the following screen shots as a guide:

* Navigate to "Compute" and "Machine Images" from the menu and search for public images
* with ``enstratus17`` in the name

.. figure:: ./images/public-ami-search.png
   :alt: Public AMI Search Menu
   :align: center

The image we'll be using for this document is ``ami-bd3c8ad4`` in AWS US-East and is
called ``Enstratius17-Ubuntu1004-64-2012090502``. It is an Ubuntu 10.04 64-bit image. It
also has Chef 0.10 installed from the Opscode "omnibus" installer.

* Launch the image

Click on the "action" menu for the image and select "Launch"

.. figure:: ./images/launch-image.png
   :alt: Launch Menu
   :align: center


You'll need to fill in the information as appropriate. For now, do NOT set anything in the
"Configuration Management" tab. If you plan on customizing the instance at all before
imaging, you'll want to launch it with an SSH key-pair configured.

.. figure:: ./images/base-launch.png
   :alt: Launch Screen
   :align: center


* Customize and make a new image

Once the instance is fully online (``Running`` in the server list) 

.. figure:: ./images/running-base.png
   :height: 100 px
   :width: 3300 px
   :alt: Running Base Image
   :align: left
   :scale: 25 %

|

and has detected the Agent is installed (Agent iconography), you can select ``Make Image``
from the instance's "actions" menu: 

.. figure:: ./images/make-image-menu.png
   :alt: Make Image
   :align: center


* Make note of the name you give the new image:

.. figure:: ./images/create-image-screen.png
   :alt: Create Image Screen
   :align: center

As this is an instance store instance, the appropriate ``ec2-bundle-*`` and
``ec2-upload-*`` will be run, via the Agent, on the instance. If this were an EBS volume,
the instance would be paused and the root EBS volume snapshotted.

Once the image process is complete, the image will be eventually available under "Compute"
-> "Machine Images" with the Enstratius logo visible next to it:

.. figure:: ./images/registered-image.png
   :height: 100 px
   :width: 3400 px
   :alt: Registered Image
   :align: center
   :scale: 25%

.. note:: Enstratius will add any public image you launch to your own list of machine images.


.. _saas_puppet_launch:

Launching an instance with Puppet
---------------------------------

Now that we have all the prerequisites in place, we're going to launch an instance that
will be handed over to Puppet for configuration.

Launching an image
~~~~~~~~~~~~~~~~~~~

From the Machine Images screen, we're going to launch the image that we just registered
with Enstratius. The steps are similar to the previous launch except that now options are
going to be set on the "Configuration Management" tab.

.. warning:: Please ensure that the image you are launching contains the Enstratius logo in
   the list. Configuration Management (and also advanced automation with Deployments) will
   **NOT** work without the Enstratius agent installed.

You can set any options you'd like but we're going to focus on the "Configuration Management" tab here:

.. figure:: ./images/puppet-cm-tab.png
   :alt: CM Launch Tab
   :align: center

You can see from this screen that the server has been assigned the group (``compliance_only``) and a few things have been added to the run list:

* the classes ``motd`` and ``wordpress``
* some parameters to be used for the wordpress module

This process is no different than what you would normally do with PE 2.5 console. The **ONLY** difference is that the initial agent run is being initiated via the Enstratius agent instead of via SSH.

Once you click the "Launch Server" button, Enstratius will do the following:

* contact the ``espm`` agent and attempt to create the node based on the name you gave it
* assign the groups, classes and parameters you've selected
* generate and sign the client certificates

Once this is complete, Enstratius will begin the process of making API calls to the cloud provider and then waiting for the instance to "phone home".
Once the server "phones home", Enstratius will make a call back to the agent to begin the configuration process. 

.. tip:: If Enstratius gets a conflict on creation of the node, due to its name it will
   take the existing name you specified and append a millisecond timestamp to the name. It
   will then attempt the registration process again.

If you switch over to your PE2.5 console, you can see that the node was already registered and Puppet is waiting for it to check in:

.. figure:: ./images/pe-console-new-node.png
	:alt: New PE node
	:align: center

You can track the progress of this via the "Logs" menu option:

.. figure:: ./images/puppet-launch-logs-first.png
   :alt: Initial logging
   :align: center

As you can see, Enstratius is populating the hosts file and copying some other things around that were passed down via the agent.

This process will take some time depending on the length of your bootstraps. You can use the "Tail" option to watch the agent log.
When the Puppet run is complete, it will send the full log of the run back to the agent. This is very helpful for debugging any issues in bootstrap:

.. figure:: ./images/puppet-launch-logs-second.png
   :alt: Later logging
   :align: center

At this point your instance has launched and should be working as defined by your Puppet modules (assuming those work). You can see from the report in the PE2.5 Console that there is some work to do with these modules.

.. figure:: ./images/puppet-node-run-peconsole.png
	:alt: PE Console Node Run
	:align: center
