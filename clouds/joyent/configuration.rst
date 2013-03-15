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

The endpoint is the URL for the Joyent API for the Joyent Cloud or your
private cloud. For the Joyent public cloud, it is
https://us-west-1.api.joyentcloud.com.

The accountNumber and accessPublic are both set to your login ID to
Joyent.

The accessPrivate value is your password.

The cloudName is a free-form text field representing the name of your
cloud. If you are using the Joyent Public Cloud, you should likely set
it to "Joyent Cloud". Otherwise, name your cloud whatever you like.

The providerName should be "Joyent".

The regionId is the ID for the region you are working with.
