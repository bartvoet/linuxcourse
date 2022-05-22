## Links en aliassen

2 handige tools binnen een Linux File Systeem die je dient te begrijpen zijn links en aliassen.  
Deze zijn 2-"shortcut"-achtige mechanismes, hetéén op commando-niveua, de andere op file-niveau.

### Alias

Linux-gebruikers moeten vaak 1 commando keer op keer gebruiken.  
Zeker als die lange commando's zijn kan dit je productiviteit aantasten.

Om dit te verhelpen bestaat het concept van een alias.  
Je kan jezelf heel wat tijd besparen door aliassen te maken voor een aantal van je meest gebruikte opdrachten.  

Aliassen zijn als aangepaste shortcuts die je kan om een bestaand commando te verrijken.  


#### Aliassen bekijken

De kans is groot dat je al aliassen gebruikt op je Linux-systeem.  
Je kan alle (reeds bestaande) aliassen die in je shell-sessie geladen zijn via het commando **alias**.

~~~
[student@fedora ~]$ alias
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'
[student@fedora ~]$ 
~~~

#### Commando's overschrijven

Zoals je ziet zijn er al een deel **aliassen** geladen.  
Ook bijzonder om te zien is dat een aantal aliassen worden **overschreven**.

Een alias laat namelijk - naast het vormen van nieuwe commando's - ook toe dat bestaande commando's worden overschreven.

Zo wordt in veel systemen het ls-commando (oplijsten files en directories) overschreven om automatisch kleuren te tonen.

~~~
...
alias ls='ls --color=auto' 
...
~~~

> *Nota:*  
> Zoals een beetje verder geïllustreerd kan je die overschrijven ontwijken door je commando te prefixen met een backslash


#### Zelf aliassen aanmaken

Als je zelf een alias wil aanmaken daarentegen kan je dit door het zelfde commando te gebruiken gevolgd door de combo "naam=commando" zoals je hieronder ziet:

~~~
[student@fedora ~]$ alias lll="ls -lrt"
[student@fedora ~]$ lll
totaal 0
drwxr-xr-x. 1 student student 0 22 apr 09:01 "Video's"
drwxr-xr-x. 1 student student 0 22 apr 09:01  Sjablonen
drwxr-xr-x. 1 student student 0 22 apr 09:01  Openbaar
drwxr-xr-x. 1 student student 0 22 apr 09:01  Muziek
drwxr-xr-x. 1 student student 0 22 apr 09:01  Downloads
drwxr-xr-x. 1 student student 0 22 apr 09:01  Documenten
drwxr-xr-x. 1 student student 0 22 apr 09:01  Bureaublad
drwxr-xr-x. 1 student student 0 22 apr 09:01  Afbeeldingen
~~~

We voegden hierboven het commando lll toe dat er zal voorzorgen dat je ls-output wordt gesorteerd op tijd (in omgekeerde volgorde)

Als we dit dan testen:

~~~
[student@fedora ~]$ lll
totaal 4
drwxr-xr-x. 1 student student  0 22 apr 09:01 "Video's"
drwxr-xr-x. 1 student student  0 22 apr 09:01  Sjablonen
drwxr-xr-x. 1 student student  0 22 apr 09:01  Openbaar
drwxr-xr-x. 1 student student  0 22 apr 09:01  Muziek
drwxr-xr-x. 1 student student  0 22 apr 09:01  Downloads
drwxr-xr-x. 1 student student  0 22 apr 09:01  Documenten
drwxr-xr-x. 1 student student  0 22 apr 09:01  Bureaublad
drwxr-xr-x. 1 student student  0 22 apr 09:01  Afbeeldingen
-rw-r--r--. 1 student student 70 16 mei 18:58  enp0s3.network
[student@fedora ~]$ 
~~~

Hieronder zie je dat deze is toegevoegd aan de diverse aliassen

~~~
[student@fedora ~]$ alias
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias lll='ls -lrt'
alias ls='ls --color=auto'
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'
[student@fedora ~]$ 
~~~

#### Alias ontwijken

Vele van de aliassen zullen bestaande commando's verrijken (en overschrijven) door dezelfde naam te gebruiken.

Als je echter dat gedrag wil ontwijken (zonder de alias te verwijderen) kan een backslash hiervoor gebruiken.

Stel dat je bijvoorbeeld de volgende alias aanmaakt...

~~~
[student@fedora ~]$ echo -n test
test[student@fedora ~]$ alias echo="echo -n"
[student@fedora ~]$ echo test
test[student@fedora ~]$
~~~

... die er voor zorgt dat je echo commando zonder new-line-karakter eindigt zoals je ziet in het bovenstaande voorbeeld.  
Als je echter het originele echo-commando wil gebruiken (zonder deze alias te verwijderen) plaats je gewoon een backslash voor echo.

~~~
test[student@fedora ~]$ \echo test
test
[student@fedora ~]$ 
~~~

Het resultaat hiervan is dat het originele echo commando (met new line) wordt uitgevoerd.

#### Verwijderen van een alias

Als je een alias niet meer wil gebruiken kan je het ook verwijderen met het commando unalias.

We zien hieronder dat het alias voor echo nog altijd is bepaald

~~~
[student@fedora ~]$ alias
alias echo='echo -n'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias lll='ls -lrt'
alias ls='ls --color=auto'
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'
[student@fedora ~]$
~~~

Als je dit nu wil verwijderen (zodat het oorspronkelijke alias terug verschijnt) kan je dit via het commando echo

~~~
[student@fedora ~]$ unalias echo 
[student@fedora ~]$
~~~

Je ziet vervolgens dat het echo-alias verdwenen is

~~~
[student@fedora ~]$ alias
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias lll='ls -lrt'
alias ls='ls --color=auto'
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'
[student@fedora ~]$
~~~

Je ziet ook dat het commando zich terug standaard gedraagd

~~~
[student@fedora ~]$ echo test
test
[student@fedora ~]$ 
~~~

#### Alias persisteren (.bashrc)

Als je een alias aanmaakt binnen een bash-sessie zal deze niet opnieuw verschijnen in een nieuwe bash-sessie (laat staan na een reboot...)  
Om dit te doen die je deze toe te voegen aan het einde van de file .bashrc (waar je ook andere alias-definities zult vinden)

### .bashrc

**.bashrc** is een (Bash-) script dat **Bash** zal **uitvoeren** wanneer je Bash **interactief** gestart wordt.  
Het doel hiervan is je sessie te initialiseren met zaken zoals:

* ENVIRONMENT-variabelen initialiseren
* PATH-variabele uitbreiden
* Aliassen toevoegen
* ...

Elke home-directory binnen een Bash-gebaseerd systeem zal een .bashrc bevatten.  

* Bijvoorbeeld in een Debian-systeem

~~~bash
student@studentdeb:~$ head -20 ~/.bashrc 
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
student@studentdeb:~$ 
~~~

* Bijvoorbeeld in een Fedora

~~~bash
[student@fedora ~]$ head -20 ~/.bashrc 
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
[student@fedora ~]$ 
~~~

Zoals je zie is dit een gewoon bash-script en kan je alle soorten commando's uitvoeren.  

### Links aanmaken

Linux heeft (net zoals Windows) een concept van shortcuts.  
We noemen deze **links** en je kan het programma **ln** gebruiken om deze aan te maken.

In Linux hebben we 2 varianten soft- en hardlinks...

#### Soft links

Laten we starten bij de soft-links.  
Een **soft** (of **symbolic**) **link** kan je vergelijken met een **shortcut** zoals je deze kent uit bijvoorbeeld de shortcuts uit Windows.

We demontreren dit via:

* Het aanmaken van een Een file "hello.txt"
* Een soft-link met de naam "world.txt"

~~~
(base) bart@bvlegion:~/Tmp$ echo "test" > hello.txt
(base) bart@bvlegion:~/Tmp$ ln -s hello.txt world.txt
~~~

We gebruiken hiervoor het commando **ln** met de **optie -s** die er voor zorgt dat dit een soft-link wordt.  
Als we deze 2 files bekijken...

~~~
(base) bart@bvlegion:~/Tmp$ ls -l *txt
-rw-rw-r-- 1 bart bart 5 May 16 21:28 hello.txt
lrwxrwxrwx 1 bart bart 9 May 16 21:28 world.txt -> hello.txt
~~~

observeren we 2 kenmerken:

* Het type is **l** ipv **-**
* Via "ls -l" wordt ook aangeduid welke de **file** is **waar naar** wordt **gelinkt**

Deze symbolic kan dan gebruiken als was het de originele file

~~~
(base) bart@bvlegion:~/Tmp$ cat world.txt 
test
(base) bart@bvlegion:~/Tmp$ 
~~~

We zien wel dat het verschillend fysieke files op disk zijn:

* De ene het oorspronkelijke bestand (inode 21367519)
* De andere is een apart bestand dat metadata bevat naar waar deze file verwijst  
  (world.txt -> hello.txt)

~~~
(base) bart@bvlegion:~/Tmp$ ls -li *txt
21367519 -rw-rw-r-- 1 bart bart 5 May 16 21:28 hello.txt
21369308 lrwxrwxrwx 1 bart bart 9 May 16 21:28 world.txt -> hello.txt
(base) bart@bvlegion:~/Tmp$ 
~~~

Als je de **originele file verwijdert** zal de **soft link** **blijven** **bestaan**.  
Je krijgt vanzelfsprekend wel een foutboodschap als je deze probeert te gebruiken...


~~~
(base) bart@bvlegion:~/Tmp$ rm hello.txt
(base) bart@bvlegion:~/Tmp$ ls -li *txt
21369308 lrwxrwxrwx 1 bart bart 9 May 16 21:28 world.txt -> hello.txt
(base) bart@bvlegion:~/Tmp$ cat world.txt 
cat: world.txt: No such file or directory
(base) bart@bvlegion:~/Tmp$ 
~~~

#### inodes en links...

Vooraleer we hard links uitleggen moeten we begrijpen wat inodes zijn.  
Het was je misschien al opgevallen dat we het commando "ls -li" gebruikten ipv "ls -l"

Deze extra optie -i zal de de **inode-nummer** oplijsten van deze file binnen het **filesysteem**

inode is eigenlijk een afkorting voor index-node en is een gegevensstructuur in een Linux (en Unix) bestandssysteem dat een bestands(object) beschrijft, zoals een bestand of een map.  

Elke inode slaat de attributen en schijfbloklocaties van de gegevens van het object op.
Naast de verwijzingen waar het bestands staat opgeslagen is dit metadata zoal(tijden van laatste wijziging, owner, group, permissies, ...

~~~
(base) bart@bvlegion:~/Tmp$ ls -li *txt
21367519 -rw-rw-r-- 1 bart bart 5 May 16 21:28 hello.txt
21369308 lrwxrwxrwx 1 bart bart 9 May 16 21:28 world.txt -> hello.txt
(base) bart@bvlegion:~/Tmp$ 
~~~

Zoals je ziet heeft de softlink een andere inode-nummer vergeleken tov de oorspronkelijke file.  
De link (world.txt -> hello.txt) bevindt zich nameljk in een aparte file.

~~~
+--------------+--------------+-----+--------------+
| FILESYSTEM:  |   world.txt  |     |  hello.txt   |
+-----------------------------+     +--------------+
| INODE:       |   21367519   |     |   21369308   |
+-----------------------------+     +--------------+
               |=> /home/bart/|     |              |
               |  hello.txt   +---->+    test      |
               |              |     |              |
               +--------------+     +--------------+

~~~

Met een soft-link spreken we dus effectief over **2 verschillende files** en **locaties** op je **hard disk** (of flash) waar informatie staat opgeslagen.

De link bij een soft/symbolic wordt dan ook gemaakt in het bestand zelf niet in het file-systeem zelf...

#### Hard links

Dit is echter niet het geval voor **hard links**, een andere soort links die we bekijken.  
Om dit de duiden maken we de oorspronkelijke file hello.txt opnieuw aan

~~~
(base) bart@bvlegion:~/Tmp$ rm *txt
(base) bart@bvlegion:~/Tmp$ echo "test" > hello.txt
(base) bart@bvlegion:~/Tmp$ ln hello.txt world.txt
(base) bart@bvlegion:~/Tmp$ cat world.txt 
test
~~~

Wat we zien is dat **beide files hetzelfde inode-nummer** hebben.

~~~
(base) bart@bvlegion:~/Tmp$ ls -li *txt
21367519 -rw-rw-r-- 2 bart bart 5 May 16 21:32 hello.txt
21367519 -rw-rw-r-- 2 bart bart 5 May 16 21:32 world.txt
~~~

Bij een hardlink maak je eigenlijk 2 gelijke verwijzingen en pointers
naar éénzelfde bestand/data in heb filesysteem.

~~~
+---------------------------+-------------+
| FILESYSTEEM: | world.txt  |  hello.txt  |
+---------------------------+-------------+
| INODE:       |        21367519          |
+-----------------------------------------+
               |                          |
               |        test              |
               |                          |
               +--------------------------+
~~~

In dit geval zijn zowel world.txt als hello.txt gelijkwaardige referenties naar de zelfde inode

> Om dit te verstaan moet je begrijpen dat een file in je bestandssysteem eigenlijk zelf een referentie 
> is naar het eigenlijke bestand (een beetje zoals een pointer die naar een memory-locatie verwijst).

maw Elke file die jij in het bestandssysteem ziet is eignelijk een hard link, of je hem nu aanmaakt met het commando "ln" of via een tool zoals touch, vim, ...

Als je bijvoorbeeld de oorspronkelijk file (hello.txt) verwijderd gaat de eigenlijke inode (bestand) niet verwijderd zijn, gezien het nog verwezen wordt door world.txt door teministe 1 hard-link

~~~
(base) bart@bvlegion:~/Tmp$ rm hello.txt 
(base) bart@bvlegion:~/Tmp$ ls -li *txt
21367519 -rw-rw-r-- 1 bart bart 5 May 16 21:32 world.txt
(base) bart@bvlegion:~/Tmp$ cat world.txt 
test
(base) bart@bvlegion:~/Tmp$ 
~~~

#### Hard link vs soft/symbolic

De volgende vraag die je jezelf zou kunnen stellen wanneer je een hard link moet gebruiken en wanneer een soft-link...

Over het algemeen zijn soft-links een meer flexibel:

* Een soft-link is niet gebonden aan een filesysteem, je kan bijvoorbeeld geen hard link maken tussen 2 filesystemen (bijvoorbeeld bij een aparte disk) maar wel een soft link.  
* Een soft-link is ook gemakkelijker (of toch directer) terug te vinden gezien het expliciet fileobject is en de verwijziging uit een soft-link gemakkelij is uit te lezen.
* Je kan ook aparte metadata plaatsen op de soft-link en de oorspronkelijke file via permissies (en andere metadata) op een soft-link.

Maar daarentegen zijn er toch wat problemen met soft-links:

* Als je de originele file verwijderd blijft er een ongeldige soft-link over  
  (en moet je deze apert verwijderen)
* Niet alle software werkt vlog met soft-links (soms ook wegens security-regels)
* Permissies (hoewel flexibeler) kunnen afwijken tussen de soft-link en de oorspronkelijke

Ook zal een hard-link performanter zijn vergeleken tot een soft-link.  
De relevantie hangt natuurlijk wel af van de use case, als je 1 file dient uit te lezen zal dit weinig of geen verschil uitmaken, als je daarentegen een paar honderduizend achter elkaar wordt het meer relevanter...

