## Integratie-oefening

### Opgave

#### Deel 1: script aanmaken

Maak een **script** dat een **folder** aanmaakt op basis van de datum vandaag.  
Als voorbeeld, stel dat het vandaag **22 December 2021** is dan moet deze folder **20211222** noemen.  

Geef dit script de naam **create_daily_folder.sh**.  
Als je dit script uitvoert zal het zich als volgt gedragen:

~~~
student@studentdeb:~$ date
Wed 22 Dec 2021 01:35:48 PM CET
student@studentdeb:~$ ./create_daily_folder.sh
Creating folder /home/student/202112
student@studentdeb:~$ ls -ld 20211222
drwxr-xr-x 2 student student 4096 Dec 22 13:36 20211222
student@studentdeb:~$
~~~

2 hingt (zie ook help-paragrafen hieronder), om de folder aan te maken maak gebruik van **2 tools binnen Bash**

* Het commando date
* Het principe van "command substution"

##### Help: date-commmando

Het date-commando wordt in Bash gebruikt om de exacte tijdstip op te vragen zoals hieronder geillustreerd

~~~
student@studentdeb:~$ date
Wed 22 Dec 2021 01:51:04 PM CET
~~~

Om een **datum** via een **exact formaat** te printen kan je als argument het formaat zetten voorafgegaan door een +
zoals hieronder vertoond.  

~~~
student@studentdeb:~$ date +%y
21
student@studentdeb:~$
~~~

Aan jou om te bekijken hoe je dit formaat moet vormen

> Tip: Om dit formaat te creeren kijk naar de man-pagina van date  
> (probeer google te vermijden voor de oefening)


##### Help: command-substitution

Om het date-commando te combineren met het commando om een directory aan te maken
gebruik we **command substitution**

~~~
student@studentdeb:~$ hostname -s
studentdeb
student@studentdeb:~$ touch $(hostname -s)_filtest
student@studentdeb:~$ ls *filetest
student@studentdeb:~$ touch $(hostname -s)_filetest
student@studentdeb:~$ ls *filetest
bvlegion_filetest
student@studentdeb:~$ 
~~~

#### Deel 2: folder bestaat al...

Het script **print** ook nog een **boodschap** af dat de folder reeds is aangemaakt.  

~~~
student@studentdeb:~$ ls -ld 20211222
drwxr-xr-x 2 student student 4096 Dec 22 13:36 20211222
student@studentdeb:~$ ./create_daily_folder.sh
Folder /home/student/202112 exists already
~~~

Maak deze folder alleen aan als deze nog niet bestaat en print bovenstaande errorboodschap af.  
Zorg ook dat in dat geval een exit code 2 wordt gebruik zodat je dit kan afleiden:

~~~
student@studentdeb:~$ ./create_daily_folder.sh
Folder /home/student/202112 exists already
echo $?
2
~~~

##### Help: nakijken of file/folder bestaat

Je hebt de volgende opties ter beschikking om na te kijken of files te bekijken (zien hoofdstuk files)

~~~
-e FILE => FILE bestaat.
-d FILE => FILE bestaat en is een directory.
-r FILE => FILE bestaat en de read-permissie is toegekend.
-s FILE => FILE bestaat en is niet leeg.
-w FILE => FILE bestaat en je mag er naar schrijven.
-x FILE => FILE bestaat en heeft execute-permissies.
~~~

Het volgende voorbeeld kijkt na of het argument een file is:

~~~bash
#!/bin/bash
if [ $# -eq 0 ]; then
        echo Er zijn geen argumenten.
else
        echo Er zijn $# argumenten.
        if [ -e $1 ]; then
                echo Het bestand $1 bestaat.
        else
                echo Het bestand $1 bestaat niet.
        fi
fi
~~~

Let wel je moet ook nakijken of het een directory is.

Optioneel oefening: als al bestaat kijk na of je deze folder kan aanpassen en als workdirectory kan gebruiken

### Deel 3: geef een folder mee als argument

Het script maakt **zonder argument** een folder aanmaakt binnen de folder vanwaar je het script uitvoert.  
Zorg er nu voor dat het script deze folder aanmaakt binnen een andere folder als je een extra argument meegeeft.

~~~
student@studentdeb:~$ ./create_daily_folder.sh /home/student/Tmp
Creating folder /home/student/Tmp/20211222
student@studentdeb:~$ ls -ld /home/student/Tmp/20211222
drwxr-xr-x 2 student student 4096 Dec 22 13:36 20211222
~~~

Geef wel een foutboodschap mee indien de basisfolder niet bestaat

~~~
student@studentdeb:~$ ./create_daily_folder.sh /home/student/Blabla
Cannot create af folder /home/student/Blabla/20211222 because /home/student/Blabla doesn't exist
~~~

#### Deel 4: schrijf alles weg in een logfile

Schrijf de boodschappen die je tot nog toe hebt gemaakt weg naar een file create_daily_folder.log.  
Deze file bevindt zich in de basis-folder waar je de datum folders aanmaakt.

#### Deel 5: plan dit dagelijks met een crontab

Roep dit **script** op **dagelijkse basis** aan via een crontab (dagelijks om 18.05).  
Schrijf dit weg naar de folder /home/student/shared/ (via het argument)

#### Deel 6: groepen, users

* Maak een groep shared aan
* Zorg dat bovenstaand folder eigendom is van deze groep
* Enkel members van deze groep hebben access tot deze folder
* De subfolders die worden aangemaakt behoren automatisch tot deze groep

### Oplossing/step-by-step

#### Script aanmaken (deel 1 tem 4)


##### Aanmaken van het script

Om te starten en het script aan te maken waren de volgende stappen aan te raden:

* Een **specifieke** **directory** aanmaken (om het overzichtelijk te houden)
* De file aanmaken met **nano**

~~~
student@studentdeb:~$ mkdir integration_excercise
student@studentdeb:~$ cd integration_excercise/
student@studentdeb:~/integration_excercise$ nano create_daily_folder.sh
~~~

* Vervolgens mocht je niet vergeten de **permissies** goed te zetten

~~~
student@studentdeb:~/integration_excercise$ chmod u+x create_daily_folder.sh 
~~~

##### Resultaat

Het uiteindelijke **script** ziet er als volgt uit:

~~~bash
#!/bin/bash

current_day=$(date +%Y%m%d)
logfile=create_daily_folder.log

if [ $# -eq 1 ]; then
        base_path=$1
        if [ ! -d $base_path ]; then
                echo "Argument $base_path doesn't exists"
                exit 3
        fi
else
        base_path=$(pwd)
fi

today="$base_path/$(date +%Y%m%d)"

if [ -d $today ]; then
        message="$today exists already"
        echo $message
        echo $message >> $base_path/$logfile
        exit 2
else
        message="Creating folder $today"
        echo $message
        echo $message >> $base_path/$logfile
        mkdir $today
fi
~~~

##### Belangrijkste kenmerken van het script

Let op volgende **kenmerken** in de bovenstaande oplossing:

* Script-argumenten:
  * De folder kan je doorgeven als argument **``$0``**
  * Om te weten dat er een argument was kon je testen op **``$#``** (aantal argumenten)
  * Als het argument leeg was gebruikte je **pwd** om de **huidige work-directory** te gebruiken
* De huidige dag wordt in een variabele geplaatst via **command-substitution**  
  Dit doe je door een **commando** in **binnen** **``$(...)``** te plaatsen.  
  Hiermee kan je de **waarde** van dit **commando** opvangen in een **variabele**
* We maken gebruik van **variable-substitution** binnen een string door deze  te prependen met **``$``** of te plaatsen tussen **``${..}``**
* Er wordt gebruik **gemaakt** van het command **date**.  
  In de man-pagina (man date) kan je alle informatie terugvinden.  
  Tip: **man** maakt gebruik van **less** als **pager** (je kan dus opzoeken met ``/``-symbool)
* Er wordt gebruikt gemaakt van **redirection** (>>) om de output van echo weg te schrijven
  naar een file.  (let wel **``>``** zal de **file overschrijven**)
* Het exit **commando** wordt gebruikt om het **process** (uitvoering script) te **beëindigen** met een
  specifieke **error-code**
* We kunnen het bestaan van een directory testen via een **if**-statement gecombineerd met de "**-d**"-optie  
  Als je hier meer wil over weten kan je "**man test**" consulteren

##### date-commando

Kleine **tip**, **voordat** je het **script** schreef kon je al het **één** en het ander uitproberen op de **command-line**...  
Bijvoorbeeld hieronder een **demonstratie** van het **testen** met **date** en het uiteindelijk **gebruik** van **command-substitution**

~~~
student@studentdeb:~$ date +%Y
2022
student@studentdeb:~$ date +%Y%M
202231
student@studentdeb:~$ date +%Y%M
202231
student@studentdeb:~$ date +%Y%m
202201
student@studentdeb:~$ date +%Y%m%d
20220124
student@studentdeb:~$ today=$(date +%Y%m%d)
student@studentdeb:~$ echo $today
20220124
~~~

##### Testen van script

Een voorbeeld van het uittesten van het script:

~~~
student@studentdeb:~/integration_excercise$ ./create_daily_folder.sh /home/student/Documents
Creating folder /home/student/Documents/20220124
student@studentdeb:~/integration_excercise$ ./create_daily_folder.sh /home/student/Documents
/home/student/Documents/20220124 exists already
student@studentdeb:~/integration_excercise$ echo $?
2
student@studentdeb:~/integration_excercise$ cat /home/student/Documents/create_daily_folder.log 
Creating folder /home/student/Documents/20220124
/home/student/Documents/20220124 exists already
student@studentdeb:~/integration_excercise$ 
student@studentdeb:~$ cat shared/create_daily_folder.log 
Creating folder /home/student/shared/20220124
/home/student/shared/20220124 exists already
/home/student/shared/20220124 exists already
~~~


#### Crontab aanmaken (deel 5)

Gebruik het volgende **commando** om de **crontab** te **bewerken**

~~~
$ crontab -e
~~~

De volgende **crontab** zal elke dag om **18.05** het **script** aanroepen

~~~
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

# * * * * * /home/student/backup.sh /home/student/blabla
15 18 * * * /home/student/integration_excercise/create_daily_folder.sh /home/student/shared
~~~

#### Users en rechten (deel 6)

* **Groep** aanmaken en **users** toevoegen:

~~~
root@studentdeb:~# groupadd shared
root@studentdeb:~# usermod -aG shared student
root@studentdeb:~# usermod -aG shared bart
~~~

* **Groep** wijzigen van de **shared**-folder

~~~
root@studentdeb:~# chgrp shared /home/student/shared
root@studentdeb:~# ls -ld /home/student/shared
drwxrwxr-- 3 student shared 4096 Jan 24 21:45 /home/student/shared
~~~

* Enkel **group** (en user) **toegang** geven

~~~
root@studentdeb:~# chmod ug=rwx /home/student/shared
root@studentdeb:~# chmod o-rwx /home/student/shared
root@studentdeb:~# ls -ld /home/student/shared
drwxrwx--- 3 student shared 4096 Jan 24 21:45 /home/student/shared
~~~

* De **gsid** toekennen (zodat sub-files en -folders automatisch de groep als eigenaar krijgen)

~~~
root@studentdeb:~# chmod g+s /home/student/shared
root@studentdeb:~# ls -ld /home/student/shared
drwxrws--- 2 student shared 4096 Jan 24 22:40 /home/student/shared
root@studentdeb:~# 
~~~

* De **folder** en **log** die door cron wordt aangemaakt krijgen **automatisch** de **shared-group** toegekend

~~~
student@studentdeb:~$ ls -l shared
total 8
drwxr-sr-x 2 student shared 4096 Jan 24 23:15 20220124
-rw-r--r-- 1 student shared  992 Jan 24 23:15 create_daily_folder.log
~~~