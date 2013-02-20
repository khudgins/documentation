
openEncryption
----------------

NAME
~~~~

openEncryption - Opens a previously initialized encrypted volume.

SYNOPSIS
~~~~~~~~

openEncryption RAW_DEVICE ENCRYPTED_DEVICE KEY_FILE

DESCRIPTION
~~~~~~~~~~~

Opens a LUKS (Linux Unified Key Setup) encrypted volume.

OPTIONS
~~~~~~~

RAW_DEVICE
	Device name of the partition to be encrypted (for example sdh for /dev/sdh)	

ENCRYPTED_DEVICE
	Device name for the encrypted partition (for example essdh for /dev/mapped/essdh)

KEY_FILE
	Temporary file containing the encryption key. The file is removed securely once the encryption is set up.	

INVOCATION
~~~~~~~~~~

This script is called by enStratus when starting a server that has been configured to use volume encryption 
(it can be stand-alone servers launched from the Machine Image list or servers in a deployment when 
Use Encryption is selected in the Launch Configuration).

openEncryption is called after the volume has been successfully initialized by setupEncryption.


DEPENDENCIES
~~~~~~~~~~~~

* sudo
* cryptsetup
* Kernel modules for device mapper (dm-crypt) and sha256 encryption.

PERMISSIONS
~~~~~~~~~~~

It is launched by the enStratus user. It requires sudo authority for initializing the encryption.


OVERRIDES
~~~~~~~~~

Override: Yes, pre and post

Replace: Yes
