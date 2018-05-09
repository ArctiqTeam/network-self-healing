# Self-Healing Networks with Ansible
## with Red Hat and F5

This repository hosts the sample files used by Arctiq during our presentation of Self-Healing Networks with Ansible in January and May of 2018.

The presentation and demo incorporated a build out of an emulated network lab environment using GNS3 Server and bare-metal hosts from Packet.net.

Arctiq's demos included the following use cases:

 * Using Ansible Tower to completely RESET and REBUILD an entire network lab environment with Cisco, Juniper, F5, and Nginx web servers
 * A custom webhook for Tower and GitHub - repository coming soon!
 * Nagios notifying Stackstorm of a network outage affecting the web application, with Stackstorm triggering fixes using Ansible Tower
 * A Slack trigger "iquit" notifying Stackstorm, which injects an incorrect version of the web app.  Nagios picks up on this and informs Stackstorm, to which a fix is applied using Ansible Tower

In this repository you will find the sample Ansible playbooks used in the demo as follows:

 * High-level playbooks for fixes, resets, and rebuilds in the top-level "ansible" directory
 * Roles for Cisco, F5, Juniper, and Web Server configurations
 * Nagios, and Stackstorm configurations

Any questions please contact:
@arctiqteam, @fairweathertim, @stewartshea or @arctiqhart on Twitter or www.arctiq.ca
