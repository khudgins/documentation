.. _agent_overview:

Overview
--------

The Enstratius agent is composed of a lightweight tomcat application used for communicating
with the Enstratius provisioning server and a set of associated shell scripts. The shell
scripts are responsible for executing some actions on the server and are extensible by end
users.

The agent listens on port 2003 and takes action based on user input as in the case of
adding a user to a system (the addUser script) and also automates actions such as
attaching, formatting, encrypting, and mounting volumes as part of a fully automated
Enstratius deployment. Communication to and from the Enstratius provisioning server is
encrypted using SSL.

The Enstratius agent is suitable for use on many popular GNU/Linux distributions such as
Ubuntu, Debian, Cent OS, and Fedora. Additionally, the Enstratius agent works on Windows
Server 2003/2008. The agent functions in both 32- and 64-bit environments.

The Enstratius agent and the associated scripts can be found in /enstratus on a GNU/Linux
system, and in C:\enstratus on a Windows server.

Functionality
~~~~~~~~~~~~~

Installing the Enstratius agent opens the server to the full functionality provided by
Enstratius including user management, automation, scheduled termination, statistics,
logging, and alerting.

Enstratius will monitor servers that have the agent installed and alert when status changes
occur as in the case of an unexpected termination of the server. In an automated
deployment, Enstratius will take the further step of restoring lost servers.
