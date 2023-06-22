## Werken met netwerken IP-commando

### IP-addressen raadplegen

Om alle detail-addressen te bekijken kan je

~~~
$ ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp8s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether e8:6a:64:6f:42:ef brd ff:ff:ff:ff:ff:ff
3: wlp7s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 28:3a:4d:7d:d8:05 brd ff:ff:ff:ff:ff:ff
    inet 10.25.87.235/19 brd 10.25.95.255 scope global dynamic noprefixroute wlp7s0
       valid_lft 529sec preferred_lft 529sec
    inet6 fe80::78e3:ad08:bfb0:eebd/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 52:54:00:72:55:08 brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever
5: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel master virbr0 state DOWN group default qlen 1000
    link/ether 52:54:00:72:55:08 brd ff:ff:ff:ff:ff:ff
6: br-5c2c35c13eda: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:7f:b2:00:23 brd ff:ff:ff:ff:ff:ff
    inet 172.18.0.1/16 brd 172.18.255.255 scope global br-5c2c35c13eda
       valid_lft forever preferred_lft forever
7: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:b3:1a:8b:c2 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
$ 
~~~

of de afkorting die equivalent is

~~~
$ ip a
~~~

#### Beperken tot ip-versie

Als je enkel de ipv4-addressenn wil zien...

~~~
$ ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
3: wlp7s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    inet 10.25.87.235/19 brd 10.25.95.255 scope global dynamic noprefixroute wlp7s0
       valid_lft 505sec preferred_lft 505sec
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever
6: br-5c2c35c13eda: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    inet 172.18.0.1/16 brd 172.18.255.255 scope global br-5c2c35c13eda
       valid_lft forever preferred_lft forever
7: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
$
~~~

...of enkel de ipv6

~~~
$ ip -6 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN qlen 1000
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: wlp7s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP qlen 1000
    inet6 fe80::78e3:ad08:bfb0:eebd/64 scope li
$
~~~

#### Beperken tot interface

Als je wil focussen op 1 interface specifiek

~~~
ip a show wlp7s0
3: wlp7s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 28:3a:4d:7d:d8:05 brd ff:ff:ff:ff:ff:ff
    inet 10.25.87.235/19 brd 10.25.95.255 scope global dynamic noprefixroute wlp7s0
       valid_lft 873sec preferred_lft 873sec
    inet6 fe80::78e3:ad08:bfb0:eebd/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
~~~

Of alternatief de 2 volgende notaties tonen hetzelfde

~~~
ip a list wlp7s0
ip a show dev wlp7s0
~~~

#### Enkel de interfaces die up zijn

~~~
$ ip addr ls up
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp8s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether e8:6a:64:6f:42:ef brd ff:ff:ff:ff:ff:ff
3: wlp7s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 28:3a:4d:7d:d8:05 brd ff:ff:ff:ff:ff:ff
    inet 10.25.87.235/19 brd 10.25.95.255 scope global dynamic noprefixroute wlp7s0
       valid_lft 768sec preferred_lft 768sec
    inet6 fe80::78e3:ad08:bfb0:eebd/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 52:54:00:72:55:08 brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever
6: br-5c2c35c13eda: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:7f:b2:00:23 brd ff:ff:ff:ff:ff:ff
    inet 172.18.0.1/16 brd 172.18.255.255 scope global br-5c2c35c13eda
       valid_lft forever preferred_lft forever
7: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:b3:1a:8b:c2 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
$
~~~

### Bewerken van IP-adressen

#### IP-adres toekennen

The syntax is as follows to add an IPv4/IPv6 address:

~~~
# ip a add {ip_addr/mask} dev {interface}
~~~

Om bijvoorbeeld 192.168.1.200/255.255.255.0 op eth0 toe te passen gebruik je:

~~~
# ip a add 192.168.1.200/255.255.255.0 dev eth0
~~~

In bovenstaand geval gebruik je een klassieke bitmask.  
Je kan dit echter ook met de klassieke CIDR-notatie gebruiken.

~~~
# ip a add 192.168.1.200/24 dev eth0
~~~

#### Verwijderen van het IP address van een inteface

The syntax is as follows to remove an IPv4/IPv6 address:

~~~
# ip a del {ipv6_addr_OR_ipv4_addr} dev {interface}
~~~

Om 192.168.1.200/24 te verwijderen van eth0 bijvoorbeeld

~~~
# ip a del 192.168.1.200/24 dev eth0
~~~

#### Alle IP-adressen verwijderen

Naast delete bestaat er ook flush, dit commando stelt je instaat alle
adressen te verwijderen die overeenkomen met een specifieke conditie.

Als je bijvoorbeeld alle IP-addressen startende met eth wil verwijderen
kan je de label optie gebruiken.

~~~
# ip -4 addr flush label "eth*"
~~~


### Status van een interface wijzigen

Naast het IP-adres kan je ook nog de status van een inteface beheren.  
Je kan een interface op- een aanzetten via onderstaand commando:

~~~
# ip link set dev {DEVICE} {up|down}
~~~

Om de interface af te zetten

~~~
# ip link set dev eth1 down
~~~

Om deze terug aan te zetten gebruik je up ipv down

~~~
# ip link set dev eth1 up
~~~

### ARP/Neighbour cahck

Dit kan via het neigh (neighbours)-commando

~~~
$ ip neigh show
10.25.95.254 dev wlp7s0 lladdr de:fa:ce:db:ab:e1 REACHABLE
$
~~~

Of de afgekorte versie

~~~
$ ip n show
10.25.95.254 dev wlp7s0 lladdr de:fa:ce:db:ab:e1 REACHABLE
$
~~~
 
3 statussen zijn daar mogelijk:

* **REACHABLE**  
  Het MAC-adres is bereikbaar
* **STALE**  
  geldig, maar is vermoedelijk niet bereikbaar, de kernel zal dit nakijken na de 1ste transmissie
* **DELAY**  
  Een pakket is verstuurd naar naar de stale buur en de kernel is aan het wachten op bevestiging

### Routing-table

Op de verschillende routes naar ip-domeinen op te lijsten gebruik je

~~~
$ ip route list
default via 10.25.95.254 dev wlp7s0 proto dhcp metric 600 
10.25.64.0/19 dev wlp7s0 proto kernel scope link src 10.25.87.235 metric 600 
169.254.0.0/16 dev virbr0 scope link metric 1000 linkdown 
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown 
172.18.0.0/16 dev br-5c2c35c13eda proto kernel scope link src 172.18.0.1 linkdown 
192.168.122.0/24 dev virbr0 proto kernel scope link src 192.168.122.1 linkdown 
$ 
~~~

Of afgekort

~~~
ip r list
~~~

En je ken eventueel ook de list-optie weglaten

~~~
ip r
~~~


~~~
ip route add {NETWORK/MASK} via {GATEWAYIP}
ip route add {NETWORK/MASK} dev {DEVICE}
~~~

~~~
ip route add default {NETWORK/MASK} dev {DEVICE}
ip route add default {NETWORK/MASK} via {GATEWAYIP}
~~~

~~~
ip route del 192.168.1.0/24 dev eth0
~~~