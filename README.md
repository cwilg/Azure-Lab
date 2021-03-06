# Azure Lab
Project in Azure that uses Docker, Ansible, ELK stack, and beat configurations to test availability and monitoring among web servers. As a final result, this topology creates two different environments: one for Red Team and another for Blue Team.

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![This is a diagram depicting the topology of the cloud-hosted environment created](https://github.com/cwilg/Azure-Lab/blob/main/Diagrams/ELK_Stack_diagram.png "Lab Diagram")

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either: recreate the entire deployment pictured above, or select portions of the archive file may be used to install only certain pieces of it, such as Filebeat.

#### Ansible Files:
  - [install-elk.yml](https://github.com/cwilg/Azure-Lab/tree/main/Ansible/install-elk.yml)
  - [install-dvwa.yml](https://github.com/cwilg/Azure-Lab/tree/main/Ansible/install-dvwa.yml)
  - [hosts](https://github.com/cwilg/Azure-Lab/tree/main/Ansible/hosts)
  - [ansible.cfg](https://github.com/cwilg/Azure-Lab/tree/main/Ansible/ansible.cfg)
  - [filebeat-playbook.yml](https://github.com/cwilg/Azure-Lab/tree/main/Ansible/filebeat-playbook.yml)
  - [metricbeat-playbook.yml](https://github.com/cwilg/Azure-Lab/tree/main/Ansible/metricbeat-playbook.yml)
  - [filebeat-config.yml](https://github.com/cwilg/Azure-Lab/tree/main/Ansible/filebeat-config.yml)
  - [metricbeat-config.yml](https://github.com/cwilg/Azure-Lab/tree/main/Ansible/metricbeat-config.yml)

#### This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of these peered networks is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly redundant, in addition to restricting public access to the network. Load balancers help protect data availability on the network because if one server goes down for any reason, the load balancer will determine another server to send traffic to.

The advantage of using a jump box is that it provides a single access point from which we can access and configure all of our web servers. Further, we install a provisioner (Ansible) on it to automate such configuration across multiple servers.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system metrics.
- Filebeat logs changes to system files.
- Metricbeat records machine metric information (e.g. CPU, MEM, inbound/outbound traffic, etc.)

The configuration details of each machine may be found below.

| Name                 | Function   | IP Address | Operating System         |
|----------------------|------------|------------|--------------------------|
| Jump-Box-Provisioner | Gateway    | 10.0.0.4   | Linux-Ubuntu 20.04.2 LTS |
| DVWA-VM1             | Web Server | 10.0.0.5   | Linux-Ubuntu 20.04.2 LTS |                  
| DVWA-VM2             | Web Server | 10.0.0.6   | Linux-Ubuntu 20.04.2 LTS |
| DVWA-VM3             | Web Server | 10.0.0.7   | Linux-Ubuntu 20.04.2 LTS |
| ELK-Server           | ELK Stack  | 10.1.0.4   | Linux-Ubuntu 20.04.2 LTS |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the `Jump-Box-Provisioner` machine can accept SSH connections from the Internet. Access to this machine is only allowed from the following IP addresses (via SSH key & firewall rules):
- My Home Network

Machines within the network (`Web_Servers_VNet`) can only be accessed by the Ansible container on the `Jump-Box-Provisioner` (`Jump-Box-Provisioner-IP` = 40.114.7.230).
- The `Jump-Box-Provisioner` also has access to the `ELK-Server` (Internal IP = 10.1.0.4; `ELK-Server-IP` = 13.64.153.186) on the (peered) `ELK_VNET`.

A summary of the access policies in place can be found in the table below:

| Name                    | Publicly Accessible | Allowed IP Addresses |
|-------------------------|---------------------|----------------------|
| Jump-Box-Provisioner:22 | Yes                 | Home Network         |
| ELK-Server:5601         | Yes                 | Home Network         |
| ELK-Server:22           | No                  | 10.0.0.4 (Jumpbox)   |
| Web Servers:22          | No                  | 10.0.0.4 (Jumpbox)   |
| Web Servers:80          | No                  | 52.226.100.57 (LB)   |
| DVWA-Load-Balancer:80   | Yes                 | Home Network         |


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because all servers are configured exactly the same way and any changes can be automatically implemented across all servers.

The playbook implements the following tasks:
- Install Docker and PIP (Python package manager).
- Increase the virtual memory available to containers from virtual machines.
- Download & Launch the Docker ELK Stack container (v761).
- Publish ports that ELK runs on (5601, 9200, 5044).
- Enable Docker and ELK to launch on reboot.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance:

![Image depicts Docker processes currently running, which indicates successful installation of the ELK stack.](https://github.com/cwilg/Azure-Lab/blob/main/Diagrams/Elk-Stack_ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- `DVWA-VM1` (10.0.0.5)
- `DVWA-VM2` (10.0.0.6)
- `DVWA-VM3` (10.0.0.7)

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
- Add an `[elk]` section of the Hosts file (`/etc/ansible/hosts`); update it to include the internal IP addresses of all servers that you need to configure.
- Run the playbook (`ansible-playbook` command), and navigate to Kibana (http://`elk_server_ip`:5601/app/kibana) on your browser to check that the installation worked as expected. If successful, your browser should take you to a page similar to the following:

![Screenshot of the Kibana Discover page, indicating successful installation of ELK and appropriate firewall rules.](https://github.com/cwilg/Azure-Lab/blob/main/Screenshots/Kibana_discover_filebeat.PNG "Kibana Discover console")


In order to download the playbook, update the files, etc., you may run the following commands:
- `$ cd /etc/ansible`
- `$ curl https://raw.githubusercontent.com/cwilg/Azure-Lab/main/Ansible/install-elk.yml > install-elk.yml`
- `$ ansible-playbook /etc/ansible/install-elk.yml`
