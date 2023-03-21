une fois connecter on a un fichier : **level02.pcap**
fichier de capture de paquets réseau au format tcpdump capturé à partir d'un réseau Ethernet, contenant des informations de paquets réseau capturés et stockés sous forme de données binaires.

on telecharge le fichier en local:
```shell
scp -P4242 level02@192.168.56.101:level02.pcap .
```
puis on utilise **wireshark**

avec Analyse/follow/TCP Stream en mode UTF-8
on a le mdp: ft_wandrNDRelL0L
en copiant collant il y a des [del] qu'il faut garder
