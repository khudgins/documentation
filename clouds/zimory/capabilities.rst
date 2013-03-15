Capabilities
------------

The Dasein Cloud Zimory implementation attempts to support all aspects
of Zimory that are reflected in the Dasein API. Dasein Cloud Zimory
specifically supports:

-  Deployments -> VirtualMachine
-  Appliances -> MachineImage
-  NetworkVolume -> Volume

Dasein Cloud regions/data centers are more complex. Essentially, every
Dasein Cloud region in Zimory has exactly one data center with the same
ID as the region.

The Dasein Cloud region maps to a location/provider pair. The ID is the
combination of the location ID and the provider ID.
