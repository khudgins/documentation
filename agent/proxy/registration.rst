.. _agent_proxy_registration:

Registration
------------

After an agent proxy is running, enStratus will not recognize agent traffic
from it until it has been registered.

This guide shows you how to register (and deregister) agent proxies using the
UI. It assumes you have been through all of the other pages in the agent proxy
documentation, in particular you have installed an agent proxy following the
:ref:`Installation <agent_proxy_installation>` section.

There are two different ways to register agent proxies:

1. Selecting a server because the agent proxy is running on a node that has
been detected or launched by enStratus.

2. Entering an arbitrary IP:port to handshake with.

After you do one of those things (see the corresponding section below), the
same final step must occur (see the "ID validation" section below).

Registering via enStratus server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use this method if the agent proxy is running on a node that has been detected
or launched by enStratus.

TODO: screenshots

Registering via IP:port
~~~~~~~~~~~~~~~~~~~~~~~

Use this method if the agent proxy is running on a node that has not been
detected or launched by enStratus. Or if the IP:port coordinates are manually
set up (for example, you have manually created a port forwarding rule to a
private cloud resource).

TODO: screenshots

ID validation
~~~~~~~~~~~~~

After you finish one of the above steps that selects the target for handshaking,
enStratus will contact the agent proxy service. It will call on a special
operation for handshaking and then the enStratus UI will display the ID that
the agent proxy was configured with (or give you an error such as "connection
refused").

TODO: screenshots

If this ID is accurate, click confirm:

TODO: screenshot

Now proceed with an end to end test (see the end of the
:ref:`Installation <agent_proxy_installation>` section).

Deregistering
~~~~~~~~~~~~~

TODO: screenshot


