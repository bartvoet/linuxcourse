Doel


Handigheid en basis-naviagie opbouwen in een Linux-machine:
    Basis-navigatie
    Files en directories aanmaken
    Less is more
    Man

(drill and excercise)

Fijnere motoriek
    Bash
    Scripting
    Àutomatisatie
    
Beheer
    installatie
    users groupen
    access en permissie
    
Netwerken
    configuratie van netwerken
    dns
    netcat, ping, traceroute, ...

Processen
    ps
    top
    systemd
    
Troubleshoot
    logs
    monitoring
    processen
    
Tools
    remote access
    ssh-scp
    udev

Boot
    
   Security
   

--------------------------


## Login

### Geschiedenis

#### Lang geleden...

Lang geleden bij zeer oude computersystemen (voor dat men schermen gebruikte) communiceerde men met een computer adhv een **T**ele**TY**pewriter.  
Hier komt de naam **TTY** vandaan.


~~~
+-------+------------------+                 +--------------+
|  T T  |                  |                 |              |
|  e Y  |                  |                 |              |
|  l p  |    PRINTER       |                 |              |
|  e e  |                  |    +-------+    |              |
|    w  |                  |    | RS232 |    |              |
|    r  +-----------------------+-------+----+  COMPUTER    |
|    i  |                  |                 |              |
|    t  |  TeleTYpewriter  |                 |              |
|    e  |                  |                 |              |
|    r  |   Punchcards     |                 |              |
|       |                  |                 |              |
+-------+------------------+                 +--------------+
~~~

Daarna gebruikte men systeem-consoles, ook over RS232.  
Dit is hardware-simulatie van deze **T**ele**TY**pewriter

~~~
+-------+------------------+                 +--------------+
|       |                  |                 |              |
|       |                  |                 |              |
|  S C  |     SCREEN       |                 |              |
|  y o  |                  |    +-------+    |              |
|  s n  |                  |    | RS232 |    |              |
|  t s  +-----------------------+-------+----+  COMPUTER    |
|  e o  |                  |                 |              |
|  m l  |                  |                 |              |
|    e  |    Keyboard      |                 |              |
|       |                  |                 |              |
|       |                  |                 |              |
+-------+------------------+                 +--------------+
~~~

Vandaag de dag dit via software gemuleerd op basis...

~~~
+------------------+
|                  |    +-------------+       +---+--------------------+
|                  |    |GRAPHIC CARD |       |   |                    |
|     SCREEN       +------------------+-------+   |                    |
|                  |                          |   |  /dev/tty1  G      |
|                  |                          | K |  /dev/tty2  E      |
+------------------+                          | E |  ...        T      |
                                              | R |             T      |
+-------------------                          | N |  /dev/tty6  Y      |
|                  |    +---------------+     | E |                    |
|                  |    | USB/PS2/BT/...|     | L |  /dev/tty7         |
|    Keyboard      +----+---------------------+   |                    |
|                  |                          |   |                    |
|                  |                          +---+--------------------+
-------------------+
~~~



Insert/Keyboard/Virtual Keyboard

Ctrl-alt-F5  (F1 tem F6)

Ctrl-alt-F7
/dev/tty1 to /dev/tty7


psuedo tty's /dev/pts/0..x

getty
x system

shell is een cli binnen een virtuele of psuedo 

commando's:
    tty

Open nu een aparte terminal (Ctrl+shift+t)
    
~~~
student@studentdeb:~$ tty
/dev/pts/3
student@studentdeb:~$ users
student student
~~~

Open nu een aparte terminal (Ctrl+shift+t)

~~~
student@studentdeb:~$ tty
/dev/pts/4
student@studentdeb:~$ 
~~~


Als je in je virtuele terminal zit kan je deze zie je dat er 

~~~
student@studentdeb:~$ tty
/dev/tty6
student@studentdeb:~$ 
~~~



~~~
student@studentdeb:~$ su -
Password: 
root@studentdeb:~# w
 22:16:52 up 8 min,  2 users,  load average: 0.04, 0.04, 0.01
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
student  tty7     :0               22:08    8:20   1.39s  0.11s xfce4-session
student  tty6     -                22:09   59.00s  0.16s  0.09s -bash
root@studentdeb:~# 
~~~

Cltrl+l
clear

echo "`ls`" > /dev/tty2
whoami; id -un; id
 -> UID=0 i.e. root
    
     
~~~

    


atlijd proper afsluiten
via gui of systemctl poweroff (root)


text login
graphical login



prompt
su (en sudo)

 
args    >  +---------+    >   return-code
INPUT   >  | PROCESS |    >   OUTPUT
           +---------+    >   ERROR

cd
ls
mkdir
rmdir
rm
pwd


cat
less
more
echo
touch
history


>
|
     
    
