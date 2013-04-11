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

If you have problems downloading service images in deployments, please install stable version of the agent. Stable packages are for on-premise pre-H2/H3 releases.

As root:

.. code-block:: bash

   curl -L http://es-download.s3.amazonaws.com/install-stable.sh | bash


**Tarball Installation Guide (not recommended)**

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
