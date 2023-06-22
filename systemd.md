## Systemd en het beheer van een Linux Systeem

### Opstarten van een Linux Distro

Zoals we eerder hadden gezien wordt een GNU/Linux opgestart via onderstaand schema

~~~
+---------------------+
|  1ST BOOTLOADER     | (bv. BIOS/UEFI)
+----------+----------+
           |
+----------v----------+
|  2ND BOOTLOADER     |  (bv. GRUB, UBoot)
+----------+----------+
           |
+----------v----------+
|        KERNEL       |  => PID 0
+----------+----------+
           |
+----------v----------+
|         INIT        |  => PID 1 (bv. systemd, init, system-v, ...)
+----------+----------+
           |
+----------v----------+
|       RUNLEVEL      |
+---------------------+
~~~

Op de moment dat de kernel is opgestart zal deze het feitelijk Operating Systeem opstarten dat je als eindgebruiker zult gebruiken.  
Dit doet de kernel door het eerste process op te starten namelijk **/sbin/init**.  
Zoals je hieronder ziet start dit systeem op met PID 1 !!!

~~~
$ ps aux | head
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0 168676 11996 ?        Ss   14:39   0:01 /sbin/init splash
root           2  0.0  0.0      0     0 ?        S    14:39   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        I<   14:39   0:00 [rcu_gp]
root           4  0.0  0.0      0     0 ?        I<   14:39   0:00 [rcu_par_gp]
root           5  0.0  0.0      0     0 ?        I    14:39   0:00 [kworker/0:0-events]
root           6  0.0  0.0      0     0 ?        I<   14:39   0:00 [kworker/0:0H-events_highpri]
root           8  0.0  0.0      0     0 ?        I<   14:39   0:00 [kworker/0:1H-events_highpri]
root           9  0.0  0.0      0     0 ?        I<   14:39   0:00 [mm_percpu_wq]
root          10  0.0  0.0      0     0 ?        S    14:39   0:00 [ksoftirqd/0]
~~~

Als je dit nauwer kijkt is deze **/sbin/init** is een soft-link naar een **executable** genaamd **systemd**.  
Als je dit nauwer kijkt gaat zien naar deze link zie je dat het een "soft/symbolic link" of door verwijzing naar een programma genaamd **systemd**

~~~
bart@bvlegion:~$ ls -l /sbin/init 
lrwxrwxrwx 1 root root 20 Apr 21 14:54 /sbin/init -> /lib/systemd/systemd
bart@bvlegion:~$ 
~~~

### systemd

Dit 1ste process - genaamd systemd - is verantwoordelijk voor het initialiseren en opstarten van het systeem
en alle software waar je als gebruiker mee te maken krijgt.  

Dit houdt in dat het onder andere:

* Start **daemons** (services) op
* Kijkt hier ook na in welke **volgorde** (en dependencies)
* Geeft de mogelijkheid om deze **on-demand** te **stoppen** en **starten**
* Heeft een specifiek journaling/logging-systeeem **journald** dat syslog vervangt
* Voorziet in **vervanging** van een aantal bestaande tools (zoals bijvoorbeeld systemd-timers ipv cron)
* ...

> systemd is een opvolger van het vroegere init.d-systeem (vandaar dat de link init noemt) 
> en bevat libraries, daemons en hulpprogramma's die je kan gebruiken om services 
> in het Linux-systeem te beheren.

![](Pictures/systemd.png)

> Nota:  
> Op sommige embedded systemen en Android zal je ook andere init-systemen zien
> Dit houden buiten beschouwing van de cursus.

### services

Bedoeling van dit deel van de cursus is je door de basisprincipes van servicebeheer in Linux te leiden.
Hoe kan je systemd gebruiken om services te beheren en nuttige informatie te krijgen over de status 
van deze services in je systeem.

**Services** zijn **processen** die in de achtergrond draaien.  
Dit kan bijvoorbeeld een **webserver** zijn, een **database** maar ook basisonderdelen van je systeem
zoals een **networkmanager**, een **windowmanager** van je systeem, ...

> Naast service zijn er nog 11 andere unit-types
> 
> * Target: group of units
> * Automount: filesystem auto-mountpoint
> * Device: kernel device names, which you can see in sysfs and udev
> * Mount: filesystem mountpoint
> * Path: file or directory
> * Scope: external processes not started by systemd
> * Slice: a management unit of processes
> * Snapshot: systemd saved state
> * Socket: IPC (inter-process communication) socket
> * Swap: swap file
> * Timer: systemd timer.
>
> We gaan deze niet behandelen in de cursus, de focus is op het behandelen
> van de services.

### systemctl

Het beheren van deze service kan je doen via **systemctl**.  
Systemctl is een Linux-command dat wordt gebruikt om systemd en services te besturen en te beheren.  
Je kan **systemctl** zien als de besturing van  systemd init-service.  
Het laat je toe te communiceren met systemd en bewerkingen uit te voeren.

Om deze service te beheren heb je een aantal basis-commando's die je toelaten te kijken

~~~
# systemctl start [name.service]
# systemctl stop [name.service]
# systemctl restart [name.service]
# systemctl reload [name.service]
$ systemctl status [name.service]
# systemctl is-active [name.service]
$ systemctl list-units --type service --all
...
~~~

### Service stoppen en starten

#### Starten

Gebruik het **"systemctl start"**-commando om een ​​systemd-service te **starten** en instructies uit te voeren in het eenheidsbestand van de service.  

> Je moet dit doen met root-permissies niet-rootgebruiker, omdat dit de status van het besturingssysteem beïnvloedt:

~~~
# systemctl start application.service
~~~

Zoals we eerder vermeldden, weet systemd te zoeken naar *.service-bestanden voor servicebeheeropdrachten.  
Dus de opdracht kan als volgt worden getypt:

~~~
# systemctl start application
~~~

> Hoewel het bovenstaande formaat voor algemeen beheer kunt gebruiken, 
gebruiken we voor de duidelijkheid het achtervoegsel .service voor de rest van de opdrachten, om expliciet te zijn over het doel waarop we werken.

#### Stoppen

Om een ​​actieve service te stoppen, kunt j in plaats daarvan de opdracht stop gebruiken:

~~~
# systemctl stop application.service
~~~

#### Restart vs reload

Om een service die al draait te herstarten kan je het **restart-commando** gebruiken

~~~
# systemctl restart application.service
~~~

Sommige applicaties kan zijn configuratie opnieuw laden zonder opnieuw op te starten.  
Om dit te doen bestaat er het commando **reload**:

~~~
# systemctl reload application.service
~~~

Als je er niet zeker van bent of de service de capaciteit heeft de configuratie opnieuw te laden.
Kan je het commando **reload-or-restart** geven.  

Hiermee wordt de configuratie opnieuw geladen, als de capaciteit beschikbaar is.  
Anders wordt de service opnieuw gestart, zodat de nieuwe configuratie wordt opgehaald:

~~~
#  systemctl reload-or-restart application.service
~~~

### Services automatisch starten (enable of disable)

De voorgaande commandos opdrachten worden gebruikt voor starten of stoppen van services tijdens de huidige sessie.  
Om systemd te vertellen om services automatisch te starten bij het booten, moet moet je het commando enable te 
gebruiken:

~~~
# systemctl enable application.service
~~~

Dit zal een symbolische link maken van de systeemkopie van het servicebestand 
(meestal in /lib/systemd/system of /etc/systemd/system) naar de locatie op schijf 
waar systemd zoekt naar autostart-bestanden (meestal /etc/systemd/system /some_target.target.wants.  

> We zullen verderop in deze handleiding bespreken wat een target is.

Om te voorkomen dat de service automatisch wordt gestart, typt u:

~~~
#  systemctl disable application.service
~~~

Hiermee wordt de symbolische link verwijderd die aangeeft dat de service automatisch moet worden gestart.

Hou er rekening mee dat het inschakelen van een service deze niet start in de huidige sessie. 
Als u de service wilt starten en deze ook bij het opstarten wilt inschakelen, 
moet je zowel het start- als enable-commando geven.

~~~
# systemctl enable application.service
# systemctl start application.service
~~~

### Status van de service

Om na te kijken wat de status van je service is, gebruik je het status-commando

~~~
# systemctl status application.service
~~~

Dit zal je de status van de service doorgeven (enabled/disables, running, ...)
en een aantal logs

~~~
● nginx.service - A high performance web server and a reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2015-01-27 19:41:23 EST; 22h ago
 Main PID: 495 (nginx)
   CGroup: /system.slice/nginx.service
           ├─495 nginx: master process /usr/bin/nginx -g pid /run/nginx.pid; error_log stderr;
           └─496 nginx: worker process
Jan 27 19:41:23 desktop systemd[1]: Starting A high performance web server and a reverse proxy server...
Jan 27 19:41:23 desktop systemd[1]: Started A high performance web server and a reverse proxy server.
~~~

Dit geeft je een mooi overzicht van de huidige status van de applicatie en 
of er eventuele problemen en/of acties nodig zijn.

Er zijn ook methoden om te controleren op specifieke toestanden.  
Om bijvoorbeeld te controleren of een eenheid momenteel actief (actief) is, kunt u het is-active commando gebruiken:

~~~
# systemctl is-active cron.service
active
#
~~~

Als je wil zien of de service automatisch zal starten gebruik je het volgende commando:

~~~
# systemctl is-enabled application.service
enabled
#
~~~

Beide commando's zullen de exit code op 0 of "niet 0" zetten afhankelijk van het antwoord.  
Hieronder zie je wat er gebeurt als je een service stopzet

~~~
# systemctl is-active cron.service
active
# echo $?
0
# systemctl stop cron.service
# systemctl is-active cron.service
inactive
# echo $?
3
~~~

Wanneer de service actief is krijg je een status 0.  
Is deze echter stopgezet krijg je een getal verschillend van 0 
(in het voorbeeld 3)

### Overview van de services

#### Lijst met huidige units

Om een ​​lijst te zien van alle actieve eenheden die systemd kent, kunnen we de opdracht list-units gebruiken.
Dit zal je een overzicht geven van alle units die systemd momenteel voorzien zijn in het systeem

~~~
# systemctl list-units
UNIT                                      LOAD   ACTIVE SUB     DESCRIPTION
atd.service                               loaded active running ATD daemon
avahi-daemon.service                      loaded active running Avahi mDNS/DNS-SD Stack
dbus.service                              loaded active running D-Bus System Message Bus
dcron.service                             loaded active running Periodic Command Scheduler
dkms.service                              loaded active exited  Dynamic Kernel Modules System
getty@tty1.service                        loaded active running Getty on tty1
. . .
~~~

Je kan hier de volgende kolommen onderscheiden:

* **UNIT:**  
  De naam van de systemd-eenheid
* **LOAD:**  
  Of de configuratie van het apparaat is geladen/geparsed door systemd.  
  De configuratie van geladen eenheden wordt in het geheugen bewaard.
* **ACTIVE:**  
  Een overzichtsstatus over of de unit actief is. 
  Dit is meestal een vrij eenvoudige manier om te zien of het apparaat succesvol is gestart of niet.
* **SUB:**  
  Dit is een status op een lager niveau die meer gedetailleerde informatie over het apparaat aangeeft. 
  Dit varieert vaak per type van unit, staat en de daadwerkelijke methode waarop de eenheid wordt uitgevoerd.
* **DESCRIPTION:**  
  Een korte tekstuele beschrijving van wat de unit is/doet.


We kunnen ook extra flags toevoegen om systemctl om andere informatie te verkrijgen.   
Om bijvoorbeeld alle units geladen door systemd (of geprobeerd te laden), kan je de flag --all gebruiken:

~~~
# systemctl list-units --all
~~~

Dit toont elke unit die door het systeem is geladen of heeft geprobeerd te laden, ongeacht de huidige status op het systeem.  
Stel dat je bijvoorbeeld enkel degene wil die niet gestart zijn kan je ook nog een extra query-parameter toevogen

~~~
# systemctl list-units --all --state=inactive
~~~

Wil je enkel de units zien van het type service (degene waar we geinteresseerd in zijn) kan je
een filter voegen met de optie type (die je dan aan service matcht)

~~~
# systemctl list-units --type=service
~~~


### Extra informatie over een unit

#### Een unit file tonen

Om het eenheidsbestand weer te geven dat systemd in zijn systeem heeft geladen, 
kan je de opdracht cat gebruiken (toegevoegd in systemd versie 209).  

Om bijvoorbeeld het unit-bestand van de atd scheduling-daemon te zien, kunnen we het volgende typen:


~~~
# systemctl cat atd.service
[Unit]
Description=ATD daemon
[Service]
Type=forking
ExecStart=/usr/bin/atd
[Install]
WantedBy=multi-user.target
# 
~~~

De output is het unit-bestand zoals bekend bij het momenteel lopende systemd-proces.  

#### Dependencies

Om te zien wat de dependencies (afhankelijkheden) zijn kan je het commando **list-dependencies** gebruiken.  
Hieronder zie je output voor de dependencies voor de sshd-daemon

~~~
# systemctl list-dependencies sshd.service
sshd.service
├─system.slice
└─basic.target
  ├─microcode.service
  ├─rhel-autorelabel-mark.service
  ├─rhel-autorelabel.service
  ├─rhel-configure.service
  ├─rhel-dmesg.service
  ├─rhel-loadmodules.service
  ├─paths.target
  ├─slices.target
. . .
# 
~~~

#### Detail informatie

Je kan het show-comando gebruiken om een overzicht te verkrijgen van 
alle properties van een service.

~~~
# systemctl show sshd.service
Id=sshd.service
Names=sshd.service
Requires=basic.target
Wants=system.slice
WantedBy=multi-user.target
Conflicts=shutdown.target
Before=shutdown.target multi-user.target
After=syslog.target network.target auditd.service systemd-journald.socket basic.target system.slice
Description=OpenSSH server daemon
. . .
# 
~~~

Je kan je ook beperken tot 1 enkele specfieke property kan je de optie **-p** gebruiken

~~~
# systemctl show sshd.service -p Conflicts
Conflicts=shutdown.target
# 
~~~

### Masking en unmasking van units

We hebben eerder gezien dan je een service kan starten en stoppen.  
Via enable/disable kon je ook voorzien of de service al dan niet automatisch start.  

In sommige gevallen wil je echter dat de service niet kan gestart worden (ook niet manueel).  
Als je deze service dan wil onstartbaar maken gebruik je:

~~~
# systemctl mask nginx.service
#
~~~

Dit voorkomt dat de Nginx-service wordt gestart, automatisch of handmatig, zolang deze is "masked".  
Als je het list-unit-files commando gebruikt, ziet je dat de service nu wordt aangeduid als "masked":

~~~
# systemctl list-unit-files
. . .
kmod-static-nodes.service              static
ldconfig.service                       static
mandb.service                          static
messagebus.service                     static
nginx.service                          masked
quotaon.service                        static
rc-local.service                       static
rdisc.service                          disabled
rescue.service                         static
. . .
# 
~~~

Als je probeert de service dan toch nog te starten, krijg je een boodschap zoals hieronder:

~~~
# systemctl start nginx.service
Failed to start nginx.service: Unit nginx.service is masked.
To unmask a unit, making it available for use again, use the unmask command:
# 
~~~

Om de service terug bruikbaar te maken maak je gebruik van het unmask-commando

~~~
# systemctl unmask nginx.service
~~~

Dit zal de service terug bruikbaar/beschikbaar maken...

### Targets

Targest in systemd fungeren als synchronisatiepunten tijdens het opstarten van uw systeem. 
Target unit-bestanden, die eindigen op de bestandsextensie .target, vertegenwoordigen de systemd-targets. 

> In vroegere system werden dit runlevels genoemd

Het doel van target-un,its is om verschillende systeem-units te groeperen via dependencies.

2 voorbeelden:

* De graphical.target-unit voor het starten van een grafische sessie, 
  start systeemservices zoals de GNOME Display Manager (gdm.service) 
  of Accounts Service (accounts-daemon.service), en activeert ook de multi-user.target-eenheid.
* De multi-user.target-unit start andere andere essentiële systeemservices zoals NetworkManager (NetworkManager.service) 
  of D-Bus (dbus.service)

#### Wat is je target?

Je kan de target dat je systeem gebruikt nakijken via het systemctl-commando of door
naar de /etc/systemd/system/default.target te gaan kijken.

Determine, which target unit is used by default:

~~~
# systemctl get-default
graphical.target
#
~~~

Of via de symbolic link:

~~~
# ls -l /usr/lib/systemd/system/default.target
~~~

#### Welke zijn de mogelijk targes

Als je de mogelijk targets wil zien (of toch deze die geladen zijn) kan je onderstaand commando
gebruiken:

~~~
# systemctl list-units --type target

UNIT                  LOAD   ACTIVE SUB    DESCRIPTION
basic.target          loaded active active Basic System
cryptsetup.target     loaded active active Encrypted Volumes
getty.target          loaded active active Login Prompts
graphical.target      loaded active active Graphical Interface
local-fs-pre.target   loaded active active Local File Systems (Pre)
local-fs.target       loaded active active Local File Systems
multi-user.target     loaded active active Multi-User System
network.target        loaded active active Network
paths.target          loaded active active Paths
remote-fs.target      loaded active active Remote File Systems
sockets.target        loaded active active Sockets
sound.target          loaded active active Sound Card
spice-vdagentd.target loaded active active Agent daemon for Spice guests
swap.target           loaded active active Swap
sysinit.target        loaded active active System Initialization
time-sync.target      loaded active active System Time Synchronized
timers.target         loaded active active Timers

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.

17 loaded units listed.
~~~

Bovenstaand commando zal enkel de targets tonen die momenteel actief zijn.  
Wil je alle targets zien kan je hier de optie --all aan toevoegen.

~~~
# systemctl list-units --type target --all
~~~

#### Target wijzigen

Als je wil dat het systeem by default niet met een grafische interface
opstart kan het commendo set-default gebruiken.

Waar dat we bij het vorige commando zagen dat de start-target op graphical staat...

~~~
# systemctl get-default
graphical.target
~~~

...kan je dze bijvoobeeld omzetten naar naar multi-user waardoor je systeem zal
opstarten met een prompt

~~~
# systemctl set-default multi-user.target
rm /etc/systemd/system/default.target
ln -s /usr/lib/systemd/system/multi-user.target /etc/systemd/system/default.target
#
~~~

Zoals je ziet vervangt deze opdracht het bestand /etc/systemd/system/default.target 
door eens nieuwe symbolic link naar /usr/lib/systemd/system/name.target waarbij 
je "naam" vervangt door de target die je wilt gebruiken.  

#### Isoleren van targets

Wil je terugvallen naar een specieke target kan je het isolate commando gebruiken.   
Het onderstaande comamndo zal er voor zorgen dat je naar multi-user terugkeert en alle
units verbonden aan graphical afsluit.

~~~
# systemctl isolate multi-user.target
~~~


#### Target-shortcuts

Er zijn targets bepaald voor belangrijke gebeurtenissen zoals uitschakelen of opnieuw opstarten.  
Systemctl heeft echter ook enkele snelkoppelingen die een beetje extra functionaliteit toevoegen.

Om het systeem bijvoorbeeld in de reddingsmodus (enkele gebruiker) te zetten, 
kunt u het reddingscommando gebruiken ipv "isolate rescue.target"-commando:

~~~
# systemctl rescue
~~~

~~~
# systemctl halt
~~~

~~~
# systemctl poweroff
~~~

~~~
# systemctl reboot
~~~


