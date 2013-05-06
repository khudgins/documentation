.. _agent_install:

Installation
------------

Installing and using the Enstratius agent is easier than ever. Use this quick start
information to hit the ground running.

Linux - Quick Start
~~~~~~~~~~~~~~~~~~~

.. note::

        * Enstratius agent is not compatible with SELinux. Please make sure to disable SELinux before the installation.
        * Enstratius agent uses TCP 2003 port to communicate with enstratius servers. Please make sure to open the port.
        * Stable version of the agent is only for pre-H2/H3 on-premise users who have problems on downloading service images in deployment.

**Quick Install using one-line installer**

Run the following command on the target system. It will download and install the latest version of the agent.

As root:

.. code-block:: bash

   (Latest Agent) curl -L http://es-download.s3.amazonaws.com/install.sh | bash
   (Stable Agent) curl -L http://es-download.s3.amazonaws.com/install-stable.sh | bash

Enstratius agent service starts automatically after reboot. If you want to start the agent service at once, run the following command. 

As root:

.. code-block:: bash

   /etc/init.d/tomcat-enstratus start

**Tarball Installation Guide (Not Recommended)**

:ref:`Ubuntu/Debian <ubuntu_agent_install>`

:ref:`RHEL/CentOS <rhel_agent_install>`

Windows - Quick Start
~~~~~~~~~~~~~~~~~~~~~

**Download**

`Latest Enstratius Agent for Windows Server <http://es-download.s3.amazonaws.com/enstratus-agent-windows-generic.exe>`_

**Installation Guide**

:ref:`Windows Server 2003/2008 <windows_agent_install>`

.. toctree::
   :maxdepth: 1
   :hidden:

   rhel
   debian
   windows
