Capabilities
------------

The Dasein Cloud CloudStack implementation attempts to support all
aspects of CloudStack that are reflected in the Dasein API. Dasein Cloud
CloudStack specifically supports:

-  VirtualMachines -> VirtualMachine
-  Templates -> MachineImage
-  Volumes -> Volume
-  Snapshots -> Snapshot
-  Keypairs -> SSHKeypair
-  Networks -> VLAN
-  Security Groups -> Firewall
-  IpAddresses -> IpAddress
-  LoadBalancers -> LoadBalancer

Keep in mind that all conditional scenarios outlined in this document
can be ignored. You can focus on the meta-data that Dasein Cloud
provides. The information in this document simply exists to illustrate
how Dasein Cloud maps CloudStack concepts and capabilities.

For example, the identifyVLANRequirement() method in virtual machine
support handles all the logic to tell you whether or not you need to
specify a CloudStack network when deploying a virtual machine. It looks
like this:

::

    public @Nonnull Requirement identifyVlanRequirement() throws CloudException, InternalException {
        if( provider.getVersion().greaterThan(CSVersion.CS21) ) {
            ProviderContext ctx = provider.getContext();

            if( ctx == null ) {
                 throw new CloudException("No context was set for this request");
            }
            String regionId = ctx.getRegionId();

            if( regionId == null ) {
                throw new CloudException("No region was set for this request");
            }
            return (provider.getDataCenterServices().requiresNetwork(regionId) ? Requirement.REQUIRED : Requirement.OPTIONAL);
        }
        return Requirement.OPTIONAL;
    }

Basic Networking, Advanced Networking, and Security Groups
----------------------------------------------------------

Dasein Cloud CloudStack is aware of basic differences between basic
networking support and advanced networking, but it also makes some
critical assumptions that may not be true in some customer deployments.
In particular, support for security groups exists only when a zone is
set to securitygroupsenabled = true and networking is basic or there are
no advanced networks.

VM Deployment and Networks
--------------------------

If you attempt to deploy a VM into a VLAN, Dasein Cloud will pass that
information on to CloudStack.

If you attempt to deploy a VM without specifying a VLAN, the following
logic applies:

-  If it's a version of CloudStack that does not support networks, it
   deploys as normal.
-  Otherwise, it checks to see if a network is required. If no network
   is required, it will launch without one.
-  If a VLAN is required, it will attempt to identify a free network.

A network is considered required for CloudStack 2.2 and above in zones
with advanced networking.

A free network is a crapshoot in CloudStack 2.2. Dasein Cloud simply
looks for the first network in the zone.

CloudStack 3.x, however, provides a reliable mechanism for determining a
"free network".
