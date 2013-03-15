Capabilities
------------

The following represents the general mapping of CloudSigma concepts to
Dasein Cloud concepts:

-  Servers -> VirtualMachine
-  Standard Drives, Drives with OS -> MachineImage
-  Drives -> Volume
-  VLANs -> VLAN
-  Static IPs -> StaticIP

API Support
-----------

This implementation supports the 1.x version of the CloudSigma API. It
supports both email and API key authentication. It is **STRONGLY**
recommended that you talk to CloudSigma endpoints via HTTPS since
CloudSigma uses HTTP Basic Authentication and thus is at high risk over
plain HTTP.

Regions
-------

CloudSigma regions are actually distinct clouds to Dasein Cloud. In
other words, you will look at Las Vegas as if it is one cloud with one
endpoint, and Zurich as if it is a completely separate cloud. This, the
listRegions() call will always ever return a single region.

Drives
------

Dasein Cloud represents some drives as machine images and others as
volumes. Some are shown as both.

All drives returned via the /drives/info call will be minimally
represented as volumes. If the drive has a bootable OS, it will also
appear as a machine image.

All drives returned via /drives/standard/img/info will be represented
only as machine images in the public library.
