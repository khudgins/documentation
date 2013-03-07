.. _vagrant_install:

Vagrant
-------

.. note::
 An Enstratius engineer will provide you with the necessary files to install an Enstratius Vagrant instance.

Quick Start
~~~~~~~~~~~

* Add the following entry to your hosts file 172.16.129.19 vagrant.vm (see below) Download
  and install Virtualbox (currently tested with Version 4.1.22 and 4.1.23 - don't do 4.2
  yet)

* Download and install Vagrant (http://vagrantup.com/)

* Set the appropriate env vars

.. code-block:: bash

   export ES_LICENSE=XXXXXXXXXXXXXXX
   export ES_DLPASS=YYYYYYYYYYYYYYYYY

Install the base box

.. code-block:: bash

   vagrant box add es-dev https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box

Optionally, define your local profile for reuse If you plan on suspending or halting this
machine (and resuming later), you'll want to ensure that you use the same profile each
time. If you do NOT set the profile at startup, a new random one will be generated. If you
generate a new random profile, the following bits of data are randomly generated:

* MySQL passwords
* Encryption keys

.. code-block:: bash

   export ES_PROFILE=my_local_profile

Run vagrant: ``vagrant up``

At this point you'll have to wait for console to finish the long, slow start.

Wait for this to load:

https://vagrant.vm/page/1/register.jsp

... and add your account.

After this, you'll need to log in with the new account and your cloud account.

You can also SSH in: ``vagrant ssh``

The Long Version
~~~~~~~~~~~~~~~~

Vagrant is a tool built around VirtualBox to provision your application code as a local
development environment. It natively understands various configuration management systems
such as Chef and Puppet. It also has a basic shell script provisioner and it automatically
mounts the directory containing its configuration file in the vm under /vagrant.

Since we have a repeatable and idempotent installation method for Enstratius via the solo
installer, it was very easy to "wrap" the installation process with the shell provisioner.
By adding the Vagrantfile, the solo installer is immediately available inside the launched
virtual machine.

How you should use this.

The instructions above will get you started VERY quickly. At the end of the vagrant up
command, you'll have a full enstratus environment based on the current production release
ready to go in a single VM.

There are a few options:

* To test code locally without dealing with the conflicts of a shared development
  environment.

* To test interaction of existing or new code running locally with services you might not
  have running locally (see port forwarding below)

Training/Learning Enstratius
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Note that this will ONLY deploy the latest released code. If you need to deploy unreleased
code, that process is up to you. However, hooks exist to help make the process a little
bit easier. See the section on environment variables below for more information.

Recap of the manual steps
~~~~~~~~~~~~~~~~~~~~~~~~~

* Add hosts file entry (one time)

* Set environment variables for download password and license key (add to
  .bashrc/.zshrc/.profile to make permanent)

* Register the first account
* Add your first cloud

Port forwarding
^^^^^^^^^^^^^^^

When Vagrant starts up, it will attempt to forward the following ports from your local
machine to the VM (remote port on left, local port on right)

.. code-block:: bash

   config.vm.forward_port 15000, 15000   # api
   config.vm.forward_port 3302, 3302     # dispatcher
   config.vm.forward_port 2013, 2013     # km
   config.vm.forward_port 5672, 5672     # RabbitMQ (autostarts)
   config.vm.forward_port 8098, 8098     # Riak HTTP (autostarts)
   config.vm.forward_port 8097, 8097     # Riak protobuf (autostarts)
   config.vm.forward_port 3306, 3306     # MySQL (autostarts)

The value here is that you can get a persistent data tier of an enstratus installation
that you can use from your local IDE as appropriate.

It's also configured to forward local port 8443 to 443 inside the VM but that doesn't work
due to web_address table and simplicis issues.

Environment variables
^^^^^^^^^^^^^^^^^^^^^

Because the installer requires fixed information to run (at a minimum - license key and
download password), conditional logic was set in the Vagrantfile to handle this based on
environment variables. This has been expanded to encompass as many tunables as possible.
Below is the list of currently exposed environment variables that you might want to tweek
to customize for your local environment.

ES_LICENSE and ES_DLPASS
^^^^^^^^^^^^^^^^^^^^^^^^

These are required and are your license key and download password. Note that BOTH of these
are unique to you individually and you are responsible for their use.

ES_VAGRANT_NW
^^^^^^^^^^^^^

This currently only supports one option: bridged. 

Bridged networking allows your VM to get an IP address from the same source as your system
itself. For all intents and purposes, a VM with Bridged networking is its own machine on
the network.

Note that for systems with multiple interfaces, Vagrant will ask you at startup which
interface to use. Which interface to use depends on which interface you are connected to
your local network with. On OSX, this is likely to be en0 if you are wired and en1 if you
are wireless. On Linux, eth0 will likely be your wired connection and wlan0 or eth1 will
be your wireless.

ES_DEVDIR
^^^^^^^^^

This variable is the full path to a directory on your LOCAL system that you want mounted
inside your VM at /es_dev_data.

The purpose for this is to allow you to more easily access your local code from inside the
VM. For instance, you might want to set this as the full path to your local git or svn
repos. You can also set this to your local .m2/repo directory to get a similar benefit.

ES_PROFILE
^^^^^^^^^^

This is analogous to the -s option for setup.sh in the installer. This creates a directory
under local_settings in the installer root named after the profile name.

It is designed to allow you to reuse a profile after the initial launch for minor
reconfiguration and as a way to persist encryption keys and MySQL passwords between runs
of Chef. This is because the MySQL passwords and encryption keys are dynamically generated
each run. If you wanted to be able to, say, change your sourceCidr or refererList values
you would need a savedir. Otherwise, setup will use a new random one and the run will fail
(since the MySQL passwords and encryption keys have already been created and registered).

When setup is run with the -s option, if the savedir specified does not exist a new one is
created. Final settings are written to config.yaml in the save directory. These are used
to build the JSON file for the chef-solo run. If the directory exists, then the node JSON
is simply regenerated based on the contents of the config.yaml. This is useful if you
change a value outside of setup.sh and want to regenerate the node JSON for rerunning
chef. Right now this isn't really a supported operation so the best bet is to simply set
the variable.

The only caveat to setting a savedir/profile name is that you might want to test something
on a fresh install. If you find that being the case, it's best to start vagrant like so as
a general rule:

ES_PROFILE=my-saved-profile vagrant up

Note that if you want to save and resume a vm, you should always use the same profile.

ES_CLOUD
^^^^^^^^

This controls the hostname you plan on using to access the installation. This is primarily
an on-premise option but if you want to use something other than vagrant.vm (like maybe
you want additional copies running at once), then feel free to set this. It's not required
for local development.

ES_CIDR
^^^^^^^

This is, again, primarily an on-premise setting but is VERY useful if you want to go the
full way and open up ports in your firewall to forward agent requests to yourself. These
follow the same rules as the sourceCidr configuration property.

ES_DEBUG
^^^^^^^^

Probably not needed. Used for debugging the chef-solor run itself.
