## Een tekstbestand aanmaken of openen

Het openen of creëren van een tekstbestand is simpelweg een kwestie van nano voor het pad naar het bestand te plaatsen:

~~~
nano /tmp/nano_test
~~~

Bestaat dit bestand nog niet, dan wordt het door Nano aangemaakt.  
Bestaat het wel, dan leest Nano de huidige inhoud uit.

### Omgaan met de Nano-interface

Na het openen van een tekstbestand staat aan de bovenzijde links de versie van Nano, middenin de locatie van het geopende bestand, en rechts de term "Modified" indien het bestand door de gebruiker is aangepast. Daaronder vind je de inhoud van het tekstbestand, en helemaal onderin een aantal shortcuts (snelkoppelingen) voor bepaalde handelingen, zoals het opslaan van en zoeken in het bestand, en het afsluiten van het programma.

~~~
^G Get Help	^O WriteOut	^R Read File	^Y Prev Page	^K Cut Text	^C Cur Pos
^X Exit	^J Justify	^W Where Is	^V Next Page	^U UnCut Text	^T To Spell
~~~

Het ^-teken (caret, of dakje) staat voor de Control/Ctrl-toets op het toetsenbord.  
Deze shortcuts zijn ook via een F-toets (F1 t/m F12) bovenaan het toetsenbord aan te roepen (in de volgorde F1 voor ^G, F2 voor ^X, F3 voor ^O, enzovoorts).  

Hieronder vind je een vertaling van de snelkoppelingen:

~~~
^G Helpinformatie	^O Opslaan	^R Bestand invoegen	^Y Vorige pagina	^K Knip tekst	^C Huidige positie
^X Afsluiten	^J Uitlijnen	^W Zoeken	^V Volgende pagina	^U Plak tekst	^T Spellinghulp
~~~

In plaats van de Control-toets kan ook tweemaal op de Esc-toets gedrukt worden.  
Enkele andere shortcuts, die in de help-informatie (^G) uitgebreid worden beschreven, kunnen met de Meta-, Esc- of Alt-toets aangeroepen worden. Zo staat M-} (regel inspringen) bijvoorbeeld voor de combinatie Alt/Esc/Meta+}.

Verder kun je vrijuit typen en de pijltjestoetsen gebruiken om door het bestand te navigeren. Tussentijds opslaan doe je aan de hand van de WriteOut-shortcut (^O). Zodra je het bestand afsluit met ^X, zul je gevraagd worden of je onopgeslagen wijzigingen wilt opslaan of negeren.


### Voorbeeld

Deze cursus beoogt geen cursus te zijn voor nano.  
Voor een volledige intro in nano kan je terecht bij https://www.nano-editor.org/docs.php

Je opent een nieuwe file door het commando nano te typen gevolgd door de filename.  


~~~
student@studentdeb:~$ nano nano_test
~~~

Als deze file reeds bestaat zal nano de bestaande file openen.  
In dit geval wordt er een lege file geopend.

~~~
  GNU nano 5.4                                               nano_test *                                                      










^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy

~~~

Onderaan deze file zie je diverse commando's die je kan typen
Je kan nu gewoon tekst typen, net als in een gewone tekst-editor.

~~~
  GNU nano 5.4                                               nano_test *                                                      
Hello World nano
Dit is een nano test








^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy
~~~

Als je de inhoud wil opslaan gebruik je het commando "ctrl + x".  
Onderaan vraagt de editor (File Name to Write) om de filename te bevestigen, 
als je wil opslaan naar een andere file kan je een andere naam invullen.

~~~
  GNU nano 5.4                                               nano_test *                                                      
Hello World nano
Dit is een nano test



File Name to Write: nano_test   
^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy
~~~

Daarna kan verder de tekst aanvullen.


~~~
  GNU nano 5.4                                               nano_test *                                                      
Hello World nano
Dit is een nano test
Nog wat tekst



^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy
~~~

Afsluiten doen we met ctrl+x.  

Gezien we nog een lijn hadden bijgeschreven vraagt de editor of de wijzigingen 
mogen worden opgeslagen.  
Hier mag je gewoon Y typen als bevestigen.

~~~
  GNU nano 5.4                                               nano_test *                                                      
Hello World nano
Dit is een nano test
Nog wat tekst



Save modified buffer? Y

 Y Yes
 N No           ^C Cancel
~~~

Daarna krijg je het menu dat je eerder gebruikte om de file te saven 
(en waar je eventueel nog naar een andere naam kan schrijven)

~~~
  GNU nano 5.4                                               nano_test *                                                      
Hello World nano
Dit is een nano test



File Name to Write: nano_test   
^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy
~~~


### En verder...

Als je meer wil weten over deze editor kan je terecht bij https://www.nano-editor.org/docs.php
