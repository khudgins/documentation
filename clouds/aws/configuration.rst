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
-  x509Cert (optional)
-  x509Key (optional)

The endpoint is the URL for the AWS-based cloud.

-  For AWS, it can be any of the regional endpoints:
   http://ec2.us-east-1.amazonaws.com
-  For Eucalyptus, it almost always ends in /services:
   http://173.205.188.80:8773/services
-  For Google, it's https://commondatastorage.googleapis.com
-  For OpenStack, it likely ends in /services/Cloud:
   http://cloud.cloudscaling.com/services/Cloud
-  For Riak CS, it's just a normal URL: http://data.riakcs.net:8080

The accountNumber is the account number to which your API keys are tied.
It should be the account number shown in any resources you own. For an
AWS account, it's a 12-digit number like 747261675046.

The accessPublic and accessPrivate are the public and private parts of
your API keys, respectively.

The cloudName is a free-form field that can be whatever you like.

The providerName is also a free-form field. However, it should map to
one of the following if you are using a known provider:

-  AWS
-  CloudScaling
-  Eucalyptus
-  Google
-  OpenStack
-  Riak

The regionId is the ID for your AWS region. For clouds that don't really
think about region, use the following mappings:

-  Eucalyptus -> eucalyptus
-  Google -> us
-  Riak -> region-1

The x509 keys are necessary only if you are using Dasein Cloud to
facilitate the bundling of machine images from instance-store virtual
machines. There's no other operation that requires them.
