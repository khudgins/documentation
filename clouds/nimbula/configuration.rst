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

The endpoint is the URL for the Nimbula API.

The accountNumber and accessPublic values are the two halves to your
Nimbula user ID. These are generally separated by a /. The accountNumber
is the first part, and the accessPublic is the second part.

The accessPrivate value is your password.

The cloudName is a free-form text field representing the name of your
cloud.

The providerName should be "Nimbula".

The regionId is the ID for the region you are working with.
