## Processen

Met dit deel van de cursus proberen we een minimum informatie mee te geven rond processen:

* Wat?
* Hoe ze te **bekijken** of **monitoren**? => **ps** en **top**
* Hoe deze te **manipuleren**? => **signals** en **jobcontrol**
* Hoe **recurrente** taken in te plannen? => **cron**

In een volgend hoofdstuk bekijken we ook nog systemd...

Het kunnen werken met deze tools is belangrijk om bijvoorbeeld:

* Te zien of een background taak nog altijd draait
* Na te kijken **waarom** een programma blijft **hangen**
* Het **programma** te **beëindigen**...
* Zien welke files een applicatie open heeft
* ...

### Wat is een process?

Elke keer als je een **programma start** - vanuit een terminal of een "graphical user interface" - start je **process**.  
maw een process is een **"runtime" instance** van een programma.

Het besturingssysteem houdt echter heel wat data bij rond dit process

* Het **programma** (locatie)
* Een **identificatie** (pid)
* Een **status**
* Een **eigenaar** (het programma wordt uitgevoerd door een **user**)
* **Files** en andere **resources** dat dit process gebruikt
* **Lokale** en **globale** **variabelen** (environment variables)
* Een virtueel geheugen
* ...

### Waar start het nu mee (boot-sequentie)

Wat is het allereerste proces binnen een Linux-distribute?  
Waar start het nu uiteindelijk?

De allereerste software die op je computer (of embedded device) draait zijn bootloaders.  
De eerste is de (1ste bootloader) die reeds op je chip staat, die is hardware en microcode die er voor zorgt dat een programma op je persistent geheugen (harde schrijf of flash) wordt gestart.

~~~
+---------------------+
|  1ST BOOTLOADER     | (bv. BIOS/UEFI)
+----------+----------+
           |
+----------v----------+
|  2ND BOOTLOADER     |  (bv. GRUB, UBoot)
+----------+----------+
~~~

Het eerste programma dat dan wordt opgestart is dan een secundaire bootloader.  
Dit programma staat voor klassieke computers meestal in het MBR- (BIOS) of in de GPT-gedeelte (UEFI) van je harde schrijf.

Dit programma dat beperkt in grootte is (meestal **GRUB** op klassieke computer of **UBoot** op embedded devices) doet dan de nodige voorbereidingen (geheugen initialiseren e.a.) om dan vervolgens een kernel op te starten.

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
~~~

Deze kernel is dan verantwoordelijk om verschillende **low-level taken** uit te voeren zoals:

* CPU initialisatie en testen
* Geheugen-test en -initialisatie
* Drivers en kernel-modules laden
* "Device en -bus discovery"  
  (zorgen dat alle randapparatuur wordt gedetecteerd)
* Mounten van een root filesystem

De belangrijkste taak echter is - na bovenstaande initialisaties - het opstarten van 
de userspace.

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

Deze userspace is dat het 1ste niet-kernel programma dat wordt opgestart en zal dan 
de verschillende dameons, services, windowing-systemen op starten.

Dit allereerste init-programma krijgt dan de PID 1 en heet als parent-process 0.  
(dit parent-proces 0 is dan de kernel)

~~~
(base) bart@bvlegion:~$ ps -f 1
UID          PID    PPID  C STIME TTY      STAT   TIME CMD
root           1       0  0 Apr23 ?        Ss     0:05 /sbin/init splash
~~~

Op de meeste desktop- en server-systemen is dit **systemd**.  
**systemd** zal vanaf de opstart de verschillende services (die je nodig hebt als gebruiker) gaan opstarten, beheren en controleren.

~~~
(base) bart@bvlegion:~$ ls -l /sbin/init 
lrwxrwxrwx 1 root root 20 Jan 10 05:56 /sbin/init -> /lib/systemd/systemd
(base) bart@bvlegion:~$ 
~~~

> Nota:  
> We komen nog later terug op systemd, eerst focussen we op de processen en de andere tools
> om deze te beheren

### Processen bekijken met ps

We kunnen deze processen - en hun eigenschappen - bekijken op je machine via het commando **ps**.  
ps is de afkorting voor **"process status"**
Laten we het even uitvoeren...

#### Shell-processen

We zien dat - zonder bijhorende opties - dat dit commando enkel de processen printen binnen je huidige terminal.

~~~
student@studentdeb:~$ ps
    PID TTY          TIME CMD
   1127 pts/3    00:00:00 bash
   3354 pts/3    00:00:00 ps
student@studentdeb:~$ 
~~~

Momenteel geeft het dan ook maar 2 processen (en 2 lijnen) weer.  
1 voor de bash-shell die binnen je terminal draait en 1 voor het commando ps zelf dat op die moment actief was.

Daarnaast zien we dat er meerdere data wordt meegegeven in tabel-vorm:

* PID  => het unieke process-id van je process
* TTY  => de terminal waarmee je process is gelinkt
* TIME => de tijd dat je programma al aan het uitvoeren is  
* CMD  => het programma (of commando) waarmee je process is gestart

#### Meer info met de f-optie

Als je de optie **"f"** toevoegt krijg je meer informatie te zien voor

~~~
student@studentdeb:~$ ps -f
UID          PID    PPID  C STIME TTY          TIME CMD
student     1127    1035  0 15:21 pts/3    00:00:00 bash
student     3613    1127  0 21:29 pts/3    00:00:00 ps -f
student@studentdeb:~$ 
~~~

* UID => de user-id verbonden aan het process
* PPID => het parent-process (ofwel het process dat je terminal heeft gestart)
* C => het percentage in cpu
* STIME => de moment dat je process is gestart

#### Processen per user

Als je bijvoorbeeld de processen wil zien die onder een specifieke user-name wil zien kan je de u-optie gebruiken:

~~~
student@studentdeb:~$ ps -u student
    PID TTY          TIME CMD
    724 ?        00:00:00 systemd
    725 ?        00:00:00 (sd-pam)
    744 ?        00:00:00 pipewire
    745 ?        00:00:00 pulseaudio
    747 ?        00:00:06 dbus-daemon
    748 ?        00:00:00 pipewire-media-
    757 ?        00:00:00 xfce4-session
    805 ?        00:00:00 VBoxClient
    ...
~~~

Deze kan je natuurlijk ook combineren met andere opties zoals -f

~~~
student@studentdeb:~$ ps -f -u student
UID          PID    PPID  C STIME TTY          TIME CMD
student      724       1  0 15:07 ?        00:00:00 /lib/systemd/systemd --user
student      725     724  0 15:07 ?        00:00:00 (sd-pam)
student      744     724  0 15:07 ?        00:00:00 /usr/bin/pipewire
student      745     724  0 15:07 ?        00:00:00 /usr/bin/pulseaudio --daemonize=no --log-target=journal
student      747     724  0 15:07 ?        00:00:06 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidf
student      748     744  0 15:07 ?        00:00:00 /usr/bin/pipewire-media-session
student      757     719  0 15:07 ?        00:00:00 xfce4-session
student      805       1  0 15:07 ?        00:00:00 /usr/bin/VBoxClient --clipboard
...
~~~

#### Alle processen bekijken met de e-optie

Als je alle processen wil zien gebruik je de optie **-e**.  
Meestal combineer je deze optie met **-f** tot **"ps -e -f"** of afgekort **"ps -ef"**

~~~
student@studentdeb:~$ ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 15:05 ?        00:00:01 /sbin/init
root           2       0  0 15:05 ?        00:00:00 [kthreadd]
root           3       2  0 15:05 ?        00:00:00 [rcu_gp]
root           4       2  0 15:05 ?        00:00:00 [rcu_par_gp]
root           6       2  0 15:05 ?        00:00:00 [kworker/0:0H-events_highpri]
root           9       2  0 15:05 ?        00:00:00 [mm_percpu_wq]
root          10       2  0 15:05 ?        00:00:00 [rcu_tasks_rude_]
root          11       2  0 15:05 ?        00:00:00 [rcu_tasks_trace]
root          12       2  0 15:05 ?        00:00:00 [ksoftirqd/0]
...
student     1014     724  0 15:07 ?        00:00:00 /usr/libexec/gvfs-udisks2-volume-monitor
student     1022     875  0 15:07 ?        00:00:00 /usr/libexec/gvfsd-trash --spawner :1.14 /org/gtk/gvfs/exec_spaw/0
student     1028     724  0 15:07 ?        00:00:00 /usr/libexec/gvfsd-metadata
student     1035       1  0 15:07 ?        00:00:11 xfce4-terminal
student     1039    1035  0 15:07 pts/0    00:00:00 bash
student     1042    1039  0 15:07 pts/0    00:00:00 crontab -e
student     1043    1042  0 15:07 pts/0    00:00:00 /bin/sh -c /usr/bin/sensible-editor /tmp/crontab.NvTht0/crontab
student     1044    1043  0 15:07 pts/0    00:00:00 /bin/sh /usr/bin/sensible-editor /tmp/crontab.NvTht0/crontab
student     1046    1044  0 15:07 pts/0    00:00:00 /bin/nano /tmp/crontab.NvTht0/crontab
student     1101    1035  0 15:18 pts/1    00:00:00 bash
student     1103    1101  0 15:19 pts/1    00:00:00 nano nano_ttest
...
~~~

#### Nog meer informatie zien met de l-optie

Als je nog extra informatie wil bekomen kan je de l-optie gebruiken.
Wat we bijvoorbeeld hieronder zien is dat er een extra veld **S** (status) is bijgekomen en dat stelt de status van het process voor.

~~~
student@studentdeb:~$ ps -efl
F S UID          PID    PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY          TIME CMD
4 S root           1       0  0  80   0 - 41028 -      15:05 ?        00:00:01 /sbin/init
1 S root           2       0  0  80   0 -     0 -      15:05 ?        00:00:00 [kthreadd]
1 I root           3       2  0  60 -20 -     0 -      15:05 ?        00:00:00 [rcu_gp]
1 I root           4       2  0  60 -20 -     0 -      15:05 ?        00:00:00 [rcu_par_gp]
1 I root           6       2  0  60 -20 -     0 -      15:05 ?        00:00:00 [kworker/0:0H-events_highpri]
1 I root           9       2  0  60 -20 -     0 -      15:05 ?        00:00:00 [mm_percpu_wq]
1 S root          10       2  0  80   0 -     0 -      15:05 ?        00:00:00 [rcu_tasks_rude_]
1 S root          11       2  0  80   0 -     0 -      15:05 ?        00:00:00 [rcu_tasks_trace]
1 S root          12       2  0  80   0 -     0 -      15:05 ?        00:00:00 [ksoftirqd/0]
...
0 S lightdm     3825    3805  0  69 -11 - 22615 -      22:11 ?        00:00:00 /usr/bin/pipewire
0 S lightdm     3830    3805  0  80   0 -  2011 -      22:11 ?        00:00:00 /usr/bin/dbus-daemon --session --address
0 S lightdm     3831    3825  0  69 -11 - 21325 -      22:11 ?        00:00:00 /usr/bin/pipewire-media-session
0 S lightdm     3839    3805  0  80   0 - 76779 -      22:11 ?        00:00:00 /usr/libexec/at-spi-bus-launcher
0 S lightdm     3844    3839  0  80   0 -  1977 -      22:11 ?        00:00:00 /usr/bin/dbus-daemon --config-file=/usr/
0 S lightdm     3846    3805  0  80   0 - 59193 -      22:11 ?        00:00:00 /usr/libexec/gvfsd
0 S lightdm     3864    3805  0  80   0 - 41417 -      22:11 ?        00:00:00 /usr/libexec/at-spi2-registryd --use-gno
1 I root        3900       2  0  80   0 -     0 -      22:33 ?        00:00:00 [kworker/u2:3-ext4-rsv-conversion]
1 I root        3912       2  0  80   0 -     0 -      22:43 ?        00:00:00 [kworker/u2:1-events_unbound]
1 I root        3920       2  0  80   0 -     0 -      22:53 ?        00:00:00 [kworker/0:0-ata_sff]
1 I root        3924       2  0  80   0 -     0 -      22:58 ?        00:00:00 [kworker/0:2-ata_sff]
4 R student     3931    1127  0  80   0 -  2425 -      22:59 pts/3    00:00:00 ps -efl
~~~

### Process-status

Dit status-veld geeft de mogelijk proces-statussen weer (of PROCESS STATE CODES).  
In de man-pagina van het ps-commando staan deze als volgt opgesteld.

~~~
D    uninterruptible sleep (usually IO)
I    Idle kernel thread
R    running or runnable (on run queue)
S    interruptible sleep (waiting for an event to complete)
T    stopped by job control signal
t    stopped by debugger during the tracing
W    paging (not valid since the 2.6.xx kernel)
X    dead (should never be seen)
Z    defunct ("zombie") process, terminated but not reaped by its parent
~~~

De **meest** **voorkomende** zijn:

* **S** => het process wacht op een event (dikwijls IO-gerelateerd)
* **R** => actief of de processor
* **T** => gestopt door een pauze-signaal
* **D** => wachtend op IO (lezen van een file of een netwerk)
* **Z** => beeindigd/dood

~~~
     Waiting for resource of signal  +-------------------------+
  +---------------------------------->                         |
  |                                  | Interruptible Sleep (D) |
  |    +-----------------------------+                         |
  |    |  Wakes Up/Signal            +-------------------------+
  |    |
  |    |
  |    |    Waiting for resources    +-------------------------+
  |    |        +-------------------->                         |
  |    |        |                    | Interruptible Sleep (S) |
  |    |        |                    |                         |
+-+----v--------+--------+<----------+-------------------------+
|                        |  Wakes up
|  Running          (R)  |
|                        |  SIGSTOP
+-+-------------^--------+<----------+-------------------------+
  |             |                    |                         |
  |             |                    | Stopped             (T) |
  |             |           SIGCONT  |                         |
  |             +--------------------+-------------------------+
  |
  |
  |                                  +-------------------------+
  |                                  |                         |
  |     exit() of kill-signal        | Zombie              (Z) |
  +---------------------------------->                         |
                                     +-------------------------+
~~~

### Signals

Om de status te kunnen wijzigen kan je vanuit de shell de status van processen wijzigen via **signalen**.  
Deze signalen worden tussen processen naar elkaar doorgestuurd om 

De signalen zijn een communicatiemiddel tussen processen.  
Wanneer een proces een signaal ontvangt, onderbreekt het proces de uitvoering ervan en wordt een signaalbehandelaar uitgevoerd.

Hoe het programma zich gedraagt, hangt meestal af van het type signaal dat wordt ontvangen.  
Nadat het signaal is verwerkt, kan het proces zijn normale uitvoering al dan niet voortzetten.

De Linux-kernel kan bijvoorbeeld signalen verzenden wanneer een proces probeert te delen door nul en het SIGFPE-signaal ontvangt.  
(zie bijvoorbeeld in je Python-cursus waar we een exception provoceren door een getal door 0 te delen, hetgeen een exception genereerd)

Een overzicht van deze signalen kan je bekomen via het commando **kill -l** (zo dadelijk meer of het kill-commando)

~~~
bart@bvlegion:~$ kill -l
 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
 6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX	
~~~

Niet alle signalen zijn even belangrijk.  
De belangrijkste (meest gebruikte) signalen zijn SIGTERM, SIGQUIT, SIGSTOP? SIGING en SIGKILL


#### SIGTERM (15) en SIGQUIT (13)

SIGTERM- en alsook SIGQUIT-signalen zijn bedoeld om het proces te beëindigen.  
In dit geval vragen we specifiek om het af te maken. 

SIGTERM is trouwens het standaardsignaal wanneer we het kill-commando gebruiken.  
maw het is een vriendelijke manier van vragen, want programma's kunnen dit negeren of een specifieke behandeling aan koppelen

SIGQUIT genereert echter ook een kerndump voordat het wordt afgesloten.

#### SIGSTOP (19) en SIGCONT (18)

SIGSTOP EN SIGCONT worden veel te samen gebruikt.  

De 1ste zal een process suspenden of pauzeren, het programma wordt niet beeindigd!!!  
Dit komt overeen met **"ctrl + z"** op de command-line.

De 2de is een signaal om het process (dat eerder via signaal 19 was stopgezet) terug op te starten.

> We tonen hier zo dadelijk een voorbeeld van

#### SIGINT (2) of keyboard-interrupt

SIGINT is het signaal dat wordt verzonden wanneer we Ctrl+C ingegven.  
De standaardactie is om het proces te beëindigen.  

Sommige programma's negeren deze actie echter en gaan er anders mee om.
Een bekend voorbeeld is de bash-interpreter.  

Wanneer we op Ctrl+C drukken, wordt het niet afgesloten, maar wordt een nieuwe en lege promptregel afgedrukt. 


#### SIGKILL (9)

Ook wel de ultieme manier genoemd om een process te stoppen (als alle anderen falen).  

Wanneer een proces deze SIGKILL ontvangt, wordt het zowiezo beëindigd.  
Dit is een speciaal signaal omdat het niet kan worden genegeerd door het process en het process zowiezo wordt beeindigd

We gebruiken dit signaal om het proces geforceerd te beëindigen.  
We moeten voorzichtig zijn, omdat het proces geen enkele opruimroutine kan uitvoeren.

Een veelgebruikte manier om SIGKILL te gebruiken is om eerst SIGTERM te verzenden.  
We geven het proces wat tijd om te beëindigen, we kunnen ook een paar keer SIGTERM sturen. Als het proces niet vanzelf wordt voltooid, sturen we SIGKILL om het te beëindigen.

### Kill-commando

Het kill-commando laat je toe 1 van bovenstaande signalen naar een applicatie toe te sturen.  
Je gebruik dit als volgt:

~~~
kill -<nummer> <pid>
~~~

We illusteren dit adhv de SIGSTOP en SIGCONT-signalen...  
Als eerste starten we een langdurende job (die de prompt zal onderbreken)

* Terminal 1:

~~~
$ sleep 5000
~~~

We openen een aparte console om het PID op te zoeken

* Terminal 2:

~~~
$ ps -u bvo | grep sleep
50663 pts/23   00:00:00 sleep
$ ps -f 50663 | grep sleep
bvo      50663 57255  0 13:49 pts/23   S      0:00 sleep 5000
~~~

We zien dat deze job pid 50663 heeft en in de idle-state is.  


Via het kill-commando kan ik nu signaleren sturen.  
We sturen het SIGSTOP-signaal (19) om er voor te zorgen dat deze job stopt (pauzeert)

* Terminal 2:

~~~
$ kill -19 50663
$ ps -f 50663 | grep sleep
bvo      50663 57255  0 13:49 pts/23   T      0:00 sleep 5000
~~~

Aan de kant van terminal 1 zien we dat de prompt is vrijgekomen.  
Daar kunnen we zien (via het commando jobs dat we zo dadelijk verder uitleggen) dat deze job in een stop-state staat...

* Terminal 1:

~~~
$ jobs
[1]+  Stopped                 sleep 5000
$ 
~~~

De job staat dan wel in de stop-state (T), dit betekent echter niet dat deze job beeindigd is.  
We kunnen deze job laten herstarten via het SIGSTART-signaal (18).

* Terminal 2:

~~~
$ kill -18 50663
$ ps -f 50663 | grep sleep
bvo      50663 57255  0 13:49 pts/23   S      0:00 sleep 5000
$
~~~

Aan de kant van terminal 1 zien we dat deze job ook runnig is (weliswaar in de achtergrond)

* Terminal 1:

~~~
$ jobs
[1]+  Running                 sleep 5000 &
$ fg
sleep 5000
~~~

### top voor realtime monitoring

**ps** zal je een **snapshot** geven van wat er op die moment gaande is.  
ipv ps kan je top gebruiken voor real-time-monitoring, hou er wel rekening mee dat deze performantie-impact heeft

~~~
top - 12:48:49 up 19:38, 21 users,  load average: 2,83, 2,12, 1,88
Tasks: 419 total,   1 running, 417 sleeping,   0 stopped,   1 zombie
%Cpu(s): 13,5 us,  6,7 sy,  0,0 ni, 77,9 id,  0,0 wa,  0,0 hi,  1,8 si,  0,0 st
MiB Mem :  31991,0 total,  13155,7 free,   8652,9 used,  10182,4 buff/cache
MiB Swap:   2048,0 total,   2048,0 free,      0,0 used.  21606,6 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   3563 bart      20   0 5621272   1,0g 483780 S  23,5   3,2 122:01.87 GeckoMain
  35669 bart      20   0   29,7g 329700 100744 S  23,5   1,0  52:33.10 spotify
   2649 bart      20   0 4613048 234084 124064 S  17,6   0,7  17:26.29 cinnamon
  35619 bart      20   0 1284856 134680  93964 S  17,6   0,4  27:20.25 spotify
  47850 bart      20   0 2965720 352428 138208 S  17,6   1,1   2:14.40 Isolated Web Co
   1210 root      20   0 1894144 290696 218180 S  11,8   0,9  40:43.91 Xorg
   3871 bart      20   0 3184476 538468 110888 S  11,8   1,6  90:30.93 Isolated Web Co
   7371 bart      20   0 1465044 121764  74916 S  11,8   0,4   9:34.47 cinnamon-settin
  58405 bart      20   0   12460   4092   3368 R  11,8   0,0   0:00.04 top
   2306 bart       9 -11 3205688  28184  21676 S   5,9   0,1 117:23.16 pulseaudio
   2720 bart      20   0  525400  85380  50012 S   5,9   0,3   0:40.45 guake
  35596 bart      20   0 3604784 242044 149124 S   5,9   0,7   9:54.74 spotify
      1 root      20   0  167828  11776   8368 S   0,0   0,0   0:03.95 systemd
      2 root      20   0       0      0      0 S   0,0   0,0   0:00.05 kthreadd
      3 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 rcu_gp
      4 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 rcu_par_gp
      6 root       0 -20       0      0      0 I   0,0   0,0   0:02.17 kworker/0:0H-events_highpri
      9 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 mm_percpu_wq
     10 root      20   0       0      0      0 S   0,0   0,0   0:02.89 ksoftirqd/0
     11 root      20   0       0      0      0 I   0,0   0,0   0:36.25 rcu_sched
     12 root      rt   0       0      0      0 S   0,0   0,0   0:00.35 migration/0
     13 root     -51   0       0      0      0 S   0,0   0,0   0:00.00 idle_inject/0
     14 root      20   0       0      0      0 S   0,0   0,0   0:00.00 cpuhp/0
     15 root      20   0       0      0      0 S   0,0   0,0   0:00.00 cpuhp/1
     16 root     -51   0       0      0      0 S   0,0   0,0   0:00.00 idle_inject/1
     17 root      rt   0       0      0      0 S   0,0   0,0   0:00.49 migration/1
     18 root      20   0       0      0      0 S   0,0   0,0   0:01.57 ksoftirqd/1
    ...
~~~

1ste deel van top geeft ons statistieken rond uptime, users, aantal processen, cpu- en memory

~~~
top - 12:48:49 up 19:38, 21 users,  load average: 2,83, 2,12, 1,88
Tasks: 419 total,   1 running, 417 sleeping,   0 stopped,   1 zombie
%Cpu(s): 13,5 us,  6,7 sy,  0,0 ni, 77,9 id,  0,0 wa,  0,0 hi,  1,8 si,  0,0 st
MiB Mem :  31991,0 total,  13155,7 free,   8652,9 used,  10182,4 buff/cache
MiB Swap:   2048,0 total,   2048,0 free,      0,0 used.  21606,6 avail Mem 
~~~

* PID    =>  unieke identifier van het process
* USER   =>  de user gelinkt aan het process
* S      =>  status van het process
* %CPU => percentage cpu
* %MEM => percentage van het totale memory
* TIME => totale CPU-tijd dat het programma heeft ingenomen
* COMMAND => commando dat het process heeft gestart

### JOBS & JOBCONTROL

**Job control** is een tools binnen de shell die je toelaat vanuit 1 shell (of command-line) verschillende commando's te starten en te managen (in parallel)  

Wanneer we een **commando** uitvoeren in **bash**, wordt het dus **uitgevoerd** als een **job**.  
Het verstaan hoe dat je deze jobs moet **beheren** EN geeft je veel extra mogelijkheden...

Bedoeling van dit stuk is proberen uit te zoeken wat deze jobs zijn (in bash) en hoe deze gelinkt worden aan processen.  
We bekijken ook hoe je ze moet starten, pauzeren, in "background" laten runnen, ...


#### Een job/commando => meerdere processen

Een eerste belangrijk principe om te begrijpen is dan een JOB kan bestaan uit meerdere processen

~~~
+--------+
|  CMD   |  Een commando starten 
+---+----+  maakt een job aan binnen bash
    |
    |
+---v----+              +----------+
|  JOB   +--------------+ PROCESS  |
+---+----+              +----------+
    |  Deze job bestaat uit 1 of meerdere processen
    |                   +----------+
    +-------------------+ PROCESS  |
                        +----------+

                         ...
~~~

Laten we starten met een job die normaal gezien veel tijd moeten innemen.  
De volgende opdracht gaat voor het woord blabla zoeken in all files binnen mijn home-directory.  
(een job die meer dan een paar minuten kan duren afhanklijk van de grootte van je home-directory)

~~~
bart@bvlegion:~$ rgrep "blabla" . | less
~~~

Dit heeft nu een job gestart met 2 commando (grep en less).


#### Job onderbreken met Ctrl+Z

Laten we nu even deze job stoppen met de key-combo (ctrl-z) gebruik.  
Dit zal deze job stoppen (of pauzeren) en dan krijg je een boodschap als hieronder op het scherm

~~~
[1]+  Stopped                 rgrep "blabla" . | less
bart@bvlegion:~$ pwd 
/home/bart
bart@bvlegion:~$
~~~

Bemerk ook dat de prompt nu vrijgegeven is en ik andere commando's kan uitvoeren (voorbeeld met pwd)

#### Job-table (en het commando jobs)

De processen en de jobs zijn gestopt maar niet verdwenen.  
Hiervoor voorziet bash namelijk een **job-table** die bijhoudt welke jobs worden uitgevoerd.

Deze table kan je consulteren via het commando **jobs**.  
Deze duidt aan dat er momenteel 1 job draaiende is, let ook dat deze een id heeft gekregen.  
(in dit geval 1)

~~~
bart@bvlegion:~$ jobs
[1]+  Stopped                 rgrep "blabla" . | less
~~~

Dit id (1 in het voorbeeld) is niet te verwarren met de PID.  
Deze kan je ook bekijken door een extra optie mee te geven aan jobs (-l).

~~~
bart@bvlegion:~$ jobs -l
[1]+ 84420 Stopped                 rgrep "blabla" .
     84421                       | less
bart@bvlegion:~$ 
~~~

Deze toont ook aan da je meerdere processen verbonden hebt aan deze job met hun pid (88420 en 88421 in dit geval).  
Als we dit dan bestuderen via ps:

~~~
bart@bvlegion:~$ ps -l
F S   UID     PID    PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  1000    3116    2861  0  80   0 -  2870 do_wai pts/6    00:00:00 bash
0 T  1000   84420    3116  0  80   0 -  2428 do_sig pts/6    00:00:01 grep
0 T  1000   84421    3116  0  80   0 -  2193 do_sig pts/6    00:00:00 less
4 R  1000   86246    3116  0  80   0 -  2936 -      pts/6    00:00:00 ps
~~~

* Je **main-process** is je **bash-shell** en heeft de pid **3116**
  * Dit process staat in de de **S-status**  
    (wat er op neerkomt dat deze wacht op CPU-tijd en idle is)
* Deze heeft **2 children**
  * 84420 => grep-commando
  * 84421 => less-commando
  * Deze **2 commando's** staan in de **T-status**  
    (stop-status die je na een SIGSTOP verkrijgt)

Om deze job terug naar de voorgrond te brengen kan je het commando **fg** gebruiken waardoor het 
terug op de voorgrond verschijnt en je bijvoorbeeld Ctrl+C kan gebruiken om dit te beeindigen.

Hoe dit programma **fg** en zijn collega **bg** kunnen gebruiken om meerdere jobs te runnen gaan we nu zien.

#### Een job in background draaien met &

Een job waarvan het process wordt gepauzeerd (door een STOP-signaal) wordt in background geplaatst.  
Wat als je een job **direct** in de **achtergrond** wil laten lopen (en niet stoppen)?

Dit kan op verschillende manieren, maar een veel gebruikte is je commando te laten volgen door een **&**.  
Dit zorgt ervoor dat je command-prompt niet zal wachten op deze job en deze dus in background draait...

In het onderstaande voorbeeld starten we 3 jobs adhv het commando sleep 

> sleep is een tool die een gegeven aantal seconden zal wachten
> deze wordt veel gebruikt binnen scripten om voor een delay te zorgen

~~~
$ sleep 360 &
[1] 31056
$ sleep 365 &
[2] 31452
$ sleep 370 &
[3] 31714
~~~

#### Job-table

Bash houdt alle jobs binnen je bash-sessie bij in een job-table.  
Zoals eerder getoond kan je hier het commando jobs voor gebruiken, de short option l zorgt ervoor dat je deze kan correleren met het process-id

~~~
$ jobs -l
[1]  31056 Running                 sleep 360 &
[2]- 31452 Running                 sleep 365 &
[3]+ 31714 Running                 sleep 370 &
~~~

Als we nu de job-table bekijken zien we dat er 3 jobs draaien:

* job 1 met een process 31056 (sleep 360)
* job 1 met een process 31452 (sleep 365)
* job 1 met een process 31714 (sleep 370)

> Bemerk ook dat de laatst gestart job wordt voorafgegaan door een + en de voorlaatste door een -

De processen die gelinkt zijn aan deze job vind je terug via ps (zie PID's):

~~~
$ ps -l
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  1173  2425  2424  0  80   0 -  2141 -      pts/16   00:00:00 bash
0 S  1173 31056  2425  0  80   0 -  1315 hrtime pts/16   00:00:00 sleep
0 S  1173 31452  2425  0  80   0 -  1315 hrtime pts/16   00:00:00 sleep
0 S  1173 31714  2425  0  80   0 -  1315 hrtime pts/16   00:00:00 sleep
0 R  1173 33096  2425  0  80   0 -  2637 -      pts/16   00:00:00 ps
~~~

#### fg-commando

Stel dat je 1 van de jobs terug naar de voorgrond wil brengen dan kan je dit doen via het fg-commando.

~~~
$ jobs -l
[1]  31056 Running                 sleep 360 &
[2]- 31452 Running                 sleep 365 &
[3]+ 31714 Running                 sleep 370 &
~~~

Hiervoor duid je de job aan die je wenst naar de voorgrond te brengen met een % gevolgd door de jobnummer (niet de pid)

~~~
$ fg %2
sleep 365
~~~

Job met nummer 2 wordt dan opnieuw naar de voorgrond en de prompt wordt dan opnieuw geblokkeerd (wachtende op het beeindigen van deze job)

#### bg-commando

Als je nu (vanuit deze shell) de job terug naar de achtergrond wil brengen gebruik je Ctrl+z hetgeen een stop-signaal zal zenden naar het process gelinkt naar deze job.

~~~
$ fg %2
sleep 365
^Z
[2]+  Stopped                 sleep 365
$
~~~

De prompt komt terug vrij maar de job blijft echter nog in een stop-status

~~~
$ jobs -l
[1]  31056 Running                 sleep 360 &
[2]+ 31452 Stopped                 sleep 365
[3]- 31714 Running                 sleep 370 &
~~~

Het je ook terugvindt in de proces-table, zie pid 31452 dat in status T staat.

~~~
$ ps -l
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  1173  2425  2424  0  80   0 -  2141 -      pts/16   00:00:00 bash
0 S  1173 31056  2425  0  80   0 -  1315 hrtime pts/16   00:00:00 sleep
0 T  1173 31452  2425  0  80   0 -  1315 -      pts/16   00:00:00 sleep
0 S  1173 31714  2425  0  80   0 -  1315 hrtime pts/16   00:00:00 sleep
0 R  1173 35174  2425  0  80   0 -  2637 -      pts/16   00:00:00 ps
~~~

Om het proces terug te hervatten kan je die doen via het commando bg.  
Deze zal de job terug in running-state plaatsen en het process hervatten.

~~~
$ bg %2
[2]+ sleep 365 &
$ jobs -l
[1]  31056 Running                 sleep 360 &
[2]- 31452 Running                 sleep 365 &
[3]+ 31714 Running                 sleep 370 &
~~~

Je kon ook kiezen dit process opnieuw in fg te brengen

#### Job beeindigen met fg en Ctrl-C

De meest éénvoudige manier om een job te beeindigen is het volgende 2-stappen-process:

* De job naar de voorgrond brengen (via fg)
* Deze job vervolgens te stoppen via Ctrl+c

~~~
$ fg %3
sleep 370
^C
$ 
~~~

Vervolgens zal je zien dat deze job gestopt is (en verwijderd uit de job-table)

~~~
$ jobs
[1]-  Running                 sleep 360 &
[2]+  Running                 sleep 365 &
$
~~~

#### Beeindigen via kill

Je kan een job ook beindigen adhv het kill commando.  
Gegeven dat je onderstaande job-table overhebt...

~~~
$ jobs
[1]-  Running                 sleep 360 &
[2]+  Running                 sleep 365 &
$
~~~

...kan je deze job stoppen met hulp van de percentage-notatie (je hoeft niet de pid te gebruiken)

~~~
$ kill %1
~~~

Deze job zie je nadien nog in de job-table met de status "Terminated"

~~~
$ jobs
[1]-  Terminated              sleep 360
[2]+  Running                 sleep 365 &
$
~~~

#### Done...

Als we de overblijvende job laten "uitdraaien" dan zal deze job uiteindelijk (na +- 365 seconden in de )

~~~
$ jobs
[2]+  Done                    sleep 365
$ jobs
$
~~~

Eénmaal de info is opgevraagd verdwijnt deze job uit de jobtable...

### crontab

Cron is een applicatie waar je mee scripten en taken kan automatiseren.

Door te werken met een cron job (of geplande taak) kan u achter de schermen via de cron commando's op terugkerende tijdstippen uitvoeren.  
Je kan dit gebruiken voor bijvoorbeeld:

* Opkuisen, backup maken, verplaatsen van folders en betanden
* Regelmatig aansturen van metingen (bijvoorbeeld met sensors
* ...

Hoe werkt dit?

Elke gebruiker beschikt over een eigen crontab, deze kan eenvoudig gebruikt worden aan de hand van het crontab-commando.  
3 belangrijke varianten van het aanroepen van een crontab bestaan:

* crontab -e => Wijzigen van een crontab
* crontab -l => Weergave van de crontab
* crontab -r => Verwijderen/clearnen van de volledige crontab

Binnen zo'n crontab kan je meerdere regels plaatsen, elke regel staat dan voor een geplande taak.  
De regel start steeds met de definitie van het tijdstip.

De vorm van een regel lijkt in het eerste zicht intimiderend, de opbouw is echter logisch.
Een crontab regel bestaat uit 6 velden, welke telkens gescheiden worden door witte ruimtes (één of meerder spaties of tabs).

~~~
+------------- minuten (0 - 59) 
¦ +-------------- uren (0 - 23)
¦ ¦ +--------------- dag van de maand (1 - 31)
¦ ¦ ¦ +---------------- maand (1 - 12)
¦ ¦ ¦ ¦ +----------------- weekdag (0 - 6) (0 is zondag, 1 is maandag, ..., 7 is eveneens zondag)
¦ ¦ ¦ ¦ ¦
¦ ¦ ¦ ¦ ¦
* * * * *     plaats hier je commando
~~~

Een correcte regel kan er dus als volgt uit zien:

~~~
05 18 * * 3     echo "hello $(date)" >> /home/student/test.txt
~~~

De bovenstaande regel zorgt er voor dat éénmaal per week, namelijk op Woensdag om 18.05 hello gevolgd naar een file test.txt in de home-folder van de
gebruiker student schrijven.


Als je bijvoorbeeld elke dag wil vervang je bijvoorbeeld de 3 door een *

~~~
05 18 * * *     echo "hello $(date)" >> /home/student/test.txt
~~~

Als je het tijdelijk wil uitschakelen kan je de lijn in commentaar zetten

~~~
# 05 18 * * *     echo "hello $(date)" >> /home/student/test.txt
~~~

### Eerste maal gebruik maken van cron

Als je als gebruiker voor het eerst cron gebruikt, moet je een editor kiezen.  
Maak hier de keuze voor nano (vim enkel gebruikt wanneer je daar kennis van hebt)

~~~
student@studentdeb:~$ crontab -l
no crontab for student
student@studentdeb:~$ crontab -e
no crontab for student - using an empty one

Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.tiny

Choose 1-2 [1]: 1
~~~

Vervolgens zal nano open waar je een crontab kan toevoegen:

~~~bash
# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command
~~~



Volgend commando zal bijvoorbeeld elke minuut een lijn met het tijdstip toevoegen aan de file
/home/student/text

~~~
* * * * * echo "$(date)" >> /home/student/test.txt
~~~

Voeg de bovenstaande lijn toe en sluit de editor af.  
Na het afsluiten kan je de crontab-shedules bekijken via het volgende commando:

~~~bash
student@studentdeb:~$ crontab -l
# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command

* * * * * echo "$(date)" >> /home/student/test.txt
~~~

+- 1 minuut later zou deze file moeten aangemaakt worden (en stelselmatig groeien)

~~~
student@studentdeb:~$ ls -l /home/student/student.txt 
-rw-r--r-- 1 student student 32 Dec 22 16:30 /home/student/student.txt
student@studentdeb:~$ cat /home/student/student.txt 
Wed 22 Dec 2021 04:30:46 PM CET
student@studentdeb:~$ ls -l /home/student/student.txt 
-rw-r--r-- 1 student student 64 Dec 22 16:31 /home/student/student.txt
student@studentdeb:~$ student@studentdeb:~$ cat /home/student/student.txt 
Wed 22 Dec 2021 04:30:46 PM CET
Wed 22 Dec 2021 04:31:46 PM CET
student@studentdeb:~$ 
~~~
