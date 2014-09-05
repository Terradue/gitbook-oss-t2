
### [Terradue](https://github.com/Terradue) / [abiquo4one](https://github.com/Terradue/abiquo4one)

|    Language   | Created       | Last update | Stars          | Forks          | 
|:-------------:|:-------------:|:-----------:|:--------------:|:--------------:|
| Ruby  | 2013-11-18T14:16:57Z  | 2014-09-04T14:24:01Z  | [0](https://github.com/Terradue/abiquo4one/stargazers) | [0](https://github.com/Terradue/abiquo4one/network) |


abiquo4one
==========

Abiquo4one is a driver for OpenNebula that provides a way to use providers that expose the abiquo API, using the [Apache jclouds](<http://jclouds.apache.org/>) library. It uses a Command Line Interface (CLI) developed with the Apache jclouds Labs part of that library (for example [abiquo-cli](<https://github.com/Terradue/abiquo-cli>)), specific for abiquo API.

This work has been co-funded by the [European Space Agency (ESA)](<http://www.esa.int/ESA>). 

Features
---------

Implements hybrid Cloud computing, to support Cloud bursting, with the ability to work with a variety of Cloud providers that exposes the abiquo API, such as:

* [Interoute](<http://www.interoute.com/ >)
* [Claranet](<http://www.claranet.com/>)
* [CARI.net](<https://www.cari.net/>)

Requirements
------------

* This driver requires OpenNebula 4.2.
* A JClouds Labs Command Line Interface (CLI) (for example [abiquo-cli](<https://github.com/Terradue/abiquo-cli>))

Installation by RPM
--------------------

This project is developed with Maven and the RPM provided with the rpm-maven-plugin (read `pom.xml`). Once you have built the project, install the package by:

```bash
rpm -Uvh abiquo4one.rpm
```

Manual Installation
-------------------

To manually install the Driver, you have to download the repository as a ZIP:

```bash
unzip abiquo4one-master.zip
cd abiquo4one-master
```

Copy the main driver files in the cloud controller machine:

```bash
cp src/main/ruby/im_mad /var/lib/one/remotes/vmm/jclouds-labs
cp src/main/ruby/im_mad /usr/lib/one/mads
cp src/main/ruby/tm_mad /var/lib/one/remotes/tm/jclouds-labs
```

Copy the configuration driver files in the cloud controller machine:

```bash
cp src/main/resources/config/im /etc/one/im_jclouds-labs
cp src/main/resources/config/vmm/jclouds_labsrc /etc/one/
cp src/main/resources/config/vmm/vmm_exec_jclouds-labs.conf /etc/one/vmm_exec
```

Configuration
-------------
	
Configure the OpenNebula installation, adding the jclouds Labs Information Manager, Virtual Machine Manager and the Transfer Manager. It can be done adding to the file `/etc/one/oned.conf` the following lines:

```
	IM_MAD = [
    	name       = "im_jclouds-labs",
    	executable = "one_im_jclouds-labs",
    	arguments  = "im_jclouds-labs/im_jclouds-labs.conf" ]

	VM_MAD = [
    	name       = "vmm_jclouds-labs",
    	executable = "one_vmm_sh",
    	arguments  = "-t 15 -r 0 jclouds-labs",
    	default    = "vmm_exec/vmm_exec_jclouds-labs.conf",
    	type       = "xml" ]
    	
    TM_MAD = [
    	executable = "one_tm",
    	arguments  = "-t 15 -d dummy,lvm,shared,qcow2,ssh,vmfs,iscsi,ceph,jclouds-labs" ]
```

Configure the provider parameters modifying properly the configuration file `/etc/one/im_jclouds-labs/im_jclouds-labs.conf` and the file `/etc/one/jclouds_labsrc`:

```bash
cat jclouds_labsrc
# User parameters
:identity: "identity-name"
:credential: "credential-password"

# Provider parameters
:api: "url-api-access-point"
:cli: "abiquo"
:datacenter: "datacenter-name"
:appliance: "appliance-name"   	
```
    	
Restart the server via:

```bash
one stop 
one start 
```	

Using the Driver
----------------

###Step 1 - Setup the Cluster

Create a cluster on OpenNebula, named for example 'jclouds-labs', using either the Sunstone GUI or via the following command:

```bash
onecluster create jclouds-labs
```

###Step 2 - Setup the Datastore

Create a datastore on Opennebula, named for example 'jclouds_labs-ds', using either Sunstone GUI or the following commands:

```bash
$ cat ds.conf

NAME    = jclouds-ds
TM_MAD  = jclouds-labs
TYPE    = SYSTEM_DS

onedatastore create ds.conf
```

###Step 3 - Setup the Host

Create an host on Opennebula, named for example 'interoute', using either the Sunstone GUI or the following command:

```bash
onehost create interoute --im im_jclouds-labs --vm vmm_jclouds-labs --net dummy
```

###Step 4 - Prepare a Virtual Template

Prepare a template suitable for the abiquo4one Driver, named for example 'interoute-vm', using either the Sunstone GUI or the following commands:

```bash
	$ cat jclouds_template.txt
	NAME="interoute-vm"
	CPU="1"
	MEMORY="1024"
	CONTEXT=[
		FILES="file1 file2"
	]
	JCLOUDS=[
		EXTERNAL_NETWORK="remote_external_network",
		TEMPLATE="remote_template",
		PRIVATE_NETWORK="remote_private_network"
	]
	
 
	$ onetemplate create jclouds_template.txt
	ID: 2
```

> Note. The contextualisation section (CONTEXT) is optional. 

### Step 5 - Starting the Virtual Machine

Start the VM either via the Sunstone GUI or via the following command:

```bash
onetemplate instantiate 2
```

References
----------

* jclouds: http://jclouds..apache.org/
* abiquo-cli: https://github.com/Terradue/abiquo-cli
* Interoute: http://www.interoute.com/ 

