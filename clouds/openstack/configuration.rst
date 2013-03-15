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

The endpoint is the URL at which the OpenStack API is sitting. It
generally ends in /client/api. For example, the HP Cloud endpoint is:
https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0.

The accountNumber is the OpenStack tenant ID to which your API keys are
tied.

The accessPublic and accessPrivate depend on the underlying cloud
implementation. In a cloud like the HP Cloud, for example, they are the
public and private parts of your API keys, respectively. In most other
OpenStack environments, they are they user name and password you use for
logging in.

The cloudName is a free-form field that can be whatever you like.

The providerName describes the entity behind the public cloud or
OpenStack distribution. Valid values include:

-  Dell
-  HP
-  Rackspace

This value is used to key-in on extensions and perform proper
authentication in HP. If you enter a different value, you should be
fine.

The regionId is the ID for the OpenStack region you are working against.
In HP, for example, az-1.region-a.geo-1 is a regionId.
