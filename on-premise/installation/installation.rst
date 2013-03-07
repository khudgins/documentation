.. _installation:

Installation
------------

Enstratius engineers are working hard to simplify the Enstratius cloud management software
process for proof-of-concept environments.

Here is reference material for installing Enstratius in a vagrant instance and in single-
and two-node configurations.

.. warning:: Installation in a multi-node environment cannot automatically resolve "external" issues
   such as firewalls that may separate nodes and DNS. If in doubt of your DNS situation or
   your ability to edit /etc/hosts files, please use IP Addresses in lieu of hosts names
   where applicable.

.. toctree::
   :maxdepth: 2
   :hidden:

   vagrant/vagrant
   single_node/single_node
   two_node/two_node
   single_node/post_install
