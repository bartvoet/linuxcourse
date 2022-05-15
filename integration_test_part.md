## Proeftest

Los al je vragen op binnen deze text-file en upload deze naar Toledo.  

### Basisgedeelte

#### Users en access

Maak 2 users **gwen** en **mark** aan op je linux-systeem.  
Voeg beide users aan de groep lectoren toe.

Maak een directory /home/lectoren/leerstof aan en een directory /home/lectoren/examens resultaten.  
Zorg ervoor dat niemand deze directory kan deleten.

Zorg ervoor dat enkel gwen en mark files kunnen toevoegen beide subdirectories /home/lectoren/leerstof en directory /home/lectoren/examens
Alle gebruikers op het systeem hebben toegang tot /home/lectoren/leerstof.

Buiten mark en gwen kan er niemand de directory /home/lectoren/examens gebruiken (enkel gwen en mark)

Extra: Zorg er ook voor dat mark en gwen elkaars files niet kunnen deleten.

Antwoord (tussen de tildes):

~~~bash

~~~

#### Vraag => modbits

Welke permissies stellen volgende **modbits** voor **631**?   
Leg (heel beknopt) uit.  
Converteer ook naar de symbool-versie (die je verkrijgt met ls -l)

Antwoord (schrijf je antwoord tussen de tildes):

~~~

~~~

#### Script toegankelijk maken?

Ik voer volgend commando uit

~~~
$ echo "Hello World" > ~/hello.sh
~~~

Waar komt dit script terecht?  
Welke 2 extra commando's dien ik uit te voeren opdat ik het volgende kan doen vanuit eender welke directory?  

> Zowel permissies als een specifieke variabele moet gezet worden...

~~~
$ hello.sh
Hello World
$
~~~

Vul hieronder in:

~~~

~~~

#### Afdrukken

Druk de huidige directory af via een script.
Gebruik hiervoor "command-substitution":

~~~
$ ./print_current_directory
Mijn huidige directory is /home/bart/test"
~~~

#### Commmando's

Met welk commando kan vanuit eender welke locatie naar de home-directory gaan?

~~~

~~~

Gegeven een directory dossiers, hoe kan je een volledige directory met inhoud kopieren naar een nieuwe folder backup_dossiers?

~~~

~~~

Welk commando gebruik je om je huidgie working directory te zien?

~~~

~~~

Welk commando gebruik je om een lege file aan te maken


~~~

~~~

Ik wil alle files en diretories oplijsten in volgorde van tijd, de meest recente file laatst

~~~

~~~

#### crontab

Beschrijf een crontab (1 lijn) die een job /home/students/test.sh elke Woensdag om 18.25 opstart.

~~~

~~~

### Gevorderd

Dit deel is ter onderscheiding als je de rest volledig juist hebt ingevuld zal dit gebruikt worden om te jureren tussen 16/20 en 20/20 

#### Mini-scriptje

Schrijf een kort script dat een file kopieert.  
Geef beide namen mee als argument, zoals hieronder gedemonstreerd

~~~
student@studentdeb:~$ ./copy_files.sh fileone filetwo
~~~

De eerste file is de te kopieren file..  
Zorg er wel voor dat je enkel kopieert als de target-file niet bestaat, anders print je een duidelijke boodschap.


Plaats het antwoord tussen de tildes...

~~~bash

~~~

#### Vraag => wildcards

Welk commando kan je gebruiken om alle files met minimum 2 karakters binnen de huidige workdirectory op te lijsten 

Als bijvoorbeeld de files aa, bbb, cccc, ddddd zich binnen je directory bevinden moet dit commando cccc, ddddd oplijsten.  
Probeer dit uit in de console, maakt deze lege files aan en test het commando.  
Copieer de output naar deze text file

Antwoord (copieer je commando's tussen de tildes):

~~~

~~~

#### Vraag: heeft bart toegang tot de folder?

Bart maakt deel uit van de groep students, kan hij deze directory als working directory (cd /home/students/) gebruiken?  
Waarom wel of niet?  Leg heel kort uit...

~~~
$ ls -ld /home/students
drw-rwx--T 2 bart students 4096 Jan 25 20:24 /home/students/
$
~~~

Antwoord (tussen de tildes)

~~~

~~~

#### Vraag: umask?

Ik voer het commando "umask 0065" uit.  
Leg bondig uit wat het gevolg hiervan is en wat het resultaat is als ik de volgende commando's uitvoer:

~~~
$ mkdir hello
$ touch world
~~~

Leg bondig uit ik heb een umask van 065.


~~~


~~~

Bonus-vraag: ik wil graag dat deze umask-waardes telkens worden toegepast bij het inloggen?  
Hoe doe ik dit?