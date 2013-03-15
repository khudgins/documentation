.. Enstratius documentation master file, created by
   sphinx-quickstart on Mon Mar 12 21:46:44 2012.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.


On-Premise
==========

On-Premise installations of Enstratius make sense for many reasons, and, due to the
flexibility of the Enstratius architecture, you can deploy Enstratius as a single-node
personal development environment, two-node POC, or a fully scaled high-availability cloud
management solution.

For supported OS/Distributions, please visit the :ref:`Reference Architecture
<reference_architecture>` page for some examples and recommendations.


Developers
----------

.. figure:: ./images/developers.png
   :height: 232 px
   :width: 922 px
   :scale: 85 %
   :alt: Developers
   :align: center

Setting up a development Enstratius environment or a single-node Enstratius environment for
sales/demonstration purposes just got a whole lot simpler. By leveraging vagrant, you can
install the full Enstratius cloud management software stack in less than 15 minutes,
depending on your network speed.


POC
---

.. figure:: ./images/poc.png
   :height: 190 px
   :width: 869 px
   :scale: 85 %
   :alt: Customers
   :align: center

Installing Enstratius cloud management software as part of a POC can be done by leveraging
a configuration management engine like Chef from Opscode.

We'll show you how to install Enstratius in a 1 or 2-node architecture.

Production
----------

.. figure:: ./images/ha_enstratus.png
   :height: 588 px
   :width: 931 px
   :scale: 85 %
   :alt: High-Availability Enstratius Architecture
   :align: center

Enstratius can also be deployed in a High-Availability production architecture to support
hundreds of users and cloud accounts. 

.. toctree::
   :maxdepth: 3
   :hidden:
   :glob:

   architecture/architecture
   requirements/requirements
   installation/installation
   administration/administration
   help/help
   downloads
