# Oracle AMI builder

Uses Packer and VirtualBox to install and configure a basic Amazon Machine Image for Oracle Linux.

* Currently supports Oracle 7.4 x86_64.
* Depends on [Packer](http://packer.io)
* Depends on [VirtualBox](http://virtualbox.org)

Somewhat inspired by Chef's [Bento](https://github.com/chef/bento).

## Features

* Single partition - grows on first boot (to assume full size of allocated storage like stock AMIs).
* Compressed size around 430MB.
* `cloud-init` for configuration and retrieval of authorized SSH keys on first boot.
* Username `ec2-user` (added to sudoers). Password locked (login via key only).
* No root SSH login, root password locked.
* No password based SSH login - keys only.
* Uses RHCK kernel, can be set to UEK on or after first boot.
* No VirtualBox cruft in the resulting image.



## Usage

```shell
$ packer build packer.json
```

This will:
* Run Packer to create an image.



### Switching kernel via instance user data

Due to EC2 import requirements the RHEL kernel is used and Oracle's Unbreakable Kernel will be removed.

Oracle's Unbreakable kernel can be used but needs to be re-installed after boot, you can do this via EC2 user data when launching your instance like so:

```shell
#!/bin/bash

# Install Unbreakable Kernel
yum -y install kernel-uek

# Update system all the way to 7.5
yum -y update
```
