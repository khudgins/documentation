.. _onpremise_resources:

Resources
---------

Operating System
~~~~~~~~~~~~~~~~

The reqiured operating system is Linux.

Tested distributions include:

`CentOS 6 <http://isoredirect.centos.org/centos/6/isos/x86_64/>`_

`Ubuntu 12.04.x LTS <http://releases.ubuntu.com/precise/>`_

We have provided our reference machines available in OVA and vagrant 'box' format on the
:ref:`On-Premise Downloads <on_premise_downloads>` page.

.. note:: Red Hat Enterprise Linux installations are common, and Enstratius software will
   run on RHEL, but our development team does not actively test against RHEL for several
   reasons:

   #. Because of RHEL licensing, it's very difficult to perform our automated testing so it
      must be done manually.

   #. CentOS is an acceptable analog in most cases for applying the install to RHEL

Processor Architecture 
~~~~~~~~~~~~~~~~~~~~~~~

Enstratius requires X86_64.

Hardened OS
~~~~~~~~~~~

To the maximum extent possible, hardening of the installation environment should be done
*after* the installation of Enstratius and supporting software.

Vagrant
~~~~~~~

Recommended resources for a vagrant installation is minimally:

* 2 CPU cores
* 4Gb of Memory
* 20 Gb of local storage

Single-Node POC
~~~~~~~~~~~~~~~

* 2 CPU (4 recommended)
* 8GB of Memory (16GB recommended)
* 80GB of LOCAL contiguous disk space

Two-Node POC
~~~~~~~~~~~~

Console
^^^^^^^

* 2 CPU (4 recommended)
* 8GB of Memory (16GB recommended)
* 80GB of LOCAL contiguous disk space

Backend
^^^^^^^

* 4 CPU 
* 8GB of Memory (16GB recommended)
* 80GB of LOCAL contiguous disk space
