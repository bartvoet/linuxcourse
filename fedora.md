## Getting started 2 => installatie van een 2de distro (Fedora)

### Downloaden van de "Fedora Workstation"-image

Alvorens te starten downloaden we de meest recente versie van Fedora te vinden te https://getfedora.org/nl/workstation/download/

> Nota:  
> Gezien de versies van Fedora razendsnel evolueren kan het zijn de versie ondertussen al vernieuwd is.  De versie die we gebruikt hebben hier is **Fedora 35**, ondertussen 3 weken later zit me al Fedora **36**....  
> Als je echter een versie gebruikt die hoger is zou echter geen probleem mogen stellen (instructies zullen heel gelijklopend zijn)

### Voorbereiding (VirtualBox)

We starten met VirtualBox voor te bereiden op de installatie.

> We gaan er vanuit dat je reeds eerder VirtualBox (of alternatief Qemu) hebt geïnstalleerd op je systeem

We maken een nieuwe harde schijf aan zoals hieronder geïllustreerd, je kan dit via het menu "Machine/New" bereiken.

![](Pictures/10000000000002480000018B3CD060A8B7738384.png)

De memory-size is bij voorkeur 2-4GB, maar 1GB zou ook moeten lukken.

![](Pictures/100000000000024F0000018AAEEC681F99DD621A.png)

Maak een harde schijf aan, kies hiervoor om een nieuwe harde schijf aan te maken.

![](Pictures/100000000000024B0000018978A41FDB28CC93B7.png)

Opteer voor het VDI-type voor deze creatie in het volgende scherm.

![](Pictures/1000000000000252000001D888151C11009A73A2.png)


Deze kan je best dynamisch alloceren.  
Dit geeft als voordeel dat je vdi-file meegroeit met de ruimte die je OS nodig heeft.  
Dit voor een kleine meerkost qua performantie maar dit zou niet relevant mogen zijn voor het huidige niveau van gebruik.

![](Pictures/1000000000000252000001D541F32B745A173B4E.png)

Kies de grootte (bij voorkeur > 10 GB maar 5GB zou ook nog net moeten kunnen...)

![](Pictures/1000000000000255000001D64F664F61752A175E.png)

Daarna klik je op create en je image wordt aangemaakt.

### Installatie-CD koppelen

Wanneer je op finish klikt zal je zien dat er een nieuwe image is toegvoegd bij je VM's.

![](Pictures/10000000000001B200000078CC15107023C034A1.png)

Om de installatie-cd te koppelen:

* open je de **settings** van je vm
* navigeer je naar **storage**
* **click** je op het **cd-schijfje** (en plus) om je iso-bestand te koppelen

![](Pictures/10000000000002F90000022B2B1FD7E25E65943B.png)

Eénmaal geselecteerd zal je zien dat deze image staat aangeduid en kan je de installatie starten...

### Installatie

Nu kan je gewoon de **installatie** starten door de **VM** te **starten**.  
Je ziet een text-venster, daar kies je voor "Start Fedora-Workstation-Live"

![](Pictures/100000000000027F000002236314933178240796.png)

1-maal Fedora is opgestart (vanaf de CD) opgestart kies je voor installatie.

![](Pictures/100000000000077F000003F1BF6FA67090E743B4.png)

De eerste stap is het kiezen van de taal, je kan hier Nederlands of Engels kiezen.

![](Pictures/100000000000077F000003EFA857AD2CDEDF5F06.png)

Vervolgens kom je in het installatie-overzicht.

Je kan hier 3 zaken configureren:

* Toetsenbord-settings
* Tijd-zone
* Installatiebestemming

De 1ste 2 worden normaal gezien automatisch gedetecteerd indien nodig kan je deze aanpassen.

De belangrijkste is de "Installatiebestemming", namelijk op welk deel of partitie het operating systeem gaat installeren.

![](Pictures/100000000000077A000003EDC0DDFBBD6A1FD819.png)

Gezien het om een éénvoudige installatie gaat mag je de volledige harde schijf selecteren en dan links boven op "Klaar" clicken.

![](Pictures/100000000000077F000003F3DD3A0BF1B6F2B544.png)

Als je dan terug bent in het hoofdinstallatie scherm is de button "Begin installatie" gereed om te selecteren.

![](Pictures/1000000000000778000003EA8AE07B3FDEE03F4D.png)

Eénmaal deze als je op deze button "clickt" start de installatie van het OS naar je (virtuele) harde schijf...

![](Pictures/100000000000077F000003EA072DE9F86760296D.png)


![](Pictures/100000000000077D000003E85978CAF3BC175E36.png)

Na deze installatie kan je het systeem afsluiten.

![](Pictures/100000000000077C000003F743E6E3D0C7BBA5C2.png)

### Configuratie van het systeem

De installatie van Fedora Workstation gebeurt (in tegenstelling tot Debian) in 2 stappen:

* Je installeert het operating systeem (alle software die je nodig hebt om een systeem te starten)
* Na reboot log je in om user-specifieke zaken te configureren op je systeem.

Start nu je systeem opnieuw op maar zorg wel voor de ISO/CD-image verwijderd is uit VirtualBox (dit kan je via de zelfde stappen doen zoals eerder beschreven bij het toevoegen).

Eénmaal opgestart krijg je volgend scherm, ga verder met "Configuratie starten"

![](Pictures/10000000000003E9000002CBF5C2A611752AFD92.png)

Bij de eerste stap krijg je een keuze rond Privacy, we laten deze uitstaan voor deze installatie... (idem dito voor de 2 volgende stappen die niet relevant zijn voor onze oefening)

![](Pictures/10000000000003CB000002D08B1F57C13FF14FCA.png)

We laten ook de volgende keuze uitstaan...

![](Pictures/10000000000003C7000002CF92A8C5A8DF793925.png)

En koppelen geen online-accounts...

![](Pictures/10000000000003C5000002CA96171330B68FD891.png)

De 2 laatste opties zijn de belangrijkste namelijk je credentials (van de hoofdgebruiker).  
In het eerste scherm vul je je username in, kies hier voor dezelfde user als je voor op je debian-systeem gebruikt, namelijk student.

![](Pictures/10000000000003D4000002CC564E1125AA6F55D9.png)

Als laatste kies je als password student (niet als je in je debian installatie hebt gebruikt)

![](Pictures/10000000000003D1000002C49777226BDBDC7F38.png)


Nu is je systeem klaar om met te werken.  

> Bemerk hier ook dat je geen systeem-user (en password) hebt moeten gebruiken.  
> We komen hier later nog op terug...