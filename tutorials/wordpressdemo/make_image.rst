Make Image
----------

This tutorial has been tested with `Alestic <http://alestic.com/>`_ Ubuntu images, `Bashton <http://www.bashton.com/>`_ CentOS images and `SUSE <https://www.suse.com/>`_ Linux Enterprise Server images. Alestic's Ubuntu server image is highly recommended since this deployment demo has been tested with it for many times.

.. figure:: ./images/ami0.png
   :height: 400px
   :width: 1800 px
   :scale: 50 %
   :alt: Search for AMI
   :align: center

   Search for AMI

1. Choose at least m1.small product size. Some services will not work in t1.micro instances.
   Also, generate and use an SSH key during the launch.

.. figure:: ./images/ami1.png
   :height: 600px
   :width: 850 px
   :scale: 50 %
   :alt: Launch, General Information
   :align: center

   Launch, General Information

Save the key and chmod it

.. code-block:: bash

   chmod 600 demoKey

.. figure:: ./images/ami3.png
   :height: 450px
   :width: 1200 px
   :scale: 50 %
   :alt: Launch, Create/Use Key
   :align: center

   Launch, Create/Use Key

2. While the image launches, open the firewall so you can access port 22 from your
   location.

3. Once the VM is started, ssh onto the running instance, and take root:

.. code-block:: bash

   Ubuntu -> ssh -i demoKey ubuntu@ip.of.running.instance
   CentOS -> ssh -i demoKey ec2-user@ip.of.running.instance
   SUSE   -> ssh -i demoKey root@ip.of.running.instance

   sudo su

4. Install the chef client.

.. code-block:: bash

   curl -L http://www.opscode.com/chef/install.sh | sudo bash 

5. Download the wordpress demo preparation cookbook and extract files from it.

.. code-block:: bash

   curl -O http://es-download.s3.amazonaws.com/wordpress-demo-prep.tar.gz
   tar -xvf wordpress-demo-prep.tar.gz > /dev/null 2>&1

6. Execute the chef-solo to run the preparation cookbook.

.. note:: If prompted for the Chef Server URL, just hit enter.  This tutorial does not rely on a chef-server.

.. code-block:: bash

   cd wordpress-demo-prep
   chef-solo -j node.json -c solo.rb 

.. note:: For reference, when running this on a m1.large VM in th us-west-2 (Oregon)
  region, the above script took 3 minutes and 9 seconds.

During this step, some packages necessary for running a typical LAMP stack application
will be installed, along with the latest Enstratius agent. Depending on your connection and
mirror speeds, this may take up to 5-7 minutes.

The purpose of this step is to prepare the image for running PHP and MySQL applications,
not to install the application itself, that comes later during the launch and orchestration
steps of a deployment launch.

Once this step completes, initiate the build of the machine image from within the
Enstratius console.

.. warning:: If the image is not built using the server actions > Make Image menu option
  in the Enstratius console, it will not be available for use in the deployment. This measure
  is in place to protect users from attempting to use an image that does not have the agent
  on it for automation.

.. note:: As a sanity check that the agent is working, you should see an expanded list of
  options in the actions menu as shown.

.. figure:: ./images/makeImage1.png
   :height: 700px
   :width: 2500 px
   :scale: 35 %
   :alt: Server, Make Image
   :align: center

   Server, Make Image

Once this process completes, select action > Make Image from the server's action menu.

.. figure:: ./images/makeImage0.png
   :height: 300px
   :width: 700 px
   :scale: 50 %
   :alt: Make Image
   :align: center

   Make Image

While the image builds, it's time to upload the service images for use by Enstratius.
