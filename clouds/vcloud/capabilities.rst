Capabilities
------------

When working with Dasein Cloud vCloud, keep the following model map in
mind:

-  Template vApp -> Machine Image
-  vApp -> [nothing]
-  VM -> Virtual Machine
-  OrgNetwork -> VLAN
-  Disk -> Volume (vCloud 5.1+)

In particular, the relationship between vApps and VMs is a complicated
one. Dasein Cloud will launch any kind of template vApp, including
multi-VM templates. These will naturally result in the creation of a
vApp + multiple VMs in the vCloud cloud. Dasein Cloud will also see the
individual VMs that are created, but it mostly ignores the parent vApp
once created.
