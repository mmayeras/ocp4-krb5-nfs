# Setup Kerberized NFS shares with Openshift

## Introduction

In this LAB, we will create the following :

Red Hat Identy Management will host DNS/LDAP/KDC services

A NFS servers will exports shares

*An optional client will mount the shares*

Openshift workloads will mount the shares


## Prerequisistes

- 2 RHEL servers
  - 1 for Idm 
  - 1 for Nfs  

- 1 Optional machine to test the shares / act as bastion for the Openshift cluster

- 1 OCP4 Cluster

### Outside the scope of this demo
Installing the OCP Cluster 
Deploying the rhel machine : the provided playbooks will assume the servers are powered on and reachable over ssh with a root-like account.

    
## Steps

The following hostnames will be used in the following article

idm.krb5demo.lab
nfs.krb5demo.lab
ocp-worker**n**.krb5demo.lab

1. Install ipa-server (ipa-server.yml / ipa-postinstall.yml)
2. Install nfs server (nfs-server.yml)
3. Deploy Openshift cluster (I deployed using IPI method a cluster named krb5demo in the lab domain)
4. Create Kerberos principal for every hosts and services (ocp-nodes.yml)
5. **Because ipa-join is not available on CoreOS the Host keytab will be uploaded manually on each worker nodes (see misc/ad-join for AD integration)**
6. Configure Openshift worker nodes using machine config(ocp-mcp.yml)
   1. /etc/idmapd.conf
   2. /etc/nfs.conf
   3. /etc/krb5.conf
   4. /etc/sssd/sssd.conf
   5. Start and enable rpc-gssd and gssproxy

images folder contain the files required to build the sidecar container image

7. Deploy the test app (oc-test-app.yml)






