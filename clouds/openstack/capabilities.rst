Capabilities
------------

The Dasein Cloud OpenStack implementation attempts to support all
aspects of all versions of OpenStack. In doing so, Dasein Cloud executes
the following mapping:

-  Servers/instances -> VirtualMachine
-  Images -> MachineImage
-  Cinder or Nova Volumes -> Volume
-  Snapshots -> Snapshot (Folsom+ or HP extension)
-  Keypairs -> SSHKeypair
-  Security Groups -> Firewall
-  Floating IPs -> IpAddress
-  Swift Object Store -> BlobStore

In addition, several vendor specific abstractions are mapped: \* Load
Balancers -> LoadBalancer (Rackspace) \* CDN -> CDN (HP, Rackspace) \*
DNS -> DNS (Rackspace) \* Relational Database -> RelationalDatabase (HP,
Rackspace)

Keep in mind that all conditional scenarios outlined in this document
can be ignored. You can focus on the meta-data that Dasein Cloud
provides.

Keystone and the OpenStack Service Catalog
------------------------------------------

You do not need to worry about Keystone vs. non-Keystone authentication.
Dasein Cloud attempts both before failing. Dasein Cloud uses the service
catalog to determine what services are available in a specific cloud.
Dasein Cloud will therefore function with any environment having any of
the above services in any combination as long as those services show in
the service catalog.

Extensions
----------

Dasein Cloud looks at the service catalog for available services and
then maps those services to implementations based on whether they are
standard services or extensions. Right now, extensions from HP and
Rackspace are supported based on the value in the
ProviderContext.getProviderName() field (see `the Configuration wiki
page <https://github.com/greese/dasein-cloud-openstack/wiki/Configuration>`_
for more information).

Glance
------

Glance is not supported at this time.
