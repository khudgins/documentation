.. _installation:

Installation
------------

enStratus engineers are working hard to simplify the enStratus cloud management software
process for proof-of-concept environments.

Here is reference material for installing enStratus in a vagrant instance and in single-
and two-node configurations.

Getting Started
~~~~~~~~~~~~~~~

Here are some things to consider before attempting an installation of the enStratus cloud
management software using the methods described in the :ref:`Single Node Install
<single_node_install>` and :ref:`Two Node Install <two_node_install>`.


DNS
^^^

For the installation, you will have to choose a domain name for the enStratus console. The
:ref:`Quickstart Guide <install_quick_start>` shows an example of an installation being
conducted specifying the domain ``cloud.mycompany.com``. 

The domain ``cloud.mycompany.com`` must be resolvable from any host trying to connect to
it. The easiest method for testing this is to make an entry in your hosts file. For
example, if the server upon which the enStratus console is installed has IP address
172.16.243.151, the proper hosts file entry to make is:

.. code-block:: bash

   172.16.243.151 cloud.mycompany.com

It is possible to :ref:`change the console url once the installation is complete.
<change_install_url>`

If you do this, remember to make the corresponding DNS resolution method change.

Web Browser
~~~~~~~~~~~

enStratus supports all modern web browsers. Here is a short list of support browsers.

* MSIE >= 8
* Chrome
* Firefox
* Safari

enStratus relies on javascript, so make sure it is enabled along with cookies.

For windows and MSIE users, here is a document discussing :ref:`MSIE compatibility mode <msie>`


.. toctree::
   :maxdepth: 2
   :hidden:

   centos/centos
   vagrant/vagrant
   single_node/single_node
   two_node/two_node
   single_node/post_install
