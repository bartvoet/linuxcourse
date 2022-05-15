## Alias

### Aliassen bekijken

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


### Zelf aliassen aanmaken

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

### Alias ontwijken

~~~
[student@fedora ~]$ grep if .bashrc 
if [ -f /etc/bashrc ]; then
# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
		if [ -f "$rc" ]; then
~~~


~~~
[student@fedora ~]$ \grep if .bashrc 
if [ -f /etc/bashrc ]; then
# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
		if [ -f "$rc" ]; then
[student@fedora ~]$ 
~~~