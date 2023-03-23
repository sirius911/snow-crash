Il n'y a rien dans ce niveau
```shell
level14@SnowCrash:~$ ls -la
total 12
dr-x------ 1 level14 level14  100 Mar  5  2016 .
d--x--x--x 1 root    users    340 Aug 30  2015 ..
-r-x------ 1 level14 level14  220 Apr  3  2012 .bash_logout
-r-x------ 1 level14 level14 3518 Aug 30  2015 .bashrc
-r-x------ 1 level14 level14  675 Apr  3  2012 .profile
```
rien avec find / -user flag14

On va regarder dans getflag

```shell
level14@SnowCrash:~$ gdb getflag
(gdb) run
Starting program: /bin/getflag 
You should not reverse this
[Inferior 1 (process 13751) exited with code 01]
```
ptrace doit nous empecher de run
on trouve sur le net comment passer outre:
[Bypassing ptrace in gdb](https://stackoverflow.com/questions/33646927/bypassing-ptrace-in-gdb)
```shell
(gdb) catch syscall ptrace
Catchpoint 1 (syscall 'ptrace' [26])
(gdb) commands 1
Type commands for breakpoint(s) 1, one per line.
End with a line saying just "end".
>set ($eax) = 0
>continue
>end
(gdb) run
Starting program: /bin/getflag 

Catchpoint 1 (call to syscall ptrace), 0xb7fdd428 in __kernel_vsyscall ()

Catchpoint 1 (returned from syscall ptrace), 0xb7fdd428 in __kernel_vsyscall ()
Check flag.Here is your token : 
Nope there is no token here for you sorry. Try again :)
[Inferior 1 (process 13778) exited normally]
```
on peut run notre programme sous gdb
On fait la même chose que pour le level13
```shell
(gdb) b getuid
Breakpoint 2 at 0xb7ee4cc0
(gdb) run
Starting program: /bin/getflag 

Catchpoint 1 (call to syscall ptrace), 0xb7fdd428 in __kernel_vsyscall ()

Catchpoint 1 (returned from syscall ptrace), 0xb7fdd428 in __kernel_vsyscall ()

Breakpoint 2, 0xb7ee4cc0 in getuid () from /lib/i386-linux-gnu/libc.so.6
(gdb) step
Single stepping until exit from function getuid,
which has no line number information.
0x08048b02 in main ()
(gdb) print $eax
$2 = 2014
(gdb) set $eax=3014
(gdb) continue
Continuing.
Check flag.Here is your token : 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
[Inferior 1 (process 13818) exited normally]
```