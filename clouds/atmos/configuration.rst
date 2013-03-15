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

The endpoint is the URL at which the Atmos object store is sitting. For
AT&T Synaptic Storage, it is https://storage.synaptic.att.com/.

The accountNumber is the account number to which your API keys are tied.
This is your login to AT&T synaptic storage.

The accessPublic and accessPrivate are the public and private parts of
your API keys, respectively.

The cloudName is a free-form field that can be whatever you like.

The providerName is also a free-form field that should generally be EMC.

The regionId is "us" for AT&T Synaptic Storage, and "r1" for any other
cloud.
