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
Enkele andere shortcuts, die in de helpinformatie (^G) uitgebreid worden beschreven, kunnen met de Meta-, Esc- of Alt-toets aangeroepen worden. Zo staat M-} (regel inspringen) bijvoorbeeld voor de combinatie Alt/Esc/Meta+}.

Verder kun je vrijuit typen en de pijltjestoetsen gebruiken om door het bestand te navigeren. Tussentijds opslaan doe je aan de hand van de WriteOut-shortcut (^O). Zodra je het bestand afsluit met ^X, zul je gevraagd worden of je onopgeslagen wijzigingen wilt opslaan of negeren.


### Voorbeeld

~~~
student@studentdeb:~$ nano nano_test
~~~

~~~
  GNU nano 5.4                                               nano_test *                                                      










                                                     [ Undid line break ]
^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy

~~~


~~~
  GNU nano 5.4                                               nano_test *                                                      
Hello World nano
Dit is een nano test








                                                     [ Undid line break ]
^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy

~~~


