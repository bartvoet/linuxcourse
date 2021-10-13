## Users en groups

### Users

Linux gebruikers hebben "usernames" om ze te identificeren.  
Intern onderscheidt het systeem gebruikersaccounts aan de hand van het **unieke** **identificatienummer** dat is toegewezen aan hen, de gebruikers-ID of **UID**.

Als een user actief wordt gebruikt, wordt er over het algemeen een **passwoord** aan toegewezen
Dit wachtwoord zal de gebruiker dan gebruiken om te bewijzen dat hij de daadwerkelijke geautoriseerde gebruiker is bij het inloggen.

Naast deze **authenticatie** en **authorisatie** (om te kunnen inloggen) zal deze user of account ook gebruikt worden om toegang al dan niet te krijgen om folders en/of bestanden.

#### Soorten van users

We onderscheiden 3 soorten users

* De superuser of root:  
  Deze wordt gebruikt voor systeem-administratie en/of configuratie.  
  De naam van deze user is root en heeft een UID van 0.  
  Deze superuser heeft in principe access tot het gehele systeem (files, processen, ...)
* Gewone user-accounts:  
  Gewone gebruikers (die inloggen) op het systeem.  
  Binnen de setup hebben we reeds zo een user aangemaakt (student)
* Systeem-accounts:  
  Het systeem heeft users die worden gebruikt door processen die services bieden.
  Deze processen - of daemons - hoeven meestal niet als superuser te worden uitgevoerd.  
  Deze gebruikers loggen niet interactief in (en zijn ook meestal geen gebruikers)

Voor system-users zijn ook specifieke ranges voorzien:

* UID 0 wordt altijd toegewezen aan de superuser-account, root.
* UID 1-999 voor systemusers
* UID 1000+ is het bereik dat beschikbaar is voor toewijzing aan **normale users**.


#### Informatie over je eigen user

Een aantal handige commando's om informatie te verkrijgen over je user.  
Als je de username wil printen kan je **logname** gebruken

~~~
student@studentdeb:~$ logname
student
~~~

Als je meer info wil weten kan je **id** gebruiken.  
Deze geeft je meer informatie:

* Je numeriek UID
* De GID van de primaire group waartoe je behoort
* Een lijst van alle groupen en hun GID's

~~~
student@studentdeb:~$ id
uid=1000(student) gid=1000(student) groups=1000(student),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev),109(netdev),112(bluetooth),116(lpadmin),119(scanner)
~~~

Wil je enkel de lijst van de groepen waar je toe behoort afdrukken dan kan dit via het commando **groups**

~~~
student@studentdeb:~$ groups
student cdrom floppy audio dip video plugdev netdev bluetooth lpadmin scanne
~~~

#### Inloggen als de superuser

Andere users en groupen beheren kan niet zomaar met een standaard user-account.  
Hiervoor moet je inloggen als superuser of **root**.  

Je kan dit doen via de su ofwel "**s**witch **u**ser".  
Dit commando staat dus niet voor superuser want je kan dit ook gebruiken om met eender welke ander user in te loggen.

Als je echter in het root-account wil inloggen gebruik je het commando als volgt:

~~~
student@studentdeb:~$ su -
Password: 
root@studentdeb:~#
~~~

Let wel dat je hier een hyphen (streepje) plaatst, anders gaan er bepaalde scripts en environment-variabelen gelinkt aan de root-user niet uitgevoerd worden.

#### User toevoegen

~~~
root@studentdeb:~# useradd -c "My personal user" -m -s /bin/bash bart
~~~

~~~
student@studentdeb:~$ su - bart
Password: 
bart@studentdeb:~$ users
student
bart@studentdeb:~$ pwd
/home/bart
bart@studentdeb:~$ 
~~~

* -c, --comment COMMENT  
  Voeg de echte naam (of schermnaam) van de gebruiker toe aan het opmerkingenveld.
* -g, --gid GROUP  
  Geef de primaire groep voor het gebruikersaccount op.
* -G, --groups GROUPS  
  Geef een door komma's gescheiden lijst op van aanvullende groepen voor
  het gebruikersaccount.
* -a, --append  
  Gebruikt samen met -G om aan te duiden dan je groepen gaat toevoegen
* -s, --shell SHELL  
  Geef een bepaalde login-shell voor deze user bij het inloggen
* -L, --lock  
  Vergrendel het gebruikersaccount.

#### Passwoord aanpassen

~~~
root@studentdeb:~# passwd bart
New password: 
Retype new password: 
passwd: password updated successfully
root@studentdeb:~# 
~~~

#### /etc/passwd

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

* bart =>  
  Gebruikersnaam voor deze gebruiker (bart).
* x =>  
  Het wachtwoord van de gebruiker werd hier versleuteld opgeslagen. Dat is verplaatst naar de
  /etc/shadow-bestand, dat later wordt behandeld. Dit veld moet altijd x zijn.
* 1001 =>  
  Het UID-nummer voor deze gebruikersaccount.
* 1001 =>  
  Het GID-nummer voor de primaire groep van dit gebruikersaccount (zie verder).
* My personal user =>  
  De echte naam voor deze gebruiker.
* /home/bart =>  
  De homedirectory voor deze gebruiker.  
  Dit is de initiële werkdirectory wanneer de shell start.
* /bin/bash/ =>  
  Het standaard shell-programma voor deze gebruiker, dat draait bij inloggen (/bin/bash). Voor een gewone gebruiker, dit is normaal gesproken het programma dat de opdrachtregelprompt van de gebruiker geeft.  Een systeemgebruiker zou /sbin/nologin kunnen gebruiken als interactieve logins niet zijn toegestaan ​​voor die gebruiker.


#### /etc/shadow

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

~~~
root@studentdeb:~# groups bart
bart : bart
root@studentdeb:~# usermod -aG scanner bart
root@studentdeb:~# groups bart
bart : bart scanner
root@studentdeb:~# 
~~~

#### group aanmaken

~~~
root@studentdeb:~# groupadd students
root@studentdeb:~# usermod -aG students bart
root@studentdeb:~# usermod -aG students student
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