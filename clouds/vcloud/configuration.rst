Configuration
-------------

Dasein Cloud expects the following provider context values to be
present:

-  endpoint
-  accountNumber
-  accessPublic
-  accessPrivate
-  cloudName
-  providerName
-  regionId

The endpoint is the URL for the vCloud API for the vCloud-based Cloud or
your private cloud.

Some specific endpoints:

-  Bluelock Enterprise Cloud -> https://zone01.bluelock.com

The accountNumber is your vCloud org name.

The accessPublic value is your login ID into the vCloud Director
console.

The accessPrivate value is your password for the vCloud Director
console.

The cloudName is a free-form text field representing the name of your
cloud. If you are using Bluelock Enterprise Cloud, you should likely set
it to "Bluelock Enterprise". Otherwise, name your cloud whatever you
like.

The providerName should be set to the flavor of vCloud you are using. In
private clouds, this should be "VMware". In public clouds, it should be
set to the cluod provider name. Here are the options for cloud provider
names:

-  VMware
-  Bluelock

The regionId is your org ID (not the org name). It's generally some kind
of UUID.
