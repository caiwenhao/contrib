# rbd

目前只支持centos 7.x 二进制文件部署,

## Before starting

* 支持单master部署
* Record the IP address/hostname of the machine you want to be your etcd server (often same as master, only one)
* Record the IP addresses/hostname of the machines you want to be your nodes. (the master can also be a node)
* Make sure your ansible running machine has ansible 1.9 and python-netaddr installed.

## Setup

### Configure inventory

Add the system information gathered above into a file called `inventory`,
or create a new one for the cluster.
Place the `inventory` file into the `./inventory` directory.

For example:

```sh
ceph tell 'mon.*' injectargs "--mon_pg_warn_max_per_osd 0" 
sudo ceph auth get-key client.admin | base64
sudo ceph auth get-key client.kube | base64
```
