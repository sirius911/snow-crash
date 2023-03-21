une fois connecté avec:
ssh level00@ip -p4242 (mdp level00)

On cherche les fichier dont l'utilisateur est flag00:
find / -user flag00 2> /dev/null
on trouve : 
- /usr/sbin/john
- /rofs/usr/sbin/john
qui contiennent tous les deux le même code : 
cat /rofs/usr/sbin/john
cdiiddwpgswtgt

dans https://www.dcode.fr/chiffre-cesar
on trouve un mdp logique : 
nottoohardhere

on se log avec : 
su flag00
et on répupère le prochain mdp:
getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias

ne reste plus qu'à se loger avec ce token
su level01