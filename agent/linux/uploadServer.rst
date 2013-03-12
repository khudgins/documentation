uploadImage
------------

NAME
~~~~

uploadImage - Uploads a server image bundle to Amazon S3

SYNOPSIS
~~~~~~~~~

uploadImage BUNDLE MANIFEST ACCESS_KEY SECRET_KEY

DESCRIPTION
~~~~~~~~~~~

Uploads the selected AMI bundle to Amazon S3 for creating a S3-storage based AMI using EC2 AMI tools

OPTIONS
~~~~~~~

BUNDLE
	Bundle file, containing an image of the server root volume.

MANIFEST
	Manifest file, created during the image generation process, containing metadata about the AMI.

ACCESS_KEY
	AWS Access Key.

SECRET_KEY
	AWS Secret Key.

INVOCATION
~~~~~~~~~~

This script is called by the Make Image action for AWS S3 instance-store servers.

DEPENDENCIES
~~~~~~~~~~~~

* sudo
* AWS AMI Tools (http://aws.amazon.com/developertools/368)

PERMISSIONS
~~~~~~~~~~~

It is launched by the Enstratius user. It needs sudo authority for invoking the ec2-upload-bundle command.


OVERRIDES
~~~~~~~~~

Override: No

Replace: No
