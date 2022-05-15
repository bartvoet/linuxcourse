## Werken met systemd-networkd

### Migratie naar systemd-networkd

~~~
[student@fedora ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:8c:ba:ef brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute enp0s3
       valid_lft 86365sec preferred_lft 86365sec
    inet6 fe80::f57:fd3e:1d05:ef59/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
[student@fedora ~]$ 

~~~


~~~
[student@fedora ~]$ systemctl status NetworkManager
● NetworkManager.service - Network Manager
     Loaded: loaded (/usr/lib/systemd/system/NetworkManager.service; enabled; vendor pres>
     Active: active (running) since Sun 2022-05-15 22:15:14 CEST; 1min 50s ago
       Docs: man:NetworkManager(8)
   Main PID: 755 (NetworkManager)
      Tasks: 3 (limit: 2320)
     Memory: 7.7M
        CPU: 98ms
     CGroup: /system.slice/NetworkManager.service
             └─755 /usr/sbin/NetworkManager --no-daemon

mei 15 22:15:14 fedora NetworkManager[755]: <info>  [1652645714.8271] device (enp0s3): st>
mei 15 22:15:14 fedora NetworkManager[755]: <info>  [1652645714.8277] device (enp0s3): st>
mei 15 22:15:14 fedora NetworkManager[755]: <info>  [1652645714.8288] manager: NetworkMan>
mei 15 22:15:14 fedora NetworkManager[755]: <info>  [1652645714.8300] manager: NetworkMan>
mei 15 22:15:14 fedora NetworkManager[755]: <info>  [1652645714.8303] policy: set 'Wired >
mei 15 22:15:14 fedora NetworkManager[755]: <info>  [1652645714.8326] device (enp0s3): Ac>
mei 15 22:15:14 fedora NetworkManager[755]: <info>  [1652645714.8415] manager: startup co>
mei 15 22:15:15 fedora NetworkManager[755]: <info>  [1652645715.0917] manager: NetworkMan>
mei 15 22:15:21 fedora NetworkManager[755]: <info>  [1652645721.5848] agent-manager: agen>
mei 15 22:15:31 fedora NetworkManager[755]: <info>  [1652645731.3321] agent-manager: agen>
~~~


~~~
[student@fedora ~]$ nmcli 
enp0s3: connected to Wired connection 1
        "Intel 82540EM"
        ethernet (e1000), 08:00:27:8C:BA:EF, hw, mtu 1500
        ip4 default
        inet4 10.0.2.15/24
        route4 0.0.0.0/0
        route4 10.0.2.0/24
        inet6 fe80::f57:fd3e:1d05:ef59/64
        route6 fe80::/64

lo: unmanaged
        "lo"
        loopback (unknown), 00:00:00:00:00:00, sw, mtu 65536

DNS configuration:
        servers: 10.0.2.3
        domains: home
        interface: enp0s3
~~~

~~~
[student@fedora ~]$ systemctl status systemd-networkd
○ systemd-networkd.service - Network Configuration
     Loaded: loaded (/usr/lib/systemd/system/systemd-networkd.service; disabled; vendor p>
     Active: inactive (dead)
TriggeredBy: ○ systemd-networkd.socket
       Docs: man:systemd-networkd.service(8)
~~~


~~~
[student@fedora ~]$ sudo systemctl disable NetworkManager
Removed /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service.
Removed /etc/systemd/system/multi-user.target.wants/NetworkManager.service.
Removed /etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service.
[student@fedora ~]$ 
~~~


~~~
[student@fedora ~]$ sudo systemctl disable NetworkManager
Removed /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service.
Removed /etc/systemd/system/multi-user.target.wants/NetworkManager.service.
Removed /etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service.
[student@fedora ~]$ sudo systemctl status NetworkManager
○ NetworkManager.service - Network Manager
     Loaded: loaded (/usr/lib/systemd/system/NetworkManager.service; disabled; vendor preset: enabled)
     Active: inactive (dead)
       Docs: man:NetworkManager(8)

mei 15 22:15:21 fedora NetworkManager[755]: <info>  [1652645721.5848] agent-manager: agent[f0012e723da9a60b,:1.34/org.gnome.Shell.Netwo>
mei 15 22:15:31 fedora NetworkManager[755]: <info>  [1652645731.3321] agent-manager: agent[6787b8f2828cf078,:1.78/org.gnome.Shell.Netwo>
mei 15 22:21:32 fedora systemd[1]: Stopping Network Manager...
mei 15 22:21:32 fedora NetworkManager[755]: <info>  [1652646092.6433] caught SIGTERM, shutting down normally.
mei 15 22:21:32 fedora NetworkManager[755]: <info>  [1652646092.6584] dhcp4 (enp0s3): canceled DHCP transaction
mei 15 22:21:32 fedora NetworkManager[755]: <info>  [1652646092.6584] dhcp4 (enp0s3): state changed bound -> terminated
mei 15 22:21:32 fedora NetworkManager[755]: <info>  [1652646092.6585] manager: NetworkManager state is now CONNECTED_SITE
mei 15 22:21:32 fedora NetworkManager[755]: <info>  [1652646092.6756] exiting (success)
mei 15 22:21:32 fedora systemd[1]: NetworkManager.service: Deactivated successfully.
mei 15 22:21:32 fedora systemd[1]: Stopped Network Manager.
lines 1-15/15 (END)
~~~

~~~
[student@fedora ~]$ sudo systemctl enable systemd-networkd
Created symlink /etc/systemd/system/dbus-org.freedesktop.network1.service → /usr/lib/systemd/system/systemd-networkd.service.
Created symlink /etc/systemd/system/multi-user.target.wants/systemd-networkd.service → /usr/lib/systemd/system/systemd-networkd.service.
Created symlink /etc/systemd/system/sockets.target.wants/systemd-networkd.socket → /usr/lib/systemd/system/systemd-networkd.socket.
Created symlink /etc/systemd/system/sysinit.target.wants/systemd-network-generator.service → /usr/lib/systemd/system/systemd-network-generator.service.
Created symlink /etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service → /usr/lib/systemd/system/systemd-networkd-wait-online.service.

~~~

~~~
[student@fedora ~]$ sudo systemctl start systemd-networkd
[student@fedora ~]$ systemctl status systemd-networkd
● systemd-networkd.service - Network Configuration
     Loaded: loaded (/usr/lib/systemd/system/systemd-networkd.service; enabled; vendor preset: disabled)
     Active: active (running) since Sun 2022-05-15 22:25:40 CEST; 15s ago
TriggeredBy: ● systemd-networkd.socket
       Docs: man:systemd-networkd.service(8)
   Main PID: 2865 (systemd-network)
     Status: "Processing requests..."
      Tasks: 1 (limit: 2320)
     Memory: 2.9M
        CPU: 29ms
     CGroup: /system.slice/systemd-networkd.service
             └─2865 /usr/lib/systemd/systemd-networkd

mei 15 22:25:40 fedora systemd[1]: Starting Network Configuration...
mei 15 22:25:40 fedora systemd-networkd[2865]: enp0s3: Link UP
mei 15 22:25:40 fedora systemd-networkd[2865]: enp0s3: Gained carrier
mei 15 22:25:40 fedora systemd-networkd[2865]: lo: Link UP
mei 15 22:25:40 fedora systemd-networkd[2865]: lo: Gained carrier
mei 15 22:25:40 fedora systemd-networkd[2865]: enp0s3: Gained IPv6LL
mei 15 22:25:40 fedora systemd-networkd[2865]: Enumeration completed
mei 15 22:25:40 fedora systemd[1]: Started Network Configuration.
[student@fedora ~]$
~~~

~~~
[student@fedora ~]$ sudo systemctl enable systemd-resolved
[student@fedora ~]$ sudo systemctl start systemd-resolved
[student@fedora ~]$ less /etc/resolv.conf 
[student@fedora ~]$ sudo rm -f /etc/resolv.conf 
[student@fedora ~]$ ls -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
ls: kan geen toegang krijgen tot '/etc/resolv.conf': Bestand of map bestaat niet
4 /run/systemd/resolve/resolv.conf
[student@fedora ~]$ sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
~~~


~~~
[Match]
Name=enp0s3

[Network]
DHCP=yes
~~~


