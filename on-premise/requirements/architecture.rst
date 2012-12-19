Architecture
------------

.. figure:: images/enstratusArchitecture.png
   :height: 650px
   :width: 900 px
   :scale: 75 %
   :alt: 4-server Architecture
   :align: center

   Example Architecture

#. Communications from the Monitor/Workers processes to the guest VM agent on port 2003
   for the purpose of collecting logs.
#. Bi-directional communications between the dispatcher service and the guest VM agent.

   * Initiated by the guest VM enStratus agent during handshake to the dispatcher service
     on port 3302

   * Initiated by the enStratus dispatcher service to the guest VM enStratus agent on port
     2003

#. Communications from the enStratus dispatcher service to the cloud provider API
   endpoint.
#. Communications from the enStratus monitor and worker services to the cloud provider API
   endpoint.
