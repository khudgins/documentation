Init Scripts
------------

Each service should have installed an associated init script, located in /etc/init.d/

Enstratius Init Scripts
~~~~~~~~~~~~~~~~~~~~~~~

.. tabularcolumns:: |l|l|l|

+----------------+----------------------------------+-------------+
| Component      | Init Script                      | Usage       |
+================+==================================+=============+
| Key Management | /etc/init.d/enstratus-km         | start, stop |
+----------------+----------------------------------+-------------+
| Pound          | /etc/init.d/enstratus-pound      | start, stop |
+----------------+----------------------------------+-------------+
| Dispatcher     | /etc/init.d/enstratus-dispatcher | start, stop |
+----------------+----------------------------------+-------------+
| Monitor        | /etc/init.d/enstratus-monitor    | start, stop |
+----------------+----------------------------------+-------------+
| Assign         | /etc/init.d/enstratus-assign     | start, stop |
+----------------+----------------------------------+-------------+
| Publisher      | /etc/init.d/enstratus-publisher  | start, stop |
+----------------+----------------------------------+-------------+
| Subscriber     | /etc/init.d/enstratus-subscriber | start, stop |
+----------------+----------------------------------+-------------+
| Console        | /etc/init.d/enstratus-console    | start, stop |
+----------------+----------------------------------+-------------+
