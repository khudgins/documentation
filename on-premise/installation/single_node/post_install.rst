.. _post_install:

Post Install
------------

.. _register:

Register
~~~~~~~~

In your browser, navigate to https://cloud.mycompany.com/page/1/register.jsp,
replacing cloud.mycompany.com with the url you specified in in your attributes file.

.. note:: You may have to modify your DNS settings via a hosts file entry or other means
   to reach the URL.

Successful registration will direct the user to a page where cloud credentials can be
entered. Before proceeding, let's start the worker and monitor services.

.. figure:: ./images/register.png
   :height: 700px
   :width: 900 px
   :scale: 55 %
   :alt: Registration
   :align: center

   Registration

**Enter Cloud Credentials**

Return to the browser to enter your cloud credentials for the cloud provider of your
choosing.

MySQL
~~~~~

The root password for MySQL was generated at the time of installation. The password will
be located in ``/etc/mysql/grants.sql`` on Debian derivatives and
``/etc/mysql_grants.sql`` on RHEL and CentOS.
