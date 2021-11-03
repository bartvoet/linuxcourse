## Users en groups

### Users

Linux gebruikers gebruiken (net als bij andere systemen) een username en passwoord om op een Linux-machine in te loggen.

Elke username is binnen Linux verbonden aan een **uniek** **identificatienummer** de gebruikers-ID of **UID**.

Deze user (met passwoord) wordt gebruikt om in te loggen en zich te authenticeren op een Linux-systeem?

Naast de **authenticatie** wordt deze login gebruikt om toegang of **authorisatie** te krijgen op verschillende systeem-elementen (folders, files, processen, services, ...).

#### Soorten van users

We onderscheiden 3 soorten user:

* De **superuser** of **root**:  
  Wordt gebruikt voor **systeem-administratie** en/of **configuratie**.  
  De naam van deze user is **root** en heeft een **UID** van **0**.  
  Deze superuser heeft in principe **access tot het gehele systeem** (files, processen, ...)
* **Gewone user-accounts**:  
  **Gewone gebruikers** die **inloggen** op het systeem.  
  Binnen de setup van Debian hebben we reeds zo een user aangemaakt (student)
* **Systeem-accounts**:  
  Sommige users zijn niet gemaakt om in te loggen maar worden gebruikt om specifieke processen en/of services te beheren.  
  Deze services (in background) - of daemons - hoeven meestal niet als superuser te worden uitgevoerd.  
  Deze gebruikers loggen niet interactief in (en zijn ook meestal geen gebruikers)

#### Ranges voor UID's

Voor UID's zijn ook specifieke ranges voorzien:

* UID **0** wordt altijd toegewezen aan de **superuser**-account, root.
* UID **1-999** voor **systemusers**
* UID **1000+** is het bereik dat beschikbaar is voor toewijzing aan **normale users**.

#### Informatie over je eigen user

Een aantal handige **commando's** om **informatie** te verkrijgen over je user.  
Als je de username wil printen kan je **logname** gebruiken

~~~
student@studentdeb:~$ logname
student
~~~

Als je meer info wil weten kan je het commando **id** gebruiken.  
Deze geeft je meer informatie:

* Je numeriek **UID**
* De **GID** van de **primaire group** waartoe je behoort
* Een **lijst** van alle **groups** en hun GID's

~~~
student@studentdeb:~$ id
uid=1000(student) gid=1000(student) groups=1000(student),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev),109(netdev),112(bluetooth),116(lpadmin),119(scanner)
~~~

Wil je **enkel** de **lijst** van de **group-namen** waar je toe behoort afdrukken dan kan dit via het commando **groups**

~~~
student@studentdeb:~$ groups
student cdrom floppy audio dip video plugdev netdev bluetooth lpadmin scanne
~~~

#### Inloggen als de superuser

Andere users en groupen beheren kan niet zomaar met een standaard user-account.  Hiervoor moet je inloggen als superuser of **root**.  

Je kan dit doen via de su ofwel "**s**witch **u**ser".  
Dit commando staat dus niet voor superuser want je kan dit ook gebruiken om met eender welke ander user in te loggen.

Als je echter in het root-account wil inloggen gebruik je het commando **su -** als volgt:

~~~
student@studentdeb:~$ su -
Password: 
root@studentdeb:~#
~~~

Let wel dat je hier een hyphen (streepje) plaatst, anders gaan er bepaalde scripts en environment-variabelen gelinkt aan de root-user niet uitgevoerd worden.

> *Waarschuwing*  
> Met deze **root-user** kan je zowat alles doen op je systeem.  
> Maar met **"great power"** komen er ook **"big responsabilities"**.  
> Bij **foutief gebruik** van deze user kan het zijn dat je
> **onherstelbare schade** toebrengt aan je systeem waardoor
> dat het systeem niet meer correct werkt (of zelfs niet meer boot).  
> Gebruik dus deze superuser enkel wanneer het absoluut noodzakelijk is!!!

#### User toevoegen

Laten we starten met het toevoegen van een gebruiker.  
Hiervoor gebruiken we het commando **useradd**, let wel dat we dit commando dienen uit te voeren met **root-permissies**.

Hieronder voegen we een gebruiker toe, bemerk dat er een aantal opties aan toegevoegd zijn:

~~~
root@studentdeb:~# useradd -c "My personal user" -m -s /bin/bash bart
~~~

De opties die we hieronder gebruikte zijn:

* -c, --comment COMMENT  
  Voegt de echte naam (of schermnaam) van de gebruiker toe aan het opmerkingenveld.
* -m, --create-home  
  Zorgt ervoor dat de gebruiker een home-directory verkrijgt (als deze nog niet bestaat)
* -s, --shell SHELL  
  Geef een bepaalde login-shell voor deze user bij het inloggen


Daarnaast kan je nog een aantal andere opties gaat toevoegen:

* -g, --gid GROUP  
  Geef de primaire groep voor het gebruikersaccount op.
* -G, --groups GROUPS  
  Geef een door komma's gescheiden lijst op van aanvullende groepen voor
  het gebruikersaccount.
* -a, --append  
  Gebruikt samen met -G om aan te duiden dan je groepen gaat toevoegen
* -L, --lock  
  Vergrendel het gebruikersaccount.


#### Passwoord aanpassen

Een 2de stap is de user een password geven (hetgeen nodig is om in te loggen).  
Dit kan met de het commando **passwd** zoals hieronder geillustreerd:

~~~
root@studentdeb:~# passwd bart
New password: 
Retype new password: 
passwd: password updated successfully
root@studentdeb:~# 
~~~

#### Switch user

Zoals we eerder vermelden kan je su gebruiken om vanuit een shell te **wisselen** van **user**.  
Het volstaat om na su je naam te vermelden (als je niets vermeld zal su proberen in te loggen als de root-user)

~~~
student@studentdeb:~$ su - bart
Password: 
bart@studentdeb:~$ users
student
bart@studentdeb:~$ pwd
/home/bart
bart@studentdeb:~$
~~~

#### /etc/passwd

De informatie die je meegaf aan adduser en andere date wordt (standaard) bijgehouden in een file /etc/passwd.  
Als je de laatste 10 lijnen bekijkt (via het commando tail) kan je deze bekijken

~~~
root@studentdeb:~# tail -10 /etc/passwd
avahi:x:109:115:Avahi mDNS daemon,,,:/run/avahi-daemon:/usr/sbin/nologin
speech-dispatcher:x:110:29:Speech Dispatcher,,,:/run/speech-dispatcher:/bin/false
pulse:x:111:117:PulseAudio daemon,,,:/run/pulse:/usr/sbin/nologin
saned:x:112:120::/var/lib/saned:/usr/sbin/nologin
colord:x:113:121:colord colour management daemon,,,:/var/lib/colord:/usr/sbin/nologin
lightdm:x:114:122:Light Display Manager:/var/lib/lightdm:/bin/false
student:x:1000:1000:student,,,:/home/student:/bin/bash
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
vboxadd:x:998:1::/var/run/vboxadd:/bin/false
bart:x:1001:1001:My personal user:/home/bart:/bin/bash
~~~

Als we de user bart bekijken...

~~~
bart:x:1001:1001:My personal user:/home/bart:/bin/bash
~~~

...zien we volgende gegevens

* **bart** =>  
  **Gebruikersnaam** voor deze gebruiker (bart).
* **x** =>  
  Het **wachtwoord** van de gebruiker werd hier **versleuteld** opgeslagen. Dat is verplaatst naar de
  /etc/shadow-bestand, dat later wordt behandeld. Dit veld moet altijd x zijn.
* **1001** =>  
  Het **UID**-nummer voor deze gebruikersaccount.
* **1001** =>  
  Het **GID**-nummer voor de primaire groep van dit gebruikersaccount (zie verder).
* My personal user =>  
  **De echte naam** of **commentaar** voor deze gebruiker.
* **/home/bart** =>  
  De **homedirectory** voor deze gebruiker.  
  Dit is de initiële werkdirectory wanneer de shell start.
* **/bin/bash/** =>  
  Het **standaard** **shell**-programma voor deze gebruiker, dat draait bij inloggen (/bin/bash).  
  Voor een gewone gebruiker, dit is normaal gesproken het programma dat de opdrachtregelprompt van de gebruiker geeft.  Een systeemgebruiker zou /sbin/nologin kunnen gebruiken als interactieve logins niet zijn toegestaan ​​voor die gebruiker.

#### /etc/shadow

De passwoorden zelf worden in **versleutelde vorm** in een **aparte file** bijgehouden.  
Deze file noemt **/etc/shadow**

~~~
root@studentdeb:~# tail -10 /etc/shadow
avahi:*:18896:0:99999:7:::
speech-dispatcher:!:18896:0:99999:7:::
pulse:*:18896:0:99999:7:::
saned:*:18896:0:99999:7:::
colord:*:18896:0:99999:7:::
lightdm:*:18896:0:99999:7:::
student:$y$j9T$hFAAuVnT/y76TGLtQUxt90$AmI4Ee/G58nhQs0/FPR3wEpVThZwOKs8eyZqXmGU4n.:18896:0:99999:7:::
systemd-coredump:!*:18896::::::
vboxadd:!:18899::::::
bart:$y$j9T$XjMYmgIXJKlf5XiUZTWFe0$skqNAAVJg6a1gPETcar/q8FMxzBH5mHuyXazVGWjpm1:18913:0:99999:7:::
root@studentdeb:~# 
~~~

### Groups

Een groep is een groepering gebruikers waarmee.  
Groepen kunnen bijvoorbeeld worden gebruikt om toegang tot bestanden te verlenen aan een groep gebruikers in plaats van aan slechts één gebruiker.

Net als gebruikers hebben groepen groepsnamen om het werken met hen te vergemakkelijken.  
Intern, het systeem zal Linux groepen onderscheiden door de unieke identificatienummer 
die eraan is toegekend, de groeps-ID of GID.

De toewijzing van groepsnamen aan GID's wordt gedefinieerd het bestand /etc/group om informatie over lokale groepen op te slaan.

~~~
root@studentdeb:~# tail -10 /etc/group
pulse:x:117:
pulse-access:x:118:
scanner:x:119:saned,student
saned:x:120:
colord:x:121:
lightdm:x:122:
student:x:1000:
systemd-coredump:x:999:
vboxsf:x:998:
bart:x:1001:
root@studentdeb:~# 
~~~

In bijvoorbeeld de systeem-user scanner:

~~~
scanner:x:119:saned,student
~~~

Vindt je de volgende info:

* scanner =>  
  Groepsnaam voor deze groep.
* x =>  
  Veld voor groepswachtwoord. Dit veld moet altijd x zijn.
* 119 =>  
  Het GID-nummer voor deze groep (10000).
* saned,student =>  
  Een lijst met gebruikers die lid zijn van deze groep als aanvullende groep

#### user aan groep toevoegen

Met het commando **groups** kan je nakijken tot welke groepen je behoort.  
Standaard wordt er een groep aangemaakt met dezelfde naam als je user (zoals gedemonstreerd hieronder)

~~~
root@studentdeb:~# groups bart
bart : bart
~~~

Als je de user bart bijvoorbeeld wil **toevoegen** aan een **bestaande groep** kan dit via het commando **usermod**.  
usermod bevat **dezelfde** **opties** zoals **useradd**, in dit geval gebruiken we de optie  "usermod -aG" om een een group toe te voegen.

~~~
root@studentdeb:~# usermod -aG scanner bart
root@studentdeb:~# groups bart
bart : bart scanner
root@studentdeb:~# 
~~~

#### group aanmaken

In bovenstaand geval voegden we een bestaande groep toe, wat als je een nieuwe groep wil aanmaken?  

Dit kan via het commando **groupadd**.  
We maken bijvoorbeeld een groep students aan.

~~~
root@studentdeb:~# groupadd students
~~~

Je moet hier enkel als argument de naam van de groep toevoegen.  
Vervolgens voegen de 2 huidige users (bart en student) toe aan deze groep (via usermod).

~~~
root@studentdeb:~# usermod -aG students bart
root@studentdeb:~# usermod -aG students student
~~~

#### users van een groep oplijsten

Vervolgens kan je het commando **groupmems** gebruiken om de leden van deze groep op te lijsten.

~~~
root@studentdeb:~# groupmems -g students --list
bart  student 
~~~

#### Primaire en secundaire user-groepen

Elke gebruiker heeft precies één primaire groep.  
Voor lokale gebruikers is dit de groep vermeld op GID-nummer in
het /etc/passwd-bestand.

Standaard is dit de groep die eigenaar is van nieuwe bestanden die door de gebruiker zijn gemaakt.  
Normaal gesproken - wanneer je een nieuwe gewone gebruiker aanmaakt - wordt er een nieuwe groep met dezelfde naam als die gebruiker aangemaakt.

Deze groep wordt gebruikt als de primaire groep voor de nieuwe gebruiker, en die gebruiker is de enige
lid van deze privé-gebruikersgroep.  Het maakt het beheer van het files en directories (en de permissies ervan eenvoudiger.  (dit komt later in deze cursus nog terug)