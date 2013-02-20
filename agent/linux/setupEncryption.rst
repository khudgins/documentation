setupEncryption
----------------

NAME
~~~~

setupEncryption - Initializes an encrypted volume.

SYNOPSIS
~~~~~~~~

setupEncryption RAW_DEVICE ENCRYPTED_DEVICE KEY_FILE

DESCRIPTION
~~~~~~~~~~~

Initialises LUKS (Linux Unified Key Setup) encryption for the selected device using the encryption key provided in KEY_FILE. By default enStratus uses AES SHA256 ESSIV (aes-cbc-essiv:sha256) for encryption.


OPTIONS
~~~~~~~

RAW_DEVICE
	Device name of the partition to be encrypted (for exqmple sdh for /dev/sdh)	

ENCRYPTED_DEVICE
	Device name for the encrypted partition (for example essdh for /dev/mapped/essdh)

KEY_FILE
	Temporary file containing the encryption key. The file is removed securely once the encryption is set up.	

INVOCATION
~~~~~~~~~~

This script is called by enStratus when starting a server that has been configured to use volume encryption 
(either stand-alone servers launched from the Machine Image list or servers in a deployment when Use Encryption is selected in the Launch Configuration).


DEPENDENCIES
~~~~~~~~~~~~

* sudo
* cryptsetup
* Kernel modules for device mapper (dm-crypt) and sha256 encryption.

PERMISSIONS
~~~~~~~~~~~

It is launched by the enStratus user and requires sudo authority for initializing the encryption.


OVERRIDES
~~~~~~~~~

Override: Yes, pre and post

Replace: Yes
