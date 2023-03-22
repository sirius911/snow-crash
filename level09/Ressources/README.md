```shell
-rwsr-sr-x 1 flag09 level09 7640 Mar  5  2016 level09
----r--r-- 1 flag09 level09   26 Mar  5  2016 token

./level09 
You need to provied only one arg.

./level09 token
tpmhr

./level09 aaaaa
abcde

```
On voit que level09 prend un argument et semble decaler d'un caractere

on va donc faire un petit programme qui decale dans l'autre sens
```shell
cd /tmp
vi decode.py (code in Ressources)
chmod 755 decode.py
./decode.py $(cat ~/token)
f3iji1ju5yuevaus41q1afiuq
```
c'est le mdp de flag09
ensuite on getflag