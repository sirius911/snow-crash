Une fois logger avec le mpd trouvé en level00 (token)

on regarde les fichiers shadow et passwd :
```shell
ls -l /etc/shadow
-rw-r----- 1 root shadow 4428 Mar  6  2016 /etc/shadow
```
On a aucun moyen de faire quelquechose
```shell
ls -l /etc/passwd
-rw-r--r-- 1 root root 2477 Mar  5  2016 /etc/passwd
```
On peut regarder dans ce fichier et voire qu'il y a **que** pour *flag01* un hashed password !!
```shel
cat /etc/passwd
...
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
...
```
on un mdp hashed a casser.

il faut déjà je télécharger dans un shell:
```shell
scp -P 4242 level01@ip:/etc/passwd .
```
ensuite on utilise john the ripper dans un docker kalilinux :
```shell
docker run --rm --privileged -v $(pwd):/Ressources -it kalilinux/kali-last-release /bin/bash
```
ensuite dans le docker on install john-the ripper
```shell
apt-get update
apt-get install john
```
il ne reste plus qu'a craquer avec john
```shell
└─# john passwd
Created directory: /root/.john
Using default input encoding: UTF-8
Loaded 1 password hash (descrypt, traditional crypt(3) [DES 128/128 AVX])
Will run 4 OpenMP threads
Proceeding with single, rules:Single
Press 'q' or Ctrl-C to abort, almost any other key for status
Almost done: Processing the remaining buffered candidate passwords, if any.
Proceeding with wordlist:/usr/share/john/password.lst
abcdefg          (flag01)     
1g 0:00:00:00 DONE 2/3 (2023-03-21 17:02) 2.500g/s 63370p/s 63370c/s 63370C/s 123456..HALLO
Use the "--show" option to display all of the cracked passwords reliably
Session completed. 
```
on a notre mdp pour flag01: **abcdefg**
```shell
su flag01
getflag
