.. _backups:

Backups
-------

The Enstratius cloud management components should be backed up on a regular basis.  These
components are dependent upon databases and service file systems.  

Below are the recommended backup frequencies for each type of backup

==== ======================== ========================== ======================================
Type  **Component**            **Frequency**             Reference                             
==== ======================== ========================== ======================================
DB   analytics                Every 4-6 hours            :ref:`MySQL <mysql_backups>`          
DB   console                  Every 24 hours             :ref:`MySQL <mysql_backups>`          
DB   credentials              Every 24 hours             :ref:`MySQL <mysql_backups>`          
DB   provisioning             Every 4-6 hours            :ref:`MySQL <mysql_backups>`          
DB   enstratus_console        Every 24 hours             :ref:`MySQL <mysql_backups>`          
DB   provisioning             Every 4-6 hours            :ref:`MySQL <mysql_backups>`          
DB   riak                     Every 4-6 hours            :ref:`Riak <riak_backups>`            
FS   /services/api            Once/day and After changes :ref:`API <api_backups>`              
FS   /services/console        Once/day and After changes :ref:`Console <console_backups>`      
FS   /services/dispatcher     Once/day and After changes :ref:`Dispatcher <dispatcher_backups>`
FS   /services/km             Once/day and After changes :ref:`KM <km_backups>`                
FS   /services/monitor        Once/day and After changes :ref:`Monitor <monitor_backups>`      
FS   /services/worker         Once/day and After changes :ref:`Worker <worker_backups>`        
==== ======================== ========================== ======================================

FS (Filesystem) backups can ignore log files for each service.
