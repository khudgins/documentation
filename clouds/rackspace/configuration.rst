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

The endpoint is the URL at which the Rackspace API is sitting. The two
endpoints are:

-  US -> https://auth.api.rackspacecloud.com/v1.0
-  UK -> https://lon.auth.api.rackspacecloud.com/v1.0

The accountNumber and accessPublic values are your Rackspace login IDs.

The accessPrivate is your password.

The cloudName is a free-form field that can be whatever you like.
Generally, "Rackspace US" or "Rackspace UK".

The providerName should be "Rackspace".

The regionId is the ID for the Rackspace region you are working against:
DFW, ORD, LON.
