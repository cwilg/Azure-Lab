# Azure Lab
Project in Azure that uses Docker, Ansible, ELK stack, and beat configurations to test availability and monitoring among web servers.

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![This is a diagram depicting the topology of the cloud-hosted environment created](https://github.com/cwilg/Azure-Lab/blob/main/Diagrams/ELK_Stack_diagram.png "Lab Diagram")

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the archive file may be used to install only certain pieces of it, such as Filebeat.

[Ansible Files:](https://github.com/cwilg/Azure-Lab/tree/main/Ansible)
  - install-elk.yml
  - install-dvwa.yml
  - hosts
  - ansible.cfg
  - filebeat-playbook.yml
  - metricbeat-playbook.yml
  - filebeat-config.yml
  - metricbeat-config.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly redundant, in addition to restricting public access to the network. Load balancers help protect data availability on the network. If one server goes down for any reason, the load balancer will determine another server to send traffic to.

The advantage of using a jump box is that we provide a single access point from which we can access and configure all of our web servers. Further, we install a provisioner (Ansible) on it to automate such configuration across multiple servers.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system metrics.
- Filebeat logs changes to system files.
- Metricbeat records machine metric information (e.g. CPU, MEM, inbound/outbound traffic, etc.)

The configuration details of each machine may be found below.

| Name                 | Function   | IP Address | Operating System         |
|----------------------|------------|------------|--------------------------|
| Jump-Box-Provisioner | Gateway    | 10.0.0.1   | Linux-Ubuntu 20.04.2 LTS |
| Web-1                | Web Server | 10.0.0.6   | Linux-Ubuntu 20.04.2 LTS |                  
| Web-2                | Web Server | 10.0.0.7   | Linux-Ubuntu 20.04.2 LTS |
| DVWA-VM3             | Web Server | 10.0.0.5   | Linux-Ubuntu 20.04.2 LTS |
| ELK-Server           | ELK Stack  | 10.1.0.4   | Linux-Ubuntu 20.04.2 LTS |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the `Jump-Box-Provisioner` machine can accept SSH connections from the Internet. Access to this machine is only allowed from the following IP addresses (via SSH key & firewall rules):
- My Home Network

Machines within the network (`XCorpRedTeam_VNet`) can only be accessed by the Ansible container on the `Jump-Box-Provisioner` (`Jump-Box-Provisioner-ip` = 52.149.213.10).
- The `Jump-Box-Provisioner` also has access to the `ELK-Server` (Internal IP = 10.1.0.4; `ELK-Server-ip` = 52.162.176.231) on the (peered) `ELK-BlueTeam-VNet`.

A summary of the access policies in place can be found in the table below.

| Name                    | Publicly Accessible | Allowed IP Addresses |
|-------------------------|---------------------|----------------------|
| Jump-Box-Provisioner:22 | Yes                 | Home Network         |
| ELK-Server:5601         | Yes                 | Home Network         |
| ELK-Server:22           | No                  | 10.0.0.4 (Jumpbox)   |
| Web Servers:22          | No                  | 10.0.0.4 (Jumpbox)   |
| Web Servers:80          | No                  | 52.226.100.57 (LB)   |
| DVWA-Load-Balancer:80   | Yes                 | Home Network         |


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- All servers are configured exactly the same way and any changes can be automatically implemented across all servers.

The playbook implements the following tasks:
- Install Docker and PIP (Python package manager).
- Increase the virtual memory available to containers from virtual machines.
- Download & Launch the Docker ELK Stack container (v761).
- Publish ports that ELK runs on (5601, 9200, 5044).
- Enable Docker and ELK to launch on reboot.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Image depicts Docker processes currently running, which indicates successful installation of the ELK stack.](https://github.com/cwilg/Azure-Lab/blob/main/Diagrams/Elk-Stack_ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- `Web-1` (10.0.0.6)
- `Web-2` (10.0.0.7)
- `DVWA-VM3` (10.0.0.5)

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat collects logs describing changes to files within each target machine and sends them to Logstash and Elasticsearch. One example would be auth logs, which can be used to track authentication attempts on the target system.
- Metricbeat collects metrics on the system and the processes running on it. It can be used to report on CPU, memory and load metrics.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the yml file (`install-elk.yml`) to the `/etc/ansible` directory.
- Add an `[elk]` section of the Hosts file (`/etc/ansible/hosts`), update to include the internal IP addresses of all servers that you need to configure.
- Run the playbook (`ansible-playbook` command), and navigate to Kibana (http://[elk_server_ip]:5601/app/kibana) to check that the installation worked as expected.


In order to download the playbook, update the files, etc., you may run the following commands:
`$ curl -i ...`
`$ ansible-playbook /etc/ansible/install-elk.yml`
