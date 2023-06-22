
## Connecteren aan andere machines met ssh

Om op je systeem remote in te loggen wordt veelal ssh gebruiken.  
Deze secure shell zal - in tegenstelling tot telnet - je toelaten om een beveiligde
en geencrypteerde verbinding e maken


### Installatie en configuratie

Om je systeem open te stellen installeer je op standaard linux-systemen (debian, fedora, ...)
het openssh-systeem.  
Let er op dat je zeker het server gedeelte installeert 
(het client-gedeelte is zo goed als altijd reeds beschikbaar)

~~~
# apt install openssh-server
~~~

Als je dit op je eigen laptop installeert is het meestal aangeraden dit enkel open te zetten
wanneer je dit nodig hebt.  
Dus uit veiligheidsoverwegingen kan je dit disablen met systemctl.


### Connecteren en testen

Als eerste test kan je eventueel lokaal connecteren.  
Het formaat om te connecteren is

~~~
ssh <user>@<host-adres>
~~~

Als eerste test kan je vanop je eigen machine als volgt inloggen

~~~
ssh student@localhost
~~~

### Banner plaatsen

Een leuke extra is dat je een banner kan configureren.  

> Doelstelling is te tonen hoe en waar je de ssh server moet configureren


**Stap 1:** maak een **file** aan met een **banner**

~~~
# vi /etc/ssh/sshd-banner
~~~

Je kan eventueel de content van onderstaande text invoeren:

~~~
/  \    /  \ ____ |  |   ____  ____   _____   ____   _/  |_  ____   \______ \   ____\_ |__ |__|____    ____  
\   \/\/   // __ \|  | _/ ___\/  _ \ /     \_/ __ \  \   __\/  _ \   |    |  \_/ __ \| __ \|  \__  \  /    \ 
 \        /\  ___/|  |_\  \__(  <_> )  Y Y  \  ___/   |  | (  <_> )  |    `   \  ___/| \_\ \  |/ __ \|   |  \
  \__/\  /  \___  >____/\___  >____/|__|_|  /\___  >  |__|  \____/  /_______  /\___  >___  /__(____  /___|  /
       \/       \/          \/            \/     \/                         \/     \/    \/        \/     \/ 
~~~


**Stap 2:** pas de **ssh-configuratie** aan

~~~
# nano /etc/sshd/sshd_config
~~~

Ga tot aan de lijn waar Banner staat

~~~
...
Banner None
...
~~~

en wijzig deze naar

~~~
...
Banner /etc/ssh/sshd-banner
...
~~~

**Stap 3:** **herstart** de server

~~~
# systemctl restart sshd.service
~~~


~~~
student@studentdeb:~# ssh student@localhost
The authenticity of host 'localhost (::1)' can't be established.
ECDSA key fingerprint is SHA256:9cXv37P0GSEFrW80lNxaHzJ+MlMVTeXvOQ0kHsV0BOY.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'localhost' (ECDSA) to the list of known hosts.
 __      __       .__                                  __           ________        ___.   .__               
/  \    /  \ ____ |  |   ____  ____   _____   ____   _/  |_  ____   \______ \   ____\_ |__ |__|____    ____  
\   \/\/   // __ \|  | _/ ___\/  _ \ /     \_/ __ \  \   __\/  _ \   |    |  \_/ __ \| __ \|  \__  \  /    \ 
 \        /\  ___/|  |_\  \__(  <_> )  Y Y  \  ___/   |  | (  <_> )  |    `   \  ___/| \_\ \  |/ __ \|   |  \
  \__/\  /  \___  >____/\___  >____/|__|_|  /\___  >  |__|  \____/  /_______  /\___  >___  /__(____  /___|  /
       \/       \/          \/            \/     \/                         \/     \/    \/        \/     \/ 
student@localhost's password: 
~~~

### Connecteren zonder password

Als je veel moet connecteren op een andere server is soms vervelend
om altijd je password in te geven.  
Je kan dit vermijden door een te werken met sleutels

#### Keys

Zulke sleutels worden by default opgeslagen in de directory .ssh/ binnen je home-directory

~~~
$ ls .ssh/
id_rsa  id_rsa_bb  id_rsa_bb.pub  id_rsa_ehb  id_rsa_ehb.pub  id_rsa.pub  known_hosts  known_hosts.old
$
~~~

#### Een key aanmaken

Om aan een server te connecteren kan je een bestaande key gebruiken maar
we gaan er vanuit dat er nog geen bestaat...

Om zo'n key te genereren gebruik je het commando ssh-keygen.  
Vul bij de eerste vraag de naam (locatie) van de key in (.ssh/id_student)

~~~
$ ssh-keygen 
Generating public/private rsa key pair.
Enter file in which to save the key (/home/bart/.ssh/id_rsa): .ssh/id_student
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in .ssh/id_student
Your public key has been saved in .ssh/id_student.pub
The key fingerprint is:
....
$
~~~

#### Een key op de server plaatsen

Om de key op de server te krijgen kan je het commando **ssh-copy-id** gebruiken.  
Om de voorgaande sleutel te copieren gebruik je onderstaand commando...

~~~
$ ssh-copy-id -i ~/.ssh/id_student student@otherhost
~~~

#### Testen

~~~
$ ssh -i ~/.ssh/id_student student@otherhost
~~~
