Configuration
-------------

Dasein Cloud expects the following provider context values to be
present:

-  endpoint
-  accountNumber
-  accessPublic
-  accessPrivate
-  regionId

The endpoint is the URL for the region to which you wish to connect: \*
Zurich -> https://api.zrh.cloudsigma.com \* Las Vegas ->
https://api.lvs.cloudsigma.com

The accountNumber is your profile UUID. If you don't know it, enter your
email address you use to login to the CloudSigma console. Dasein Cloud
will auto-discover the proper UUID.

The accessPublic is either the email you use to login to the CloudSigma
console in your target region or it is your profile UUID. Which one
depends on whether you have enabled API keys for your account. By
default, it is your email address.

The accessPrivate is either your login password or the API key from your
CloudSigma console. If you are using API keys, it must be the API key.
If not, then it is your password.

In other words, you login with email + password OR UUID + API key. Only
one of those two will work.

The regionId is the ID for the region you are working with (eu-zh1 or
us-nv1). It must match the endpoint you entered.
