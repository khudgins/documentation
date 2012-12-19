.. _chef_prerequisites:

Chef
====

There are a few prerequisites required for end-to-end automation using Chef with enStratus:

* A working Chef server or Opscode Hosted Chef account
* A valid set of credentials to the Chef server
* A registered image in the cloud with enStratus agent v17 or higher
   
.. _saas_chef_credentials:

Generating credentials
----------------------

Before adding your Chef server to the enStratus console, you'll need two bits of information. This differs based on if you are running OSC vs. OHC/OPC.
Regardless of which type of Chef server product you are using, enstratus will need to be able to communicate with the Chef server API endpoint.
Additionally, enStratus will need an API client account and that account's PEM file. This single set of credentials will be used for the following tasks:

* Making API calls to the Chef server to read ``roles``, ``environments`` and ``cookbooks``.
* Bootstrapping new nodes via ``chef-client``
* Optionally, deleting node and client records after server termination

.. warning:: enStratus will NEVER alter any records on your Chef server. The logic simply
   doesn't exist in enStratus.  enStratus' access is read-only and only to the objects listed
   above. Please see the note below regarding ``admin`` access, however, if you'd like
   enStratus to take care of a few common termination-related tasks for you.

OSC
~~~

For OSC, you can either provide the existing validation credentials you currently use or
generate new credentials specifically for enStratus to use.  To generate custom
credentials for enStratus in OSC, you can use ``knife``:

``knife client create enstratus-validator -d -a``

::

	Created client[enstratus-validator]

	-----BEGIN RSA PRIVATE KEY-----
	MIIEoQIBAAKCAQEAvPSxK8lbC0ZAl+prCyQbR1Jv8hHj6vskK50V9H/r8N6YBUrN
	pftOiyvjzkb3zmfEaiUGKXoJxK4V2nzkU6qSvbQ/GOGUIZ+V3+t2YmdcvpudvVkA
	HbvIBZcbjmrQut/g61gFbLLw8rjQutc1Yad2Mdu1TBVgQVeBVGnnKVUus4iSYyAB
	16F236qP0N2IGidl1J1orCbAr2N/JuA0iwdXViX9onA5gZ7bSXcbP9FZRoN94gcb
	ZudgjelOBPIP7Qxfmfu/t9qhZzP8KyRUgpXpr0OVcDp48wHHVpPTMDajm+0gWIDq
	7N7Ze52mtzZGQ2LCd3d0SPIk5J51V3ROSgOqjQIDAQABAoIBAQCm5MU79Hw6yBEz
	XPSxAXIqm7COsaiKmsnGz9ddfkNKG4FQY1KigQZNvDVYs6waneKJEiyQI99O3agl
	s9wD3gwADJ0Sf+PTkt3Qymtk3QC4xkAbxuloWbyA24eWUdgMxsMlezhHWwGgkQaj
	kIPwvfWScgl+qv66l+x+P4/SHQ/Dt57H7jCjzqi20ViX+atH/8FoHTXJxwDuqu8D
	AYzMOqyL39TWvBxqa7ire4qx6OW0WBWlWLBYWrUO2RhOF5G+0vI2Uh0QwlJmyQdg
	WpEhLIS7yt1YwuSL/ph6fKcwM10dRAScRU35IQaMSYZV8/fbOOuYdFxFTCJHimp7
	A4G2gJdhAoGBAOleSqo64AlJWfgx5zB292zYwYlyzNNhCV5DeyHHdEzYCHJukvbc
	ch+UbUY3IXKz6MGA6Z5to7d0E5QE7JNotwQ0YBNbQzgZUxokU6oawix8vgelRqfL
	vwcn+6iTmgyyjyd82I+QaGD8vQ+i2/6vrgeetOnwJ6m2SMnuaJZQIi/VAoGBAM9H
	y6Zei+dnjykt5xnednvvu+Esp6+NBTZXpfG93f/+11vleF4lkwo6lwoTfkSZhbKh
	T8YpmATjhCtfI1XBf7LOwwzRfccH9dPUGO/gVswzpHMEDRGHVxwvJ83Jib04sakp
	hYqYvgd3gSuuDZNVqbACgTLCb3CwDLuKvKYdAyPZAn9Ci6C+6gr4mvIM1C4Yo9Pq
	NeT6TMIbhJAnURbLixSe1PuTpfRCcJoaZzjBzPa8vpCgnSIBC0KkDXWHv9+2KSYH
	DOhYnK2OUapgyfsRho/YH7oQdBCxyGeworYgW/aRqFkp6W/XgFZDUc6XptkUxwPZ
	KGhuTQ0CV/hpnJI2SqN1AoGAR1Fnk32SW3M5Qazmh/MQB0KL/UTVCUTXF0R+9zch
	rBPt21OP36zD89AG6dOdLVM5OiXggckL4hq5/gZE7RufqVEUsVNfGFz3ywN99QLW
	OnpGScCKEo7jfPIImviN6MoZ7p83sGEvePg4PGQtjZT6xnGGLIXTvA0GxHxOvkTb
	MLkCgYBSRpS2mc8yMH8K4PPMeIkogj8JL+gPrIvxHZypegcc1VuD7BCTZnVTb7eS
	ryChfYGSuFCMTrdJGzrcfC0AuBj0UpQVyq/VZxfnSGxjAZ9xmwnquP+c/QwiK9QV
	pN+rXdmloLy5YB4GXxiAFe/Yd4fYhTt6T33wY2V52y9qVra3lQ==
	-----END RSA PRIVATE KEY-----

Make note of the client name and also the private key returned to you.

.. note:: Note that we passed the ``-a`` option. This makes the enstratus account an
   administrator. This is optional but **HIGHLY** recommended.  If enStratus has permissions,
   it will clean up any node and client records for instances enStratus created. This is very
   valuable in cases where you are relying on search in your recipes as part of an enStratus
   deployment.  

   **Not only will enStratus never create any client or node records on its own
   but it will also NEVER delete any client or node records for anything OTHER than instances
   created from within enStratus**

OHC/OPC
~~~~~~~

For OHC/OPC, the finer grained ACL system doesn't allow you to create clients that have
the same permissions as OSC clients by default. For this you will have to do one of the
following

* Provide enStratus with the original validation cert and user-name or
* create a custom client as described above and then grant it the appropriate permissions

For creating a custom client, after creating the client with knife, log into the OPC/OHC
web UI and do the following:

* Create a group that you can easily identify as belonging to enStratus.
* Add the client previously created to this new group
* Add the new group to the ``admins`` group

As a side effect of these steps, your new client will now have the permissions it needs to
"clean up" any instances created by enStratus. This applies ONLY to instances created from
within enStratus. If you wish to grant the same permissions to your existing validation
client, simply follow the same steps for creating a custom group and adding it to the
``admins`` group.

.. _saas_chef_console_account:

Adding to enStratus
-------------------

Once you've created an account for enStratus to use and have the credentials, you can add
that to the enStratus console:

* Navigate to "Configuration Management" -> "Accounts"

.. figure:: ./images/cm-menu.png
   :alt: Configuration Management Menu
   :align: center

* Click the link on the right side to "Add A New Configuration Management Account"

.. figure:: ./images/add-new-cm-account.png
   :alt: Configuration Management Menu
   :align: center

* Select "Chef" from the "Configuration Management System" drop-down menu
* Fill in the fields as described.
	Note that specifically to enStratus, the following fields are required:
   
	* Budget Codes
	* Name
	* Description

.. figure:: ./images/add-new-chef-account.png
   :alt: Configuration Management Menu
   :align: center

* Click "Save"
 
At this point, enStratus will now begin discovery of your ``roles``, ``cookbooks`` and
``environments``.


.. _saas_chef_console_discovery:

Checking the status of discovery
--------------------------------

Once you've registered your account with enStratus, a background thread will undertake the
task of enumerating the following information from your Chef server:

* environments
* roles
* cookbooks (and recipes)

Currently there is no visible progress on this action for the user. To check the progress
of discovery, do the following:

* Navigate to "Configuration Management" -> "Components"

.. figure:: ./images/cm-menu-components.png
   :alt: Configuration Management Menu
   :align: center

* Select your Chef server from the drop-down titled "Select Configuration Management Account"

.. figure:: ./images/cm-components-account-menu.png
   :alt: Components Account Menu
   :align: center

The page will redraw and display a list of any ``roles`` and ``cookbooks`` discovered
along with the date and time of discovery

.. figure:: ./images/cm-components-page.png
   :height: 700 px
   :width: 1600 px
   :alt: Components Account Menu
   :align: center
   :scale: 50%

Asynchronous Discovery
~~~~~~~~~~~~~~~~~~~~~~

.. warning:: Because discovery is asynchronous, you might not immediately see all the data
   you expect to see.  As the page says, changes on the Chef server may not be immediately
   reflected.  Currently there is no way to force a refresh of the discovery process.

Note that the asynchronous nature ONLY affects the ability of enStratus to know what objects are available for assignment when launching a server. enStratus discovers names of cookbooks and the names of the recipes they contain, but does not discover the content. If you make a change to the content of an existing cookbook, recipe or role that enStratus has discovered, you do not need to wait for enStratus to rediscover that cookbook, role or recipe. However if you add a NEW recipe to a cookbook, it will not be immediately visible in enStratus. The same applies for deleting a recipe from a cookbook.

This will become clearer when you launch a server the first time.

.. tip:: When making frequent changes to your Chef cookbooks, it can be difficult to test those
   especially when creating new roles and they have yet to be discovered by enStratus (and
   thus are not visible in the ``Launch`` dialog for new instances). To work around this
   limitation, you can create a few empty test roles with no run_list in them before
   registering the account with enStratus. Now you can change the run_list of those roles at
   will on the Chef server without enStratus needing to know anything more than they exist.

.. _saas_chef_agent:

Prepping an image
-----------------

To be able to launch an instance with Chef (or any CM for that matter), you must meet the
following criteria:

* Your image has v17 of the enStratus agent
* Your image shows as "registered" in the enStratus Console under "Machine Images" (has the enStratus logo)
* Your image has Chef 0.10.x installed (optional)

Depending on your cloud provider and other factors (such as region), enStratus may have
already made an image publicly available with the agent installed.

.. note:: There is an entire guide dedicated to the enStatus agent, however there are a
   few bits of information worth recapping here specifically as it relates to interaction
   with Chef.

Differences from ``knife ec2`` or ``knife bootstrap``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Simply put, enStratus does not use SSH to interact with servers. All communication
(outside of the initial 'phone-home') is driven from enStratus to launched instances via
the enStratus agent.

The enStratus agent is a Java application that is built around a series of extensible
shell scripts. This has its benefits in that what the agent does can be customized by the
user.

In the case of a freshly launched instance, once it has sent its "alive" packet back to
enStratus provisioning, enStratus will, via the agent, run the following script:

``/enstratus/bin/runConfigurationManagement-CHEF``

This script will get information passed to it via the enStratus agent about your Chef
account and any runlist and environment related information. By default, this script will
perform the following actions:

* Look for ``chef-client`` on the path. If not found, the Opscode 'omnibus' installer will
  attempt to run and install Chef

Once Chef is installed (or detected), the script will begin to configure the local Chef
install and initiate an initial run:

#. Look for any existing Chef settings in ``/etc/chef`` and back them up
#. Build a new ``/etc/chef/client.rb``
#. Place the validation PEM (or credentials you provided), into ``/etc/chef``
#. Write the ``first-boot.json`` file
#. run ``sudo chef-client -j/etc/chef/first-boot.json -E <environment> -L /mnt/tmp/enstratus-chefrun.log``
#. After the run, remove the validation pem/credentials from disk

As you can see, enStratus is standing in for the ``knife bootstrap`` process.

.. note:: enStratus does not set up any cron jobs or run ``chef-client`` in daemon mode.
   This is a site-specific setting and should be managed in your Chef cookbooks. enStratus is
   only concerned about the initial bootstrap at this point. enStratus does not currently initiate any
   `chef-client` runs outside of this initial bootstrap except when used in Deployments.
   
Customizing the bootstrap
~~~~~~~~~~~~~~~~~~~~~~~~~~

You can customize the ``/enstratus/bin/runConfigurationManagement-CHEF`` script as needed.
enStratus ships "opinionated" scripts but you can customize them as you see fit. enStratus
only tests with the shipped scripts.

Making an Image available
~~~~~~~~~~~~~~~~~~~~~~~~~~

All interaction with instances from enStratus is via the agent. Because of
this, enStratus needs guarantees that the image can be trusted to have the Agent
installed.  To this end, there's a process that must be used:

**Launch any public or enStratus public machine image**

enStratus has been making updated images available with v17 of the agent
installed. You are also free to install the agent yourself.

Regardless of which image you launch (public, enStratus or preexisting), the image will be
untrusted. To create a "registered" image, you must image a running server from within
enStratus. Depending on the cloud provider and the type of imaging (i.e. EBS root vs.
instance storage), enStratus will perform the imaging process on any running instance that
it believes has the agent installed. Let's use the following screen shots as a guide:

* Navigate to Compute > Machine Images from the menu and search for public images
  with ``enstratus17`` in the name

.. figure:: ./images/public-ami-search.png
   :alt: Public AMI Search Menu
   :align: center
   :scale: 10 %

The image we'll be using for this document is ``ami-bd3c8ad4`` in AWS US-East and is
called ``enStratus17-Ubuntu1004-64-2012090502``. It is an Ubuntu 10.04 64-bit image. It
also has Chef 0.10 installed from the Opscode "omnibus" installer.

* Launch the image

Click on the "action" menu for the image and select "Launch"

.. figure:: ./images/launch-image.png
   :alt: Launch Menu
   :align: center
   :scale: 10 %


You'll need to fill in the information as appropriate. For now, do NOT set anything in the "Configuration Management" tab. If you plan on customizing the instance at all before imaging, you'll want to launch it with an SSH key-pair configured.

.. figure:: ./images/base-launch.png
   :alt: Launch Screen
   :align: center
   :scale: 10 %


* Customize and make a new image

Once the instance is fully on-line (``Running`` in the server list) 

.. figure:: ./images/running-base.png
   :height: 100 px
   :width: 3000 px
   :alt: Running Base Image
   :align: left
   :scale: 25%

|

and has detected the Agent is installed (Agent iconography), you can select ``Make Image``
from the instance's "actions" menu: 

.. figure:: ./images/make-image-menu.png
   :alt: Make Image
   :align: center
   :scale: 10 %


* Make note of the name you give the new image:

.. figure:: ./images/create-image-screen.png
   :alt: Create Image Screen
   :align: center
   :scale: 10 %

As this is an instance store instance, the appropriate ``ec2-bundle-*`` and
``ec2-upload-*`` will be run, via the Agent, on the instance. If this were an EBS volume,
the instance would be paused and the root EBS volume snapshotted.

Once the image process is complete, the image will be eventually available under "Compute"
-> "Machine Images" with the enStratus logo visible next to it:

.. figure:: ./images/registered-image.png
   :height: 100 px
   :width: 3300 px
   :alt: Registered Image
   :align: center
   :scale: 25%

.. note:: enStratus will add any public image you launch to your own list of machine images.


.. _saas_chef_launch:

Launching an instance with Chef
--------------------------------

Now that we have all the prerequisites in place, we're going to launch an instance that
will be handed over to Chef for configuration.

Launching an image
~~~~~~~~~~~~~~~~~~~

From the Machine Images screen, we're going to launch the image that we just registered
with enStratus. The steps are similar to the previous launch except we're now going to set
options on the "Configuration Management" tab.

.. warning:: Please ensure that the image you are launching contains the enStratus logo in
   the list. Configuration Management (and also advanced automation with Deployments) will
   **NOT** work without the enStratus agent installed.

You can set any options you'd like but we're going to focus on the "Configuration
Management" tab here:

.. figure:: ./images/chef-cm-tab.png
   :alt: CM Launch Tab
   :align: center
   :scale: 10 %

You can see from this screen that the server was assigned the ``demo`` environment and a few things have been added to the runlist:

* role "demo-role-1"
* recipe "git"

.. note:: This order is the one passed into the bootstrap process. You can reorder and
   remove as you like.

This process is no different than what you would normally do with ``knife bootstrap``. The
**ONLY** difference is that the bootstrap is being initiated via the enStratus agent
instead of via SSH.

Once you click the "Launch Server" button, enStratus will begin the process of making API
calls to the cloud provider and then waiting for the instance to "phone home".  Once the
server "phones home", enStratus will make a call back to the agent to begin the
configuration process. You can track the progress of this via the "Logs" menu option:

.. figure:: ./images/chef-launch-logs-first.png
   :alt: Initial logging
   :align: center
   :scale: 10 %

As you can see, we're building the ``client.rb`` and copying some other things around that
were passed down via the agent.

This process will take some time depending on the length of your bootstraps. You can use
the "Tail" option to watch the agent log.  When the Chef client run is complete, it will
send the full log of the run back to the agent. This is very helpful for debugging any
issues in bootstrap:

.. figure:: ./images/chef-launch-logs-second.png
   :height: 400 px
   :width: 2000 px
   :alt: Later logging
   :align: center
   :scale: 40%

At this point the instance has launched and you should see it registered with the Chef
server. In the case of the demo role, it is serving a static page populated from an ERB
template.
