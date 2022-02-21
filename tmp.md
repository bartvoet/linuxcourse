### Finding and locating

### uitleggen van nano


### Processes


#### expression

~~~
$ test 001 = 1
$ echo $?
1
$ test 001 -eq 1
$ echo $?
0
$ touch myfile
$ test -s myfile
$ echo $?
1
$ ls /etc > myfile
$ test -s myfile
$ echo $?
0
~~~

https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php




#### running jobs in the shell

~~~
sleep
ctrl+Z => achtergrond
bg
fg
jobs
fg 1
~~~

~~~
m h  dom mon dow   command
minute
hour
day of month
month
day of week
~~~

#### Status-code

~~~
$?
~~~

#### Process-managment

~~~
top
ps aux
kill -9
~~~

#### sourcing


#### in and output

~~~
           +-------------+   OUT  #1
  #0 IN    |             +---------->
+---------->   PROCESS   |  ERROR #2
           |             +---------->
           +-------------+
~~~

~~~
           +-------------+   OUT  #1
  #0 IN    |             +---------->
+---------->             |  ERROR #2
           |             +---------->
           |   PROCESS   |
           |             |
+---------->             +---------->
 ARGUMENTS |             | EXIT-CODE
           +-------------+
~~~

~~~
|
>
>>
<

sort < a_file > less
history > file1 2>&1
-> redirect stderr to stdout and both to file1
~~~

### Files

inode
softlink vs hardlink



~~~bash
#!/bin/bash
# Nested if statements

if (( $1 % 2 == 0 ))
	then
	echo $1 is an even number.
else
	echo $1 is not even
fi
~~~

~~~bash
#!/bin/bash
# Nested if statements
if [ $1 -gt 100 ]
then
    echo Hey that\'s a large number.
    if (( $1 % 2 == 0 ))
    then
        echo And is also an even number.
    fi
fi
~~~