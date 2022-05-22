## Tekst en zoeken

### echo en redirection

~~~
bvo@lol-owi-01:~$ echo "greetings from linux" > testt
bvo@lol-owi-01:~$ echo "hello world" >> testt
bvo@lol-owi-01:~$ echo "hello mars" >> testt
bvo@lol-owi-01:~$ cat testt 
greetings from linux
hello world
hello mars
bvo@lol-owi-01:~$ 
~~~



~~~
bvo@lol-owi-01:~$ echo -e "a\na\nd\na\n" > aaa
bvo@lol-owi-01:~$ cat aaa
a
a
d
a
bvo@lol-owi-01:~$ 
~~~

### Zoeken naar files en commando's

#### find

Met find kan je **zoeken** naar **files** **op naam**  
Het basis-patroon is:

~~~
find <path> -name <name or pattern>
~~~

Stel dat ik een file

* met een exacte naam in dit geval app_permission_item_money.xml
* binnen de directory /home/bvo/Android/Sdk

doe je dit als volgt

~~~
bvo@lol-owi-01:/$ find /home/bvo/Android/Sdk/  -name "app_permission_item_money.xml"
/home/bvo/Android/Sdk/platforms/android-23/data/res/layout/app_permission_item_money.xml
/home/bvo/Android/Sdk/platforms/android-30/data/res/layout/app_permission_item_money.xml
bvo@lol-owi-01:/$ 
~~~

Zoals je ziet in hierboven is de default output van dit commando is het absolute path van elke file die wordt teruggevonden

~~~
bvo@lol-owi-01:/$ find /home/bvo/Android/Sdk/  -name "app*item*xml"
/home/bvo/Android/Sdk/platforms/android-23/data/res/layout/app_permission_item_money.xml
/home/bvo/Android/Sdk/platforms/android-23/data/res/layout/app_permission_item.xml
/home/bvo/Android/Sdk/platforms/android-23/data/res/layout/app_permission_item_old.xml
/home/bvo/Android/Sdk/platforms/android-30/data/res/layout/app_permission_item_money.xml
/home/bvo/Android/Sdk/platforms/android-30/data/res/layout/app_permission_item.xml
/home/bvo/Android/Sdk/platforms/android-30/data/res/layout/app_permission_item_old.xml
bvo@lol-owi-01:/$ 
~~~

Je kan ook het zoekpath weglaten, dan zal deze in de huidige directory binnen zoeken.  
Onderstaand(e) commando('s) hebben een vergelijkbaar resultaat...

~~~
bvo@lol-owi-01:/$ cd /home/bvo/Android/Sdk/
bvo@lol-owi-01:~/Android/Sdk$ find  -name "app*item*xml"
./platforms/android-23/data/res/layout/app_permission_item_money.xml
./platforms/android-23/data/res/layout/app_permission_item.xml
./platforms/android-23/data/res/layout/app_permission_item_old.xml
./platforms/android-30/data/res/layout/app_permission_item_money.xml
./platforms/android-30/data/res/layout/app_permission_item.xml
./platforms/android-30/data/res/layout/app_permission_item_old.xml
bvo@lol-owi-01:~/Android/Sdk$ 
~~~

Beperken tot type.  
Je kan je bijvoorbeeld ook beperken tot een bepaald type, stel dat je bijvoorbeeld wil zoeken op alle folders met de naam layout

~~~
bvo@lol-owi-01:/$ find /home/bvo/Android/Sdk/ -type d -name layout
/home/bvo/Android/Sdk/sources/android-23/android/widget/layout
/home/bvo/Android/Sdk/sources/android-23/com/android/test/layout
/home/bvo/Android/Sdk/sources/android-30/com/android/layout
/home/bvo/Android/Sdk/platforms/android-23/data/res/layout
/home/bvo/Android/Sdk/platforms/android-30/data/res/layout
bvo@lol-owi-01:/$ 
~~~

#### which

Het which-commando kan je gebruiken om een binary te zoeken die op je systeem is geinstalleerd.

~~~
bvo@lol-owi-01:~$ which tmux
/usr/bin/tmux
bvo@lol-owi-01:~$ 
~~~

#### whereis

Dit commando lokaliseert het path van een binary, source- en man-pagina gerelateerd aan een commando.  
Hieronder zoek ik bijvoorbeeld waar het commando zich bevindt

~~~
bvo@lol-owi-01:~$ whereis tmux
tmux: /usr/bin/tmux /usr/share/man/man1/tmux.1.gz
bvo@lol-owi-01:~$ whereis -b tmux
tmux: /usr/bin/tmux
bvo@lol-owi-01:~$ 
~~~

### Zoeken naar tekst

#### grep

~~~
bvo@lol-owi-01:~$ echo "greetings from linux" > testt
bvo@lol-owi-01:~$ echo "hello world" >> testt
bvo@lol-owi-01:~$ echo "hello mars" >> testt
bvo@lol-owi-01:~$ cat testt 
greetings from linux
hello world
hello mars
bvo@lol-owi-01:~$ 
~~~

~~~
bvo@lol-owi-01:~$ grep hello testt
hello world
hello mars
bvo@lol-owi-01:~$ grep linux testt
greetings from linux
bvo@lol-owi-01:~$ 
~~~

#### rgrep

### File-viewing

#### tail/head

~~~
bvo@lol-owi-01:~$ history | tail -10
 1989  echo "hello world" > testt
 1990  echo "hello mars" > testt
 1991  grep hello test
 1992  grep hello testt
 1993  echo "greetings from linux" > testt
 1994  echo "hello world" >> testt
 1995  echo "hello mars" >> testt
 1996  grep hello testt
 1997  grep linux testt
 1998  history | tail -10
bvo@lol-owi-01:~$ 
~~~

#### less is more

### Tekst-manipulate

#### uniq

~~~
bvo@lol-owi-01:~$ echo -e "a\na\nd\na" | uniq
a
d
a
bvo@lol-owi-01:~$ 
~~~

#### sort

~~~
bvo@lol-owi-01:~$ echo -e "a\na\nd\na\n" | sort | uniq

a
d
bvo@lol-owi-01:~$ 
~~~

#### parsen met cut

#### paste en join

#### tr
