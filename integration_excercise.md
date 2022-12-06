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

