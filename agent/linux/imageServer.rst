
imageServer
------------

NAME
~~~~

imageServer - Creates a server image and uploads it to Amazon S3

SYNOPSIS
~~~~~~~~~

imageServer CUSTOMER_ID SERVER_ID BUNDLE IMAGE_NAME ARCHITECTURE ACCOUNT TARGET ACCESS_KEY SECRET_KEY CERTFILE PKFILE

DESCRIPTION
~~~~~~~~~~~

It bundles the root volume (excluding certificate files) of an Amazon Machine Image and uploads it to Amazon S3, using the EC2 AMI tools.

OPTIONS
~~~~~~~

CUSTOMER_ID
	Enstratius customer Id
SERVER_ID
	Identifier of the current server
BUNDLE
	Bundle name.
IMAGE_NAME
	Image name.
ARCHITECTURE
	Server architecture (i386 | x86_64).
ACCOUNT
	AWS account Id.
TARGET
	Temporary folder.
ACCESS_KEY
	AWS Access Key.
SECRET_KEY
	AWS Secret Key.
CERTFILE
	AWS RSA public key certificate file.
PKFILE
	AWS RSA key file.

INVOCATION
~~~~~~~~~~

This script is called by the Make Image action for AWS S3 instance-store servers.

DEPENDENCIES
~~~~~~~~~~~~

* sudo
* AWS AMI Tools (http://aws.amazon.com/developertools/368)

PERMISSIONS
~~~~~~~~~~~

It is launched by the Enstratius user. It needs sudo authority for invoking the ec2-bundle-vol command.

OVERRIDES
~~~~~~~~~

Override: Yes, pre and post

Replace: Yes
