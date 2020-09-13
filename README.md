Automated ELK Stack Deployment
==============================

The files in this repository were used to configure the network depicted below.

Lucky13/Diagrams/ELKstack\_DVWA\_network\_diagram.vpd.pdf

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above.Alternatively, select portions of the YAML file may be used to install onlycertain pieces of it, such as Filebeat.

- Lucky13/Ansible/Deploy-DVWA-ELK-filebeat-and-metricbeat.yml

This document contains the following details: - Description of the Topology - Access Policies - ELK Configuration - Beats in Use - Machines Being Monitored - How to Use the Ansible Build



Description of the Topology
===========================

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D\*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly resilient to failure, in addition to restricting throttling to the network. The load balancer splits the traffic of users among multiple virtual machines to provide redundancy. This allows the DVWA to stay online even if one machine goes down or is compromised. It also allows for more users and more processes to be handled at the same time.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the services and system files. Filebeat monitors log files made by Azure, so an admin can easily see when a a change has occurred. Metricbeat on the other hand monitors metrics such as traffic and uptime.

The configuration details of each machine may be found below.

|   Name  |     Function    | IP Address | Operating System |
| ------- | --------------- | ---------- | ---------------- |
| Jumobox | Gateway         | 10.0.0.4   |   Ubuntu 18.04   |
| Web-1   | Web server/DVWA | 10.0.0.7   |   Ubuntu 18.04   |
| Web-2   | Web server/DVWA | 10.0.0.9   |   Ubuntu 18.04   |
| Web-3   | Web server/DVWA | 10.0.0.15  |   Ubuntu 18.04   |
| ELK-1   | ELK stack       | 10.1.0.4   |   Ubuntu 18.04   |



Access Policies
===============

The machines on the internal network are not exposed to the public Internet.

Only the ELK stack machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: -

Whitelist your own IP Address to access sensitive information while keeping others out


Machines within the network can only be accessed by SSH. - Start by SSH-ing into your jumpbox, start your ansible container and attach it. From there you can SSH into any of the other four virtual machines.

A summary of the access policies in place can be found in the table below. For a complete list of rules view th network diagram listed above.

|   Name  | Publicly Accessible |      Allowed IP Address     |
| ------- | ------------------- | --------------------------- |
| Jumpbox |          No         | local IP:22,   --------  VN |
| Web-1   |          No         | local IP:80,   10.0.0.4, VN |
| Web-2   |          No         | local IP:80,   10.0.0.4, VN |
| Web-3   |          No         | local IP:80,   10.0.0.4, VN |
| ELK-1   |          No         | local IP:5601, 10.0.0.4, VN |



Elk Configuration
=================

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because you can easily deploy multiple ELK stacks either simultaneously or independently and achieve consistent results.

The playbook implements the following tasks:

- Installs Docker.io
- Instal Python3
- Installs the Docker Python module
- Sets virtual Memory
- Deploys the Docker ELK container

The following screenshot displays the result of running docker ps after success fully configuring the ELK instance.

Lucky13/ansible/docker ps output.png



Target Machines &amp; Beats
===========================

This ELK server is configured to monitor the following machines:

- 10.0.0.7
- 10.0.0.9
- 10.0.0.15

We have installed the following Beats on these machines:

- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine: Filebeat keeps track of log files and system services, you can track changes to syslogs, sudo commands, SSH logins and more, which allow us to more easily notice potential threats. Metricbeat allows you to monitor CPU usage, RAM utilization, traffic in and out of a server, packet loss and more technical information which will help with knowing when to expand a network or shrink it.



Using the Playbook
==================

In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below from inside the ansible container.

Copy the Lucky13/Ansible/Deploy-DVWA-ELK-filebeat-and-metricbeat.yml_file to /etc/ansible  

Update the _hosts_ file to include _[elkservers]_and put the IP Adresses under the intended group. Run the playbook, and navigate to the ELK servers public IP on your local web broswer to check that the installation worked as expected.

Note: it is important that after each IP address in the hosts file you include the following on the same line: ansible\_python\_interpreter=/usr/bin/python3






$ cd /etc/ansible

$ ls -l

(check to make sure you have the hosts file and Deploy-DVWA-ELK-filebeat-and-metricbeat.yml)

$ nano hosts

(add the internal network IP address(es) of your webserver(s) under the [webservers] group and add [elkservers] to the bottom of the file with the specified IP address below. The result should look similar to:

[webservers]

10.0.0.9 ansible\_python\_interpreter=/usr/bin/python3

10.0.0.7 ansible\_python\_interpreter=/usr/bin/python3

10.0.0.15 ansible\_python\_interpreter=/usr/bin/python3

[elkservers]

10.1.0.4 ansible\_python\_interpreter=/usr/bin/python3

Exit and save changes. Note : all lines that begin with # will be ignored.)

$ nano Deploy-DVWA-ELK-filebeat-and-metricbeat.yml

(On line 37, the remote_user: field, make sure a valid on your ELK machine user is entered)

$ Ansible-playbook Deploy-DVWA-ELK-filebeat-and-metricbeat.yml

$ ssh [ELKuser]@[ELK machine internal IP]

(EX: $ ssh sysadmin@10.1.0.4 )

$ sudo docker ps

You should now see something resembling

Lucky13/ansible/docker ps output.png

from the github repository. Congrats, you built an DVWA and and ELK stack with metricbeat and filebeat!
