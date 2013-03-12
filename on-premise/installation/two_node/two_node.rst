.. _two_node_install:

Two Node
--------

.. figure:: ./images/two_node.png
   :height: 335 px
   :width: 555 px
   :scale: 85 %
   :alt: Enstratius Two Node Architecture
   :align: center

   Enstratius Two Node Architecture

The two-node Enstratius deployment separates the software into so-called backend and
frontend components.

+-------------------------------+------------------------------------+
| **Back End Services**         | **Front End Services**             |
+===============================+====================================+
| Dispatcher                    | Console                            |
+-------------------------------+------------------------------------+
| Provisioning Database (MySQL) | Console Database (MySQL)           |
+-------------------------------+------------------------------------+
| Analytics Database (MySQL)    | Enstratius Console Database (MySQL)|
+-------------------------------+------------------------------------+
| Workers                       | API                                |
+-------------------------------+------------------------------------+
| Monitors                      | Console Worker (LDAP/AD Module)    |
+-------------------------------+------------------------------------+
| Key Manager                   |                                    |
+-------------------------------+------------------------------------+
| Credentials Database (MySQL)  |                                    |
+-------------------------------+------------------------------------+
| Riak                          |                                    |
+-------------------------------+------------------------------------+
| Rabbit MQ                     |                                    |
+-------------------------------+------------------------------------+

Installation Overview
~~~~~~~~~~~~~~~~~~~~~

A chef-solo cookbook wrapped in a command-line utility is provided to facilitate the
installation of software prerequisites along with installing the Enstratius software.

Quick Start
~~~~~~~~~~~

Requirements
^^^^^^^^^^^^

#. Enstratius license key
#. Enstratius download password
#. Enstratius bootstrap tool
#. A domain name for the installation
#. IP addresses of both servers

For the quick start, let's assume:

license_key=abcd1234
download_password=wxyz6789
domain_name=cloud.mycompany.com
backend_ip=192.168.1.1
frontend_ip=192.168.1.2 (mapped to cloud.mydomain.com)

To perform the installation, start on the backend server, as root:

.. code-block:: bash

   ./setup -p wxyz6789 -l abcd1234 -c cloud.mycompany.com -n 2 -m backend:192.168.1.1,frontend:cloud.mydomain.com -s my-two-node-cloud

alternatively

.. code-block:: bash

   ./setup -p wxyz6789 -l abcd1234 -c cloud.mycompany.com -n 2 -m backend:192.168.1.1,frontend:192.168.1.2 -s my-two-node-cloud

This command tells installer:

-n 2 : the number of nodes for the install is 2
-m mapping string identifying the backend as 192.168.1.1, frontend as 192.168.1.2
-s A name or "profile" for the installation, called my-two-node-cloud

Once the preparation work of creating the configuration files is complete, run as root:

.. code-block:: bash

   chef-client -j local_settings/my-two-node-cloud/backend.json -c client.rb

Once the installation on the backend has completed, copy the
``local_settings/my-two-node-cloud`` directory to the frontend machine, and run the
as root:

.. code-block:: bash

   chef-client -j local_settings/my-two-node-cloud/frontend.json -c client.rb

The install will take a few moments to complete, the installation. Once completed, you
should be able to :ref:`register`

System Requirements
~~~~~~~~~~~~~~~~~~~

Provision two servers (can be virtual, we often test using m1.large instances in EC2) for
the installation.

+-------------------------------------------+-------------------------------------------+
| **Recommended Specifications (Backend)**  | **Recommended Specifications (Frontend)** |
+===========================================+===========================================+
| CPU: 4                                    | CPU: 2                                    |
+-------------------------------------------+-------------------------------------------+
| Memory: 12 Gb                             | Memory: 8 Gb                              |
+-------------------------------------------+-------------------------------------------+
| Storage: 60 Gb                            | Storage: 30 Gb                            |
+-------------------------------------------+-------------------------------------------+
| Architecture: 64-bit                      | Architecture: 64-bit                      |
+-------------------------------------------+-------------------------------------------+

An m1.xlarge will fill these requirements quite well. You can probably get by with
an m1.large to save on costs.

**Recommended Images**

Start with a generic EC2 image from `Alestic <http://alestic.com/>`_ or the equivalent in
your environment. 
