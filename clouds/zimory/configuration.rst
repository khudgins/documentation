Configuration
-------------

Dasein Cloud expects the following provider context values to be
present:

-  endpoint
-  accountNumber
-  x509Cert
-  x509Key
-  cloudName
-  providerName
-  regionId

The endpoint is the URL at which the Zimory API is sitting. It generally
ends in /services/api.

The accountNumber is the account ID to which your API keys are tied.
Resources in Zimory are considered to be "owned" by this account ID. It
is a numeric value.

The accessPublic and accessPrivate fields are not applicable to Zimory.

The x509Cert and x509 key values are the public and private parts,
respectively of your x509 key in PEM format.

The cloudName is a free-form field that can be whatever you like.

The providerName is also a free-form field that should generally be the
provider of your public cloud (e.g. "T-Systems" or "Zimory" if a
generic, private cloud install. Any provider-specific services or
extensions are keyed off of the providerName. To date, no such
extensions are used.

The regionId is entirely non-intuitive. It is actually a combination of
the locationId and providerId for the Zimory services you are
interacting with. For example, locationId #1 + providerId #1 would have
a regionId of 1:1.
