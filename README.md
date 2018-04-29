# ![](data/rc-car-icon.png) rc-car (fork of minirc)

![](data/shot.png)

The script "rc" is a minimalistic init script made for use with busybox init.

## Installing

Dependencies:
 
```sh
busybox
eudev or systemd (for udev)
```

1. When you are confident, run "./setup.sh --force"
2. Remove "init=..." from your kernel parameters (if it is there) so that the default value "init=/sbin/init" is used.
3. Configure /etc/minirc.conf to your needs.
4. Reboot

## Shutdown & Reboot

You can send the signals TERM for reboot, USR1 for halt or USR2 for poweroff to the process 1.

## Dealing with services

The variable DAEMONS is used for listing the runnable services.
The variable ENABLED is used to define services that are started on boot.

You can override them in `/etc/minirc.conf`.
This file is simply sourced by the script right after defining the default variables.

## Help

Run "rc --help" for information. 

**Never run "rc init" except during the boot process, when called by busybox init.**

## About

* Authors: Roman Zimbelmann, Sam Stuewe
* Forked by: Lains, Reed
* License: GPL2
