.. _agent_install:

Installation
------------

Installing and using the Enstratius agent is easier than ever. Use this quick start
information to hit the ground running.

Linux - Quick Start
~~~~~~~~~~~~~~~~~~~

As root:

.. code-block:: bash

   curl -L http://es-download.s3.amazonaws.com/install.sh | bash

.. note::

        * Enstratius agent is not compatible with SELinux. Please make sure to disable SELinux before the installation.
        * Enstratius agent uses TCP 2003 port for communication with provisioning server. Please make sure to open the port.

After the installation, start the agent service by running the following command. Enstratius agent service will automatically start after reboot.

As root:

.. code-block:: bash

   /etc/init.d/tomcat-enstratus start

If you have problems downloading service images in deployments, please install stable version of the agent.

.. note:: The stable version of the agent is only for on-premise users who use pre-H2/H3 releases.

As root:

.. code-block:: bash

   curl -L http://es-download.s3.amazonaws.com/install-stable.sh | bash

**Tarball Installation Guide (Not Recommended)**

:ref:`Ubuntu/Debian <ubuntu_agent_install>`

:ref:`RHEL/CentOS <rhel_agent_install>`

Windows - Quick Start
~~~~~~~~~~~~~~~~~~~~~

Windows has an `MSI <http://es-download.s3.amazonaws.com/enstratus-agent-windows-generic.exe>`_ installer for installing the agent. 

**Windows Agent Installation Guide**

:ref:`Windows Server 2003/2008 <windows_agent_install>`

.. toctree::
   :maxdepth: 1
   :hidden:

   rhel
   debian
   windows
