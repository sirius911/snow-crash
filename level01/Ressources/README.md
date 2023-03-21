Une fois logger avec le mpd trouvé en level00 (token)

on regarde les fichiers shadow et passwd : 
ls -l /etc/shadow
-rw-r----- 1 root shadow 4428 Mar  6  2016 /etc/shadow
On a aucun moyen de faire quelquechose

ls -l /etc/passwd
-rw-r--r-- 1 root root 2477 Mar  5  2016 /etc/passwd
On peut regarder dedans et on voit qu'il y a que pour flag01 un hashed password !!

cat /etc/passwd
...
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
...

on un mdp hashed a casser
il faut déjà je télécharger:
scp -P 4242 level01@ip:/etc/passwd .
