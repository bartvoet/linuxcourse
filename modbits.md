## Controlebeheer voor files

### Linux File Permissions

Binnen **Linux** (en andere Unix-like-systemen) is het mogelijk de **toegang** tot **files** en **directories** te **controleren** en **beheren**.  
Dit doen we aan de hand van "**Linux Filesystem Permissions**"

Dit is een **éénvoudig** maar **flexibel** **mechanisme** (niet het enige) en stelt je toch in staat zijn om de meeste standaard permissie-use cases af the handelen.

> Nota:  
> Dit is niet het enige mechanisme dat bestaat in Linux maar je als
> standaard gebruiker eerst wordt met geconfronteerd.  
> In meer advanced use cases zou het ook kunnen dat
> je - als system administrator bijvoorbeeld - **SELinux-permissies**
> dient aan te passen.  
> Dit val echter niet onder het korte bestek van deze (relatief korte) cursus.

#### Permissies bekijken met ls -l

We hebben al eerder gezien dat je via het commando **ls** - meerbepaald met de optie **-l** - de details van een file kunnen opvragen.  
Met dit commando kan ook de nodig info opvragen met betrekking tot de toegangsregels naar die files en directories.

In de snippet **hieronder** zie je de details van een aantal files:

~~~
student@studentdeb:~$ ls -l
...
-rw-r--r-- 1 student student      0 Dec 22 10:58  file
-rwxr-xr-- 1 student student      0 Nov 24 12:14  file1
-rw-r--r-- 1 student student      0 Dec 22 10:58  file11
-rw-rw-rw- 1 student student      0 Nov 24 12:14  file2
-rw-r--r-- 1 student student      0 Dec 22 11:25  filea
-rw-r--r-- 1 student student      0 Dec 22 11:31  fileb
drwxr-xr-x 2 student student   4096 Oct 27 19:06  hello
...
student@studentdeb:~$ 
~~~

De **gegevens** die we hier zien en betrekking hebben op **toegang/authoristatie** zijn:

* **Welke permissies** zijn geconfigureerd voor deze file (of directory)?
* **Welke user** is **eigenaar** van deze file/directory?
* Tot **welke group** behoort deze **file** (niet noodzakelijk een groep van de user)

~~~
          permissies    user   group
          ____|____   ___|___ ___|___
          |       |   |     | |     |
         -rwxr-xr-- 1 student student      0 Nov 24 12:14  file1
         |
  type --+
~~~

##### Type van file

Het **eerste karakter** geeft het **type** van de **file** aan:

* Het symbool **-** voor **normale files**
* **d** voor **directories**
* **l** voor softlinks (shortcuts) naar andere fles
* Het is ook mogelijk dat we nog andere types
  * **c** voor **"character device"**
  * **b** voor **"block device"**
  * **s** voor **"Local Domain Sockets"**
  * **p** voor **"named pipes"**
  * **l** voor **symbolic links**

##### Permissies

De **volgende 9 karakters** duiden de permissies aan.  
We zien daarin de volgende soorten karakters:

* **r,w,x** stellen respectievelijk **read, write en execute** voor
* Het teken **-** houdt het ontbreken van permissie (geen permissie)


Deze **9 karakters** (rwxr-xr--) moet je eigenlijk **zien/splitsen** in **3 groepen** (user, group en others):

~~~
   user --+  group --+  others --+
          |          |           |
         rwx        r-x         r--
~~~

#### Permissies voor wie?  => 3 permissie-niveaus!!!

We weten nu dat er **3 soorten niveaus van users/gebruikers**: *user, group of others*  
Er wordt maw op 3 niveaus **bepaald** **wie** dat er het **recht** heeft om met een **file** te kunnen **werken**:

* **user** of **u**:
  De **user** is de **owner**/eigenaar van de **file**
  Elk bestand is eigendom van een gebruiker, meestal is dit degene die het bestand heeft gemaakt.
* **group** of **g**:
  Iedereen die **niet tot de group** behoort waar de file toe behoort.  
  Het bestand behoort dus ook tot een groep.  
  Meestal is dit de primaire groep van de user
  die het bestand heeft aangemaakt 
  (maar dat kan worden gewijzigd)
* **others**  of **o**:
  Iedereen die **niet** tot de **2 bovenvermelde niveaus** behoort, 
  maw niet de user of de group waar de file toe behoort.

##### Welke permissie-niveau wordt er gebruikt/toegepast?

We weten nu dat er 3 permissie-niveaus bestaan, wanneer en hoe worden deze nu toegepast

Zoals we weten wordt **file/directory** binnen **Linux** gelinkt aan **user** en **group**
Beiden worden gebruikt om permissies te vergelijken (zoals we dadelijk gaan zien).  

Als **voorbeeld**, hieronder zie je dat **file1** **gelinkt** aan de **user student** en de **group student**

~~~
          permissies    user   group
          ____|____   ___|___ ___|___
          |       |   |     | |     |
  file1  -rwxr-xr-- 1 student student      0 Nov 24 12:14  file1
         |
  type --+
~~~

We weten ook dat er 3 niveaus waren (user, group en others)

~~~
   user --+  group --+  others --+
          |          |           |
         rwx        r-x         r--
~~~

**Wanneer** gaan we nu **welk** vna deze 3 **permessie-niveaus** toepassen (rwx, r-x of r--).  
Dit wordt bepaald door **3 elementen**:

* De **user** en **group** van de **file**, in dit geval student en student
* De **user** die **ingelogd** is en een bewerking met de file doen
* De **groepen** - primair of secundair - waartoe de gebruiker behoort

Als een **user** een file wil gebruiken zal Linux de volgende **regel** toepassen:

* Komt de **user** die **ingelogd** is overeen met de **user** van de **file**:
  * Wordt het **user-niveau** toegepast 
  * Dan wordt de **eerste blok** toegepast
  * In dit geval is dit dus **rwx**
* **Anders** (als deze niet overeenkomt) lijkt het systeem (Linux) na:
  * Of de **groep** van de **file** (student)  
  * Een **groep** is waar de **user tot behoort**
  * Dan wordt de **tweede blok** toegepast
  * In dit geval dus **r-x**
* Als dit ook niet voldaan is 
  * **Noch** **user** of **group** komt **overeen**
  * Passen we het **derde niveau** toe
  * In dit geval dus **r--**


#### Wat betekenen deze permissies? => 3 soorten rechten!!!

Elk van de 3 **niveaus** van permissies bestaat dan zijn er dus **3 niveaus van rechten**  (r,w,x)
Deze hebben de volgende betekenis voor files of directories (let wel, lichtelijk verschillend file vs directories)

* **r** of **read**  
  * De **file** inhoud kan **gelezen** worden,  
  * In geval van een **directory** kan men de **inhoud** van een **directory** **oplijsten**  
    (met bijvoorbeeld ls)
* **w** of **write**  
  * De **file**-inhoud (of content) kan **gewijzigd** worden.  
  * Voor **directories** kan men **files** toevoegen of deleten binnen een directory.
* **x** of **execute**  
  * Een **file** kan men **uitvoeren** als commmando.  
  * In geval van een **directory** kan je deze als **work-directory** gebruiken 
    mav je kan **cd** naar deze directory doen.  
    Let wel dat je ook **read-permissions** nodig hebt.

#### Interpreteren van een permissieniveau

Per permissieniveau wordt er voor elk recht aangeduid of het van toepassing of niet.  

* Elke recht heeft zijn eigen afkorting 
  * r voor read
  * w voor write
  * x voor execute
* Deze worden altijd in een specifieke volgorde getoond
  * eerst read, dan write en als laatste execute
* Als het recht niet is toegekend wordt er een **-** in de plaats gezet


Dus bijvoorbeeld:

* rwx betekent 
  * dat je het bestand kan lezen, schrijven en uitvoeren
* rw- betekent 
  * dat je het bestand kan lezen, schrijven 
  * maar niet kan uitvoeren


~~~
   user --+  group --+  others --+
          |          |           |
         rwx        r-x         r--
~~~


### Permissies in actie

Als we voorgaande regels bij elkaar plaatsen kunnen we gaan bekijken:

* Wie oftewel welke ingelogde user?
* Wat kan uitvoeren?
* Op welke file?

#### Permissies en Ownership van files

Het commando **"ls -l"** (zoals eerder gezien) geeft ons meer **gedetailleerde** informatie over een file:

~~~
student@studentdeb:~$ ls -l test.txt 
-rwxr--r-- 1 student students 192 Oct 27 14:33 test.txt
~~~

De **informatie** kunnen we als volgt interpreteren:

* Daarna volgen 3 blokken waar permissies zijn toegekend per soort gebruiker
  * **rwx** dat aangeeft welke rechten de user heeft op deze file  
    (**r**ead - **w**rite - e**x**ecute)
  * **r-x** die aangeeft welke rechten **members** van de **groep** (gelinkt aan deze file) hebben  
    (**r**ead - e**x**ecute)
  * **r--** die aangeeft welke rechten **members** van de **groep** (gelinkt aan deze file) hebben  
    (**r**ead)
  * (**-** betekent dat het recht niet toegekend is)
* Daar volgend de user en groep waar deze file toe behoort
  * User student
  * Group students

Samengevat betekent dit dat deze file (test.txt) **eigendom** is van de user **student** en de group **students**.  

* **Iedereen** heeft het recht deze **file** te **lezen**
* Enkel de **user** **student** zelf of **users** die tot de groep **students** behoren hebben het **recht** deze **uit te voeren**
* Enkel de **gebruiker** student kan deze file bewerken

#### Permissies en Ownership bekijken met "ls -ld" (voor directories)

**Ook** voor **directories** kan je dit **nakijken**, maar als je die met "ls -l" doet zie je enkel
de rechten op de subfolders of files:

~~~
student@studentdeb:~$ ls -l /home
total 16
drwxr-xr-x 14 bart    bart    4096 Oct 13 16:09 bart
drwxr-xr-x  2 joske   joske   4096 Oct 27 19:32 joske
drwxr-xr-x  2 joske2  test    4096 Oct 27 19:35 joske2
drwxr-xr-x 21 student student 4096 Nov 24 10:35 student
~~~

Als je dit echter wilt nakijken op de directory zelf gebruik je de d-optie met **ls -ld**

~~~
student@studentdeb:~$ ls -ld /home
drwxr-xr-x 5 root root 4096 Oct 27 12:21 /home
~~~

Hier zie je dan de **rechten** en andere info op de **directory zelf**.

### Wijzigen van permissies met chmod

Met het commando **chmod** kan je deze rechten toevoegen of afnemen...  
Je kan dit commando op 2 manieren toepassen:

* Met symbolen
* Met getallen

#### Met symbolen

~~~
chmod {Wie}{Wat}{Welk} {file|directory}
~~~

* **Wie**? Target...
  * **u** => user/owner van deze file
  * **g** => group waar deze file toe behoort
  * **o** => others, iedereen verschillend van
  * **a** of **ugo** => all, iedereen
* **Wat**?  Toegepast op wie/target
  * **+** => add => Voeg een permissie toe (voor het target hierboven)
  * **-** => remove => Neem een permissie af
  * **=** => set exactly => Zet deze permissie exact (andere permissies worden afgenomen)
* **Welke** permissies?
  * **r** => read of leesrecht
  * **w** => write of schrijfrecht
  * **x** => execute oftewel recht om uit te voeren als een programma

In onderstaand **voorbeeld** maken we **2 files** aan:

* Bij **file1** nemen we **rw**-rechten **af** voor de **groep** en **andere** gebruikers
* Bij **file2** kennen we **recht** van **uitvoering** aan **iedereen**  
  (je kan **ook** **ugo** gebruiken ipv **a** in dit geval)

~~~
student@studentdeb:~$ rm file*
student@studentdeb:~$ touch file1
student@studentdeb:~$ touch file2
student@studentdeb:~$ ls -l file*
-rw-r--r-- 1 student student 0 Nov 24 12:14 file1
-rw-r--r-- 1 student student 0 Nov 24 12:14 file2
student@studentdeb:~$ chmod go-rw file1
student@studentdeb:~$ chmod a+x file2
student@studentdeb:~$ ls -l file*
-rw------- 1 student student 0 Nov 24 12:14 file1
-rwxr-xr-x 1 student student 0 Nov 24 12:14 file2
~~~

* Bij file2 zetten we vervolgens een exacte permissie  
  Je ziet dat de (vorige) toegekende rechten zijn overschreven...

~~~
student@studentdeb:~$ chmod a=rw file2
student@studentdeb:~$ ls -l file2
-rw-rw-rw- 1 student student 0 Nov 24 12:14 file2
~~~

#### Met getallen

Een 2de manier is het werken met getallen om deze rechten toe te kennen of af te nemen.  

Hou er wel rekening dat deze manier gelimiteerd is tot het exact toekennen, equivalent tot de =-optie 
in de symbool-notatie.  
Het is echter wel belangrijk deze manier te kennen omdat je binnen sommige (embedded) omgevingen misschien enkel deze getallen-methode beschikbaar is.

Het **basis-principe** is dat elke permissie een getalwaarde wordt toegekend:

* **r** = **4**
* **w** = **2**
* **x** = **1**

Per userlevel (zie **u**ser-**g**roup-**o**thers) ga je telkens de som maken van deze 3 permissies:

1. Je start met 0.
2. Heb je read-rechten nodig tel je 4 hier aan toe.
3. Heb je schrijfrechten nodig, tel je er 2 bij.
4. Heb je execute-nodig, dan tel er 1 bij.

Bijvoorbeeld:

* 7 (4 + 2 + 1) zal overéén komen met rwx
* 6 (4 + 2) met lees en schrijfrechten
* 5 (4 + 1) met lees en uitvoerrechten
* 4 (4) met enkel lees rechten
* ...

In totaal combineer je 3 cijfers met elkaar tot 1 getal (in volgorde van links naar rechts):

* 1ste getal voor de user-rechten
* 2de getal voor de group-rechten
* 3de getal voor de rechten toegekend aan others/others

Bijvoorbeeld het equivalent van "rwxr-xr--" is "754"

~~~
rwx = 4 + 2 + 1 = 7
r-x = 4 + 0 + 1 = 5 
r-- = 4 + 0 + 0 = 4
~~~

We passen dit toe als volgt...

~~~
student@studentdeb:~$ chmod 754 file1
student@studentdeb:~$ ls -l file1
-rwxr-xr-- 1 student student 0 Nov 24 12:14 file1
~~~

... en zien dat deze permissies worden aangepast als beschreven

##### Mode bits (extra info)

Men verwijst dit soms ook ald de "mode bits".  
In de achter grond wordt dit in een getal bijgehouden met 3 octets volgens onderstaande mapping:

~~~
  r    w    x 
  4    2    1
2^2  2^1  2^0  
~~~

754 is bij deze eigenlijk een octale getal dat decimaal 492 is.  
Stel bijvoorbeeld "rwxr-xr--" of "754" naar een binair getal omgerekend wordt dit 111 101 100

~~~
  222 222 222
  ^^^ ^^^ ^^^
  210 210 210
  =
  421 421 421 
* 111 101 100 = 492 (decimaal)
  -----------
  421 401 400
  7   5   4   = 754 (octaal)     
~~~

### Wijzigen van "ownership" met chown (en chgrp)

We kunnen ondertussen de permissies aanpassen, nu moeten we nog leren van de owners te wijzigen van files en directories...

Om te starten maken - met de user student - 1 directory en 2 files als volgt:

~~~
student@studentdeb:~$ rm -rf test*
student@studentdeb:~$ touch test_file
student@studentdeb:~$ mkdir test_dir
student@studentdeb:~$ touch ./test_dir/test_file
~~~

De files en directories die worden aangemaakt krijgen automatisch de user student en de bijhorende primaire group student toegekend:

~~~
student@studentdeb:~$ ls -ld test_*
drwxr-xr-x 2 student student 4096 Nov 24 13:59 test_dir
-rw-r--r-- 1 student student    0 Nov 24 13:59 test_file
student@studentdeb:~$ ls -l ./test_dir/
total 0
-rw-r--r-- 1 student student 0 Nov 24 14:05 test_file
student@studentdeb:~$ 
~~~

#### Owner file en directory wijzigen

Om de **eigenaar** van een **file** te **wijzigen** gebruiken we het commando chown.  
Je kan met dit commando zowel de user ald de group waartoe een file/directory behoort wijzigen

~~~
student@studentdeb:~$ chown bart test_file 
chown: changing ownership of 'test_file': Operation not permitted
~~~

...moet je jezelf als super-user inloggen want je kan niet zomaar een file toekennen aan een andere gebruiker

~~~
student@studentdeb:~$ su -
Password: 
root@studentdeb:~# cd /home/student/
~~~

Vervolgens **passen** de **gebruiker** **aan** van testfile met het commando **chmod**, gevolgd door de **nieuwe owner** en de file die je wil wijzigen:

~~~
root@studentdeb:/home/student# chown bart test_file
root@studentdeb:/home/student# ls -ld test_*
drwxr-xr-x 2 student student 4096 Nov 24 13:59 test_dir
-rw-r--r-- 1 bart    student    0 Nov 24 13:59 test_file
~~~

#### Owner directory

Hetzelfde mechanisme geldt voor een directory...

~~~
root@studentdeb:/home/student# chown bart test_dir
~~~

...Wel  zie je dat enkel de directory zelf is gewijzigd

~~~
root@studentdeb:/home/student# ls -ld test_dir
drwxr-xr-x 2 bart student 4096 Nov 24 14:05 test_dir
root@studentdeb:/home/student# ls -l test_dir
total 0
-rw-r--r-- 1 student student 0 Nov 24 14:05 test_file
root@studentdeb:/home/student# 
~~~

#### Owner directory recursief wijzigen

Als je wilt dat alle onderliggende files gewijzigd worden gebruik je de optie **-R**

~~~
root@studentdeb:/home/student# chown -R bart test_dir
root@studentdeb:/home/student# ls -ld test_dir
drwxr-xr-x 2 bart student 4096 Nov 24 14:05 test_dir
root@studentdeb:/home/student# ls -l test_dir
total 0
-rw-r--r-- 1 bart student 0 Nov 24 14:05 test_file
~~~

Als je de groep (ipv de user) van een file of directory wil wijzigen gebruik je
dezelfde vorm maar plaats je een dubbel punt voor de groepsnaam.

~~~
root@studentdeb:/home/student# chown :bart test_dir
root@studentdeb:/home/student# ls -ld test_dir
drwxr-xr-x 2 bart bart 4096 Nov 24 14:05 test_dir
root@studentdeb:/home/student# ls -l test_dir
total 0
-rw-r--r-- 1 bart student 0 Nov 24 14:05 test_file
~~~


#### Commando chgrp

Je kan wel hetzelfde doen met het **chgrp**-command

~~~
root@studentdeb:/home/student# chgrp bart test_dir
...
~~~

#### Tegelijk user en group wijzigen

Tenslotte zetten we test_dir terug naar de oorspronkelijke user en group.  
Je kan dit in éénmaal doen door de user en group te combineren met een dubbel punt 
(user:group)

~~~
root@studentdeb:/home/student# chown -R student:student test_dir
root@studentdeb:/home/student# ls -ld test_dir
drwxr-xr-x 2 student student 4096 Nov 24 14:05 test_dir
root@studentdeb:/home/student# ls -l test_dir
total 0
-rw-r--r-- 1 student student 0 Nov 24 14:05 test_file
root@studentdeb:/home/student# 
~~~

### Special permissies (u+s, g+s, o+t)

We hadden eerder al 3 types van permissies gezien:

* **r** => read of leesrecht
* **w** => write of schrijfrecht
* **x** => execute oftewel recht om uit te voeren als een programma

Naast deze hebben we 3 andere mogelijkheden: suid, sgid, sticky bit

#### suid

Afkorting van  **"Set owner User ID up on execution"**.  
Dit houdt in dat als je een file uitvoert, alle acties (zoals bijvoorbeeld files creeren) worden uitgevoerd als de owner (niet de gebruiker die het script uitvoert op dat moment)

Dit is enkel van toepassing op **files**, **niet** op **directories**...  
Om dit toe te kennen aan een file pas je "chmod u+s" toe op een file:

~~~
TODO: example
~~~

Een voorbeeld van gebruik is passwd dat als user root en wordt uitgevoerd als root (ondanks dat je het als je eigen user uitvoert)

~~~
student@studentdeb:~$ ls -l /usr/bin/passwd
-rwsr-xr-x. 1 root root 35504 Nov 16 2021 /usr/bin/passwd
~~~

#### sgid

Afkorting van **"Set Group ID up on execution"**.  
Dit is van toepassing op zowel files en directories met een licht andere betekenis:

* Voor een **file** dat je het bestand uitvoert met de group die toegekend is aan de file
* Voor een **directory** dat files die binnen deze directory automatisch de groep van deze directory toegekend krijgen (en niet deze van de gebruiker die een file toevoegt)


Om dit toe te kennen aan een file pas je **"chmod g+s"** toe op een file of directory:

~~~
student@studentdeb:~$ ls -ld testa
drwxr-xr-x 2 student student 4096 Nov 24 19:18 testa
student@studentdeb:~$ chmod a+rwx testa/
student@studentdeb:~$ ls -ld testa/
drwxrwxrwx 2 student student 4096 Nov 24 19:18 testa/
student@studentdeb:~$ chmod g+s testa
student@studentdeb:~$ ls -ld testa/
drwxrwsrwx 2 student student 4096 Nov 24 19:21 testa/
~~~


~~~
student@studentdeb:~$ ls -ld testa/
drwxrwsrwx 2 student student 4096 Nov 24 19:18 testa/
~~~

~~~
student@studentdeb:~$ su - bart
Password: 
bart@studentdeb:~$ cd ../student/testa/
bart@studentdeb:/home/student/testa$ ls
bart@studentdeb:/home/student/testa$ touch aa
bart@studentdeb:/home/student/testa$ ls -l
total 0
-rw-r--r-- 1 bart student 0 Nov 24 19:21 aa
bart@studentdeb:/home/student/testa$ 
~~~

#### sticky bit

Houdt in dat je enkel files kan verwijderen uit een **directory**, niet van toepassing op een file.

Om dit toe te kennen aan een file pas je "chmod o+t" toe op een directory:

~~~
TODO: example
~~~

#### Numeriek representatie

Deze **speciale permissies** hebben net zoals de andere permissies een numerieke 

* **1** voor **sticky bit**
* **2** voor de **sgid**-bit
* **4** voor de **suid**-bit

Bijvoorbeeld 6775 zal zowel de sgid en suid-bit zetten (6 = 4 + 2) naast de bijhorende standaard permissies

#### s vs S

Er als je **suid** (op user) of **sgid** (op groep) configureert zie in de output van ls
een **s** verschijnen zoals hieronder

~~~
student@studentdeb:~$ ls -ld derde/
drwxrwxrwx 2 student student 4096 Nov 24 19:48 derde/
student@studentdeb:~$ chmod g+s derde/
student@studentdeb:~$ ls -ld derde
drwxrwsrwx 2 student student 4096 Nov 24 19:48 derde
~~~

Een kleine **s** duidt aan dat zowel deze speciale bit (suid of guid) is gezet maar ook dat de 
**x**-permissie is aangeduid.  

Als je echter de directory configureert **zonder execute** dan maar wel met de **suid** of **guid** zie
je een grote **S** ipv een kleine **s** verschijnen.

~~~
student@studentdeb:~$ chmod g-s derde/
student@studentdeb:~$ ls -ld derde
drwxrwxrwx 2 student student 4096 Nov 24 19:48 derde
student@studentdeb:~$ chmod g-x derde/
student@studentdeb:~$ ls -ld derde
drwxrw-rwx 2 student student 4096 Nov 24 19:48 derde
student@studentdeb:~$ chmod g+s derde/
student@studentdeb:~$ ls -ld derde
drwxrwSrwx 2 student student 4096 Nov 24 19:48 derde
student@studentdeb:~$ ls -ld derde
drwxrwsrwx 2 student student 4096 Nov 24 19:48 derde
~~~

### Default permissies en het umask

#### Default permissies

Op de linux-systemen worden **"by default"** zijn de volgende **permissies** toegekend:

* Voor files **0666** of **rw-rw-rw**
* Voor directries **0777** of **rwxrwxrwx**

#### Default persmissies in praktijk echter...

Als voorbeeld maken we met onze user een lege file en directory aan...  
We bekijken de permissies van deze nieuwe file en directory...

~~~
student@studentdeb:~$ ls -ld hello*
drwxr-xr-x 2 student student 4096 Nov 24 15:57 hello_dir
-rw-r--r-- 1 student student    0 Nov 24 15:57 hello.txt
~~~

...en zien:

* **rwxr-xr-x** of **0755** voor een **directory**
* **rw-r--r--** of **0644** voor een **file**

Hoe komt dat deze permissies niet 666 en 777 zijn?

#### umask

Dit komt door de **umask** dit is, een waarde die wordt ingeladen **per shell-sessie** en er voor zorgt dat deze waarde wordt aangepast...

Deze waarde kan je opvragen via het **commando umask**:

~~~
student@studentdeb:~$ umask
0022
student@studentdeb:~$ 
~~~

Deze waarde is **0022** en stelt een **octale** **waarde** voor en wordt **toegepast** op de **permissies**.  

In eerder voorbeeld zien we dat:

* **0777** en **0022** gecombineerd wortd **0755** voor de **directory**
* **0666** en **0022** gecombineerd wordt **0644** voor een **file**

De feitelijke permissies worden meebepaald door deze umask-waarde

~~~
student@studentdeb:~$ umask
0022
student@studentdeb:~$ ls -ld hello*
drwxr-xr-x 2 student student 4096 Nov 24 15:57 hello_dir
-rw-r--r-- 1 student student    0 Nov 24 15:57 hello.txt
~~~

#### umask-mechanisme (modbit-niveau)

Je zou - adhv het vorige voorbeeld - kunnen denken dat het toepassen dat
deze **umask** gewoon gebeurt door deze **umask-waarde** **af te trekken** van de 
**default permissies**.  

Is dit zo?  
Als we van de **assumptie** zouden uitgaan dan je **023** van **666** zou aftrekken dan kom je op **643** moeten uitkomen.  

Laten we de **proef op de som** nemen, je **kan** namelijk via het **umask**-commando deze **waarde wijzigen**, dit geldt wel enkel voor je bash-sessie... (als je een nieuwe sessie start wordt deze terug naar de geconfigureerde systeem-waarde gezet).  
Stel nu we wijzigen **022** naar **023**

~~~
student@studentdeb:~$ umask
0002
student@studentdeb:~$ umask 0023
student@studentdeb:~$ umask
0023
~~~

Vervolgens maken we een **nieuwe file** aan (via touch) en **bekijken** we de **permissies**.

~~~
student@studentdeb:~$ touch umasktest
student@studentdeb:~$ ls -l umasktest 
-rw-r--r-- 1 student student 0 Mar 20 21:10 umasktest
student@studentdeb:~$ 
~~~

Wat maken we hier uit op?  
We zien dat de modbits **niet 623** (rw-r---wx) zijn maar **644** (rw-r--r--) zijn.  

Hebben we hier **verkeerd** **geteld**?  
**Neen**, de eigenlijke bewerking is **geen verschil** van de **permissies** en de **umask**-waarde.

Je moet dit het **umask** **eerder** bekijken als een **soort van masker** bekijken met de volgende regels:

* Elke **modbit** (rwx) van de **originale** **permissie** wordt **vergeleken** met dezelfde **modbit** (po(rwx) binnen de **umask**
* Is de **overeenkomstige** **modbit** binnen de **umask** **0** **behouden** we de originele **modbit** in de **permissie**
* Staat deze echter modbit op **1** wordt deze bitmask automatisch **geforceerd** op **0** geplaatst

Zie voor de toepassing naar onderstaande vergelijking:

~~~
       GETALLEN    
       rwx rwx rwx
666 => 420 420 420
023 => 000 020 021
       -----x---x-
644 <= 420 400 400
~~~

De waarde is nu 644 ipv 643 omdat modbits die echter al op 0 stonden (zoals de x-modbit voor others) 0 blijven.  
Als gevolg zal 023 en 022 geen verschil uit maken voor files gezien de x-bit automatisch reeds uit staat.

Op niveau van bit-operaties (boolean algebra) wordt er een &-operatie uitgevoerd gecombineerd met een inversie...

~~~
       GETALLEN       BITS
       rwx rwx rwx    rwx rwx rwx
666 => 420 420 420 => 110 110 110
023 => 000 020 021 => 111 101 100 (~000 000 010)
       -----x---x-  & -----------
644 <= 420 400 400 <= 110 100 100
~~~

In code (c-code bijvoorbeeld) zou je dit als volgt kunnen uitdrukken:

~~~c
default_permissie = 666;
umask = 023;
permissie = default_permissie & ~(umask);
~~~

### Oefening

#### Opgave

In deze oefening maak je een map aan die gebruikers binnen dezelfde groep kunnen gebruiken 
om bestanden te delen een waarop de hele groep toegang toe heeft.  

De **setup**:

* **4 gebruikers**
  * **hilde, marie, jan, joris**
  * **password** is dezelfde als hun **naam**
* Een group noem je **operators**
  * De **4** voorgaande **gebruikers** behoren tot deze **group**
* Een directory /home/operators
  * Enkel **root** en **members** van de **operator-group** kunnen **lezen, creëren en verwijderen** van files binnen deze folder
  * Files die je aanmaakt binnen deze folder worden **automatisch toegekend** aan de **groep operators**
  * Let wel, elke **gebruiker** mag **enkel files verwijderen** die **zij/hij heeft aangemaakt**

Gebruik in je commando's de numerieke variant.

* **Bewaar** al de commando's die je hiervoor gebruikte (in volgorde) in een in een **script** (**make_operators.sh**)
* **Demonstreer** deze permissies in de **shell** en copy-paste deze bash-sessie in een aparte text-file (permissions.txt)

Bonus-vraag:

* Maak een **script** dat deze **directory, groepen en gebruikers** opkuist (verwijdert) uit het systeem.

#### Oplossing

Voor het **alleereerste** **deel** kon je bijna alle **commando's** in een **script** plaatsen.  
Met **uitzondering** van het initialiseren van het **password**, hier moet je dit interactief doen
(er bestaan manieren om dit ook binnen het script te doen maar dat is buiten het bestek van deze cursus)

##### Script

~~~bash
#!/bin/bash

# Create users and groups
useradd -c "Hilde" -m -s /bin/bash hilde
useradd -c "Marie" -m -s /bin/bash marie
useradd -c "Jan" -m -s /bin/bash jan
useradd -c "Joris" -m -s /bin/bash joris
groupadd operators

# Add users to groups
usermod -aG operators hilde
usermod -aG operators marie
usermod -aG operators jan
usermod -aG operators joris
mkdir /home/operators

# Set root as owner and operators as group
chown root:operators /home/operators

# Only users and groups are allowed to access the files inside
chmod a-rwx /home/operators
chmod g=rwsx /home/operators
chmod u=rwx /home/operators

# Set sticky bit on folder in order to avoid deletions by other users
chmod +t /home/operators
~~~

##### Clean up

Je kan volgend script gebruiken om alle gebruikers, groepen en folders te verwijderen

~~~bash
# Delete the users
userdel -r -f joris
userdel -r -f jan
userdel -r -f marie
userdel -r -f hilde

# Delete the operators-group
groupdel operators

# Delete the operators-directory
rm -rf /home/operators
~~~
