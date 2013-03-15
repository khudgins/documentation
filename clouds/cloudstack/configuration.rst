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

The endpoint is the URL at which the CloudStack API is sitting. It
generally ends in /client/api. For example, the Tata InstaCompute
endpoint is: https://manage.iaas.tatacommunications.com/client/api.

The accountNumber is the account number to which your API keys are tied.
Resources in CloudStack are considered to be "owned" by this account
number.

The accessPublic and accessPrivate are the public and private parts of
your API keys, respectively.

The cloudName is a free-form field that can be whatever you like.

The providerName is also a free-form field that should generally be
Apache, Citrix, or the provider of your public cloud. Any
provider-specific services or extensions are keyed off of the
providerName. To date, no such extensions are used. The following may
represent specific functionality in the future:

-  Apache
-  Citrix
-  Tata
-  Datapipe

The regionId is the ID for a CloudStack zone against which you are
currently operating. Note that CloudStack 4.0 introduces a CloudStack
concept of regions. This mapping may therefore end up being configurable
in some fashion using custom properties. For now, however, a Dasein
Cloud region == a CloudStack zone.
