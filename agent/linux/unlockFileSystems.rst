unlockFileSystems
------------------

Name
~~~~
unlockFileSystems -  Unlocks/unfreezes all mounted XFS partitions

Synopsis
~~~~~~~~
unlockFileSystems

Description
~~~~~~~~~~~
It unlocks previously frozen XFS partitions to enable back read-write access, after volume snapshots.

Options
~~~~~~~~

None

Examples
~~~~~~~~
.. code-block:: sh

	$ unlockFileSystems 
	

Invocation
~~~~~~~~~~

It is called a volume snapshot has ended successfully.

Dependencies
~~~~~~~~~~~~
* sudo
* xfs_freeze (xfsprogrogs).

Permission
~~~~~~~~~~

Run by the enstratus user. It needs sudo to run the xfs_freeze command.

Overrides
~~~~~~~~~

Override: No

Replace: No
