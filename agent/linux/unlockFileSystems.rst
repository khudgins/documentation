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
It unlocks previously frozen XFS partitions to re-enable read-write access after volume snapshots.

Options
~~~~~~~~

None

Examples
~~~~~~~~
.. code-block:: sh

	$ unlockFileSystems 
	

Invocation
~~~~~~~~~~

It is called after a volume snapshot operation has ended successfully.

Dependencies
~~~~~~~~~~~~
* sudo
* xfs_freeze (xfsprogrogs).

Permission
~~~~~~~~~~

Run by the enStratus user. It needs sudo to run the xfs_freeze command.

Overrides
~~~~~~~~~

Override: No

Replace: No
