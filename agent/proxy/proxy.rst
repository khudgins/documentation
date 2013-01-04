.. _agent_proxy:

Agent Proxy
-----------

Without the ability to interact with an enStratus agent on your cloud resources,
many automation and security features are not supported. The enStratus agent
proxy is a service installed on a node (or set of nodes) running on a cloud or
on-premises network that allows enStratus to contact resources that would
otherwise be inaccessible.

If you are new to the agent proxy, see the :ref:`Background
<agent_proxy_background>` section. This gets into some common cloud networking
issues and how the agent proxy solves them.

The :ref:`Operations <agent_proxy_operations>` section lays out the
technical prerequisites and deployment options. What OS to use, what firewall
rules need to be in place, how load balancing works, etc.

Going through the steps to install and use agent proxies is covered in two
sections. The :ref:`Installation <agent_proxy_installation>` section will guide
you through downloading and installing the agent proxy software proper. The
:ref:`Registration <agent_proxy_registration>` section covers the final steps
needed to tie everything together.

.. toctree::
   :maxdepth: 1
   :hidden:

   background
   operations
   installation
   registration
