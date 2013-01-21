secureDelete
--------------

NAME
~~~~

secureDelete - Secure removal of sensitive files.

DESCRIPTION
~~~~~~~~~~~

It invokes the Secure Removal tool (http://srm.sourceforge.net/) to securely remove temporary files containing sensitive information, such an encryption keys and services passwords, to make sure they cannot be recovered using forensic techniques.

OPTIONS
~~~~~~~

FILE_NAME
	File to be deleted.

Examples
~~~~~~~~

/enstratus/bin/secureDelete /mnt/tmp/sensitiefile.cfg

INVOCATION
~~~~~~~~~~

This script is called automatically by several enStratus agent scripts to enforce the secure deletion of temporary files.

DEPENDENCIES
~~~~~~~~~~~~

* srm

PERMISSIONS
~~~~~~~~~~~

It is launched by the enStratus user.

OVERRIDES
~~~~~~~~~

Override: Yes, pre and post

Replace: Yes
