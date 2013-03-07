.. _registration:

Registration
------------

After installing the Enstratius cloud management software, you will be directed to proceed
to the url you specified as part of the installation process. For example:

.. code-block:: bash

   https://build.enstratus.com/page/1/register.jsp

.. figure:: ./images/register.png
   :height: 700px
   :width: 800px
   :scale: 75%
   :alt: Registration
   :align: center

   Registration

Successful Registration
~~~~~~~~~~~~~~~~~~~~~~~

In the dispatcher log, a successful registration looks like this:

.. code-block:: bash

   INFO: Server startup in 21386 ms
   2012-06-11 16:56:18,836 DEBUG [com.enstratus.provisioning.customer.CustomerFactory] enter
   - com.enstratus.provisioning.customer.CustomerFactory.createEnstratusCustomer
   (org.dasein.persist.Transaction@11,Enstratius,XXX,USD,true,America/Chicago)
   2012-06-11 16:56:18,836 DEBUG [com.enstratus.provisioning.customer.CustomerFactory] enter
   - com.enstratus.provisioning.customer.CustomerFactory.createEnstratusCustomer
   (org.dasein.persist.Transaction@11,Enstratius,XXX,USD,true,America/Chicago)
   2012-06-11 16:56:18,846 INFO  [com.enstratus.provisioning.customer.CustomerFactory]
   createEnstratusCustomer(): Creating new customer Enstratius
   2012-06-11 16:56:18,846 INFO  [com.enstratus.provisioning.customer.CustomerFactory]
   createEnstratusCustomer(): Creating new customer Enstratius
   2012-06-11 16:56:18,857 INFO  [com.enstratus.provisioning.customer.CustomerFactory]
   createEnstratusCustomer(): New customer is Enstratius [#200]
   2012-06-11 16:56:18,857 INFO  [com.enstratus.provisioning.customer.CustomerFactory]
   createEnstratusCustomer(): New customer is Enstratius [#200]
   2012-06-11 16:56:19,961 INFO  [com.enstratus.provisioning.customer.CustomerFactory]
   createEnstratusCustomer(): Default budget for Enstratius [#200] is Default [DEF]
   2012-06-11 16:56:19,961 INFO  [com.enstratus.provisioning.customer.CustomerFactory]
   createEnstratusCustomer(): Default budget for Enstratius [#200] is Default [DEF]
   2012-06-11 16:56:19,961 DEBUG [com.enstratus.provisioning.customer.CustomerFactory] exit -
   com.enstratus.provisioning.customer.CustomerFactory.createEnstratusCustomer()
   2012-06-11 16:56:19,961 DEBUG [com.enstratus.provisioning.customer.CustomerFactory] exit -
   com.enstratus.provisioning.customer.CustomerFactory.createEnstratusCustomer()
   2012-06-11 16:56:22,517 DEBUG [es.inf.200] enter -
   com.enstratus.provisioning.customer.service.CustomerServiceImpl.createCustomerBilling(Enstratius
   [#200],null,Enstratius,Enstratius Entry Plan,Default [DEF])
   2012-06-11 16:56:22,517 DEBUG [es.inf.200] enter -
   com.enstratus.provisioning.customer.service.CustomerServiceImpl.createCustomerBilling(Enstratius
   [#200],null,Enstratius,Enstratius Entry Plan,Default [DEF])

A successful registration indicates that the core components of the Enstratius management
system are operational (KM, Dispatcher, and Console).

After registration, you should be directed to log in for the first time, using the
credentials created during registration.

.. figure:: ./images/login.png
   :height: 300px
   :width: 300 px
   :scale: 95 %
   :alt: Login
   :align: center

   Login

If this is the first time logging in or there are no cloud accounts yet associated with
Enstratius, you will directed to select a cloud and enter credentials.
