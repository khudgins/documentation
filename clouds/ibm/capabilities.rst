Capabilities
------------

IBM SmartCloud support is one of the newest clouds to be supported in
Dasein Cloud. There are consequently a few features that will wait until
the next release of Dasein Cloud for full implementation. The following
represents the general mapping of concepts:

-  Virtual machines -> VirtualMachine
-  Images -> MachineImage
-  Disks -> Volume
-  SSH Keys -> SSHKeypair
-  Static IPs -> IpAddress
-  Networks -> VLAN

Caveats
-------

Dasein Cloud has no way of specifying a static IP at VM deployment.
SmartCloud has no way of dynamically changing a static IP post-launch.
As a result, you can currently list static IPs via Dasein Cloud and
manage their existence, but you can't actually associated them with
virtual machines. The ability to specify a static IP at VM deployment
will be added in the next Dasein Cloud.

Some SmartCloud public machine images require user data. Dasein Cloud
has no way of recognizing this or telling a client that user data is
required for a specific image.
