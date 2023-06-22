## Pakketbeheer

apt is een commando voor het installeren, bijwerken, verwijderen en 
beheren van pakketten op Debian, Ubuntu, en gerelateerde Linux-distributies.  

Het combineert de meest gebruikte opdrachten van de tools 2 andere tools  
- apt-get en apt-cache - met verschillende default-waarden van sommige opties.


### Update van de package index (apt update) 

De APT-pakketindex is in feite een database die records bevat 
van beschikbare pakketten uit de repositories die in voor je systeem 
zijn geconfigureerd.

Voer de onderstaande opdracht uit om de pakketindex bij te werken. Dit haalt de laatste wijzigingen uit de APT-repository's:

~~~
# apt update
~~~

Zie dat je altijd deze package index "update" alvorens een upgrade of een installatie
uit te voeren.


### Pakketten upgraden 

#### upgrade-command (apt upgrade)

Het regelmatig bijwerken van je software is een heel belangrijk aspect van de systeembeveiliging.  
Voer het volgende uit om de geïnstalleerde pakketten naar hun nieuwste versies te upgraden:

~~~
# apt upgrade
~~~

Als je 1 enkel pakket wilt upgraden, geeft je de pakketnaam door:

~~~
# apt upgrade package_name
~~~

(waar je package_name vervangt door de echte package)


#### Volledige upgrade (apt full-upgrade)

Het verschil tussen upgrade en volledige upgrade is dat de laatste 
de geïnstalleerde pakketten zal verwijderen als dat nodig is 
om het hele systeem te upgraden.

~~~
# apt full-upgrade
~~~


### Pakketten installeren (apt install)

Het installeren van pakketten is net zo eenvoudig als het uitvoeren van de volgende opdracht:

~~~
# apt install pakketnaam
~~~

Als je meerdere pakketten met 1 opdracht wilt installeren, 
geeft je ze mee met spaties gescheiden:

~~~
# apt install pakket1 pakket2
~~~

### Repositories

De pakketten die je installeert worden vanuit een database gedownload.  
De locatie waar deze pakketten staan noemt men een repository.  

Je kan deze locaties wijzigen (of toevoegen) in de file "/etc/apt/sources.list"

~~~
# cat /etc/apt/sources.list
# deb cdrom:[Debian GNU/Linux 11.0.0 _Bullseye_ - Official amd64 NETINST 20210814-10:07]/ bullseye main

#deb cdrom:[Debian GNU/Linux 11.0.0 _Bullseye_ - Official amd64 NETINST 20210814-10:07]/ bullseye main

deb http://deb.debian.org/debian/ bullseye main
deb-src http://deb.debian.org/debian/ bullseye main

deb http://security.debian.org/debian-security bullseye-security main
deb-src http://security.debian.org/debian-security bullseye-security main

# bullseye-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
deb http://deb.debian.org/debian/ bullseye-updates main
deb-src http://deb.debian.org/debian/ bullseye-updates main

# This system was installed using small removable media
# (e.g. netinst, live or single CD). The matching "deb cdrom"
# entries were disabled at the end of the installation process.
# For information about how to configure apt package sources,
# see the sources.list(5) manual.
# 

~~~

### Lokale deb-bestanden

De pakketten die worden geïnstalleerd hebben een specifiek formaat dat we deb noemen.  
Dit is een compresseerde file die de binaries en andere bestanden bevat die je in je
systeem kan installeren (een beetje vergelijkbaar met een msi-bestand in Windows).

Je kan deze ook lokaal installeren - zonder tussenkomst van een repository - om dit te doen
gebruik je hetzelfde commando maar geef je het absolute path naar de deb-file.  
Anders zal de opdracht proberen het pakket uit de APT-repository's op te halen en te installeren.

~~~
# apt install /home/student/file.deb
~~~

> Het spreekt voor zich dat je moet oppassen met het installeren van 
> deb-bestaanden om dat deze niet gevalideerd zijn zoals degene van 
> de officiele debian-repositories.  
> Installeer daarom enkel deb-files van een vertrouwde bron...

### Pakketten verwijderen (apt remove)

Typ het volgende om een ​​geïnstalleerd pakket te verwijderen:

~~~
# apt remove pakketnaam
~~~

Je kan ook meerdere pakketten aanduiden, gescheiden door spaties:

~~~
# apt remove pakket1 pakket2
~~~

De opdracht remove zal de gegeven pakketten verwijderen, maar het kan enkele configuratiebestanden achterlaten.  
Als je het pakket - inclusief alle configuratiebestanden - wilt verwijderen, gebruik je **purge** ipv **remove**:

~~~
# apt purge pakketnaam
~~~


### Verwijdereb ongebruikte pakketten (apt autoremove)

Telkens wanneer een nieuw pakket (dat afhankelijk is van andere pakketten) op het systeem wordt geïnstalleerd, worden de dependencies ook geïnstalleerd.  

Wanneer het pakket wordt verwijderd, blijven de dependencies op het systeem.  
Deze overgebleven pakketten worden door niets anders meer gebruikt 
en kunnen worden dus verwijderd.

Als je deze wil verwijderen, gebruik dan het volgende commando 
om de onnodige afhankelijkheden te verwijderen:

~~~
# apt autoremove
~~~

### Oplijsten van pakketten (apt list)

Met het list-commando kan je de beschikbare en geïnstalleerde pakketten weergeven.  
Gebruik het volgende commando om alle beschikbare pakketten weer te geven:

~~~
# apt list
ad-data-common/stable 0.0.23.1-1.1 all
0ad-data/stable 0.0.23.1-1.1 all
0ad/stable 0.0.23.1-5+b1 amd64
0install-core/stable 2.16-1 amd64
0install/stable 2.16-1 amd64
0xffff/stable 0.9-1 amd64
2048-qt/stable 0.1.6-2+b2 amd64
2048/stable 0.20210105.1243-1 amd64
2ping/stable 4.5-1 all
2to3/stable 3.9.2-3 all
2vcard/stable 0.6-4 all
3270-common/stable 4.0ga12-3 amd64
389-ds-base-dev/stable 1.4.4.11-2 amd64
389-ds-base-libs/stable 1.4.4.11-2 amd64
389-ds-base/stable 1.4.4.11-2 amd64
389-ds/stable 1.4.4.11-2 all
3dchess/stable 0.8.1-20 amd64
3depict/stable 0.0.22-2+b4 amd64
4g8/stable 1.0-3.3 amd64
4pane/stable 7.0-1 amd64
4ti2-doc/stable 1.6.9+ds-2 all
4ti2/stable 1.6.9+ds-2 amd64
64tass/stable 1.55.2200-1 amd64
6tunnel/stable 1:0.13-2 amd64
7kaa-data/stable 2.15.4p1+dfsg-1 all
7kaa/stable 2.15.4p1+dfsg-1 amd64
...
~~~

Dit commando drukt de lijst af van alle pakketten, inclusief informatie over de versies en architectuur van het pakket.  
Om erachter te komen of een specifiek pakket is geïnstalleerd, kunt je de uitvoer filteren met het grep-commando.

~~~
# apt list | grep guake
guake-indicator/stable 1.4.5-1 amd64
guake/stable,now 3.6.3-2 all [installed]
# 
~~~

Om alleen de geïnstalleerde pakketten weer te geven typt u:

~~~
# apt list --installed
accountsservice/focal-updates,focal-security,now 0.6.55-0ubuntu12~20.04.5 amd64 [installed]
acl/focal,now 2.2.53-6 amd64 [installed]
acpi-support/focal,now 0.143 amd64 [installed]
acpid/focal,now 1:2.0.32-1ubuntu1 amd64 [installed]
adb/focal,now 1:8.1.0+r23-5ubuntu2 amd64 [installed]
add-apt-key/focal,focal,now 1.0-0.5 all [installed]
adduser/focal,focal,now 3.118ubuntu2 all [installed]
adwaita-icon-theme-full/focal-updates,focal-updates,now 3.36.1-2ubuntu0.20.04.2 all [installed]
adwaita-icon-theme/focal-updates,focal-updates,now 3.36.1-2ubuntu0.20.04.2 all [installed]
aglfn/focal,focal,now 1.7+git20191031.4036a9c-2 all [installed]
alsa-base/focal,focal,now 1.0.25+dfsg-0ubuntu5 all [installed]
alsa-topology-conf/focal,focal,now 1.2.2-1 all [installed]
alsa-ucm-conf/focal-updates,focal-updates,now 1.2.2-1ubuntu0.13 all [installed]
alsa-utils/focal-updates,now 1.2.2-1ubuntu2.1 amd64 [installed]
amd64-microcode/focal,now 3.20191218.1ubuntu1 amd64 [installed]
anacron/focal,now 2.3-29 amd64 [installed]
android-libadb/focal,now 1:8.1.0+r23-5ubuntu2 amd64 [installed,automatic]
android-libbase/focal,now 1:8.1.0+r23-5ubuntu2 amd64 [installed,automatic]
android-libboringssl/focal,now 8.1.0+r23-2build1 amd64 [installed,automatic]
...
~~~

Als je de ​​lijst wil krijgen van de pakketten die kunnen "ge-upgraded"
worden geef je volgend commando:

~~~
# apt list --upgradeable
Listing...
chromium/ulyssa 108.0.5359.124~linuxmint1+una amd64 [upgradable from: 108.0.5359.98~linuxmint1+una]
firefox-locale-en/ulyssa 108.0.1+linuxmint1+una amd64 [upgradable from: 108.0+linuxmint1+una]
firefox/ulyssa 108.0.1+linuxmint1+una amd64 [upgradable from: 108.0+linuxmint1+una]
libodbc1/bullseye 2.3.7 amd64 [upgradable from: 2.3.6-0.1build1]
...
~~~

### Pakketten zoeken (apt search)

Met dit commando kan je zoeken naar een bepaald pakket:

~~~
# apt search guake
Sorting... Done
Full Text Search... Done
guake/stable,now 3.6.3-2 all [installed]
  Drop-down terminal for GNOME Desktop Environment

guake-indicator/stable 1.4.5-1 amd64
  Guake terminal app indicator

terminus/stable 1.13.0-1 amd64
  Drop-down or in-window terminal for X11 and Wayland
#
~~~

Als het wordt gevonden, zullen de pakketten getoond worden waarvan de naam overeenkomt met de zoekterm.

### Pakketinformatie (apt show)

Als je meer info wil ivm de dependencies, de installatiegrootte, de pakketbron, ... 
kan het commando "apt show" nuttig zijn voordat je een nieuw pakket 
verwijdert of installeert.

~~~
# apt show guake
Package: guake
Version: 3.6.3-2
Priority: optional
Section: x11
Maintainer: Daniel Echeverry <epsilon@debian.org>
Installed-Size: 2,103 kB
Depends: python3-pbr, python3-cairo, python3-gi (>= 3.26.1), python3-dbus (>= 1.2.4), gir1.2-notify-0.7 (>= 0.7.7), gir1.2-vte-2.91 (>= 0.50.2), gir1.2-gtk-3.0 (>= 3.22.26), gir1.2-keybinder-3.0 (>= 0.3.2), gir1.2-glib-2.0 (>= 1.54.1), gir1.2-pango-1.0 (>= 1.40.14), gir1.2-wnck-3.0, libglib2.0-bin, libutempter0, dconf-gsettings-backend | gsettings-backend, python3:any
Suggests: numix-gtk-theme
Homepage: http://guake-project.org
Tag: interface::graphical, interface::x11, role::program, suite::gnome,
 uitoolkit::gtk, x11::application, x11::terminal
Download-Size: 841 kB
APT-Manual-Installed: yes
APT-Sources: http://deb.debian.org/debian bullseye/main amd64 Packages
Description: Drop-down terminal for GNOME Desktop Environment
 Guake is a drop-down terminal for GNOME Desktop Environment, so you just
 need to press a key to invoke him, and press again to hide.
 Guake supports hotkeys, tabs, background transparent, etc.
#
~~~