.. _backups:

Backups
============================

The Enstratius cloud management components should be backed up on a regular basis.  These components are dependent upon databases and service filesystems.  Below are the recommended backup freqencies for each type of backup

+-------------------------------------+----------------------------+
| ** Component **                     | ** Frequency **            |
+=====================================+============================+
| DB: analytics                       | Every 4-6 hours            |
+-------------------------------------+----------------------------+
| DB: console                         | Every 24 hours             |
+-------------------------------------+----------------------------+
| DB: credentials                     | Every 24 hours             |
+-------------------------------------+----------------------------+
| DB: provisioning                    | Every 4-6 hours            |
+-------------------------------------+----------------------------+
| DB: enstratus_console               | Every 24 hours             |
+-------------------------------------+----------------------------+
| DB: provisioning                    | Every 4-6 hours            |
+-------------------------------------+----------------------------+
| DB: riak                            | Every 4-6 hours            |
+-------------------------------------+----------------------------+
| FS: /services/api                   | Once/day and After changes |
+-------------------------------------+----------------------------+
| FS: /services/console               | Once/day and After changes |
+-------------------------------------+----------------------------+
| FS: /services/dispatcher            | Once/day and After changes |
+-------------------------------------+----------------------------+
| FS: /services/km                    | Once/day and After changes |
+-------------------------------------+----------------------------+
| FS: /services/monitor               | Once/day and After changes |
+-------------------------------------+----------------------------+
| FS: /services/worker                | Once/day and After changes |
+-------------------------------------+----------------------------+

** FS (Filesystem) backups will ignore log files
