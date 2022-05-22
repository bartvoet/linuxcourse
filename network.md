Ip commando's

~~~
ip address
ip link set ... up/down
ip address add 100.100.100.3/24 dev enp0s8
~~~

Local link

~~~
ping fe80::a00:27ff:fe4a:c521%enp0s8
~~~

~~~
student@studentdeb:~$ systemctl status NetworkManager
● NetworkManager.service - Network Manager
     Loaded: loaded (/lib/systemd/system/NetworkManager.service; disabled; vendor preset: enabled)
     Active: inactive (dead)
       Docs: man:NetworkManager(8)
~~~


~~~
● networking.service - Raise network interfaces
     Loaded: loaded (/lib/systemd/system/networking.service; enabled; vendor preset: enabled)
     Active: active (exited) since Sun 2022-05-22 10:45:57 CEST; 11h ago
       Docs: man:interfaces(5)
    Process: 436 ExecStart=/sbin/ifup -a --read-environment (code=exited, status=0/SUCCESS)
   Main PID: 436 (code=exited, status=0/SUCCESS)
      Tasks: 4 (limit: 2325)
     Memory: 6.2M
        CPU: 123ms
     CGroup: /system.slice/networking.service
             └─475 /sbin/dhclient -4 -v -i -pf /run/dhclient.enp0s3.pid -lf /var/lib/dhcp/dhclient.enp0s3.leases -I -df /var/lib/dhcp/dhclient6.enp0s3.leases enp0s3

Warning: some journal files were not opened due to insufficient permissions.
~~~


~~~
[student@fedora network]$ ls
enp0s3.network  enp0s8.network
~~~

~~~
[student@fedora network]$ cat enp0s3.network 
[Match]
Name=enp0s3

[Network]
DHCP=yes
~~~

~~~
[student@fedora network]$ cat enp0s8.network 
[Match]
Name=enp0s8


[Network]
Address=10.1.1.5/24
[student@fedora network]$ 
~~~


~~~
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

auto enp0s3
#allow hotplug enp0s3
iface enp0s3 inet dhcp

auto enp0s8
iface enp0s8 inet static
        address 10.1.1.4
        netmask 255.0.0.0
~~~

~~~
[student@fedora network]$ networkctl 
IDX LINK   TYPE     OPERATIONAL SETUP     
  1 lo     loopback carrier     unmanaged
  2 enp0s3 ether    routable    configured
  3 enp0s8 ether    routable    configured

3 links listed.
[student@fedora network]$ 
~~~

~~~
[student@fedora network]$ ip route
default via 10.0.2.2 dev enp0s3 proto dhcp src 10.0.2.15 metric 1024 
10.0.2.0/24 dev enp0s3 proto kernel scope link src 10.0.2.15 metric 1024 
10.0.2.2 dev enp0s3 proto dhcp scope link src 10.0.2.15 metric 1024 
10.0.2.3 dev enp0s3 proto dhcp scope link src 10.0.2.15 metric 1024 
10.1.1.0/24 dev enp0s8 proto kernel scope link src 10.1.1.5 
[student@fedora network]$ 
~~~

~~~
# ip link add name bridge_name type bridge
# ip link set bridge_name up

To add an interface (e.g. eth0) into the bridge, its state must be up:

# ip link set eth0 up

Adding the interface into the bridge is done by setting its master to bridge_name:

# ip link set eth0 master bridge_name

To show the existing bridges and associated interfaces, use the bridge utility (also part of iproute2). See bridge(8) for details.

# bridge link

This is how to remove an interface from a bridge:

# ip link set eth0 nomaster

The interface will still be up, so you may also want to bring it down:

# ip link set eth0 down

To delete a bridge issue the following command:

# ip link delete bridge_name type bridge

This will automatically remove all interfaces from the bridge. The slave interfaces will still be up, though, so you may also want to bring them down after. 
~~~