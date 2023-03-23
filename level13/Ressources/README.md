```shell
level13@SnowCrash:~$ ls -l
total 8
-rwsr-sr-x 1 flag13 level13 7303 Aug 30  2015 level13

level13@SnowCrash:~$ ./level13
UID 2013 started us but we we expect 4242

level13@SnowCrash:~$ file level13
level13: setuid setgid ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=0xde91cfbf70ca6632d7e4122f8210985dea778605, not stripped

level13@SnowCrash:~$ ltrace ./level13
__libc_start_main(0x804858c, 1, 0xbffff7c4, 0x80485f0, 0x8048660 <unfinished ...>
getuid()                                                                                                                            = 2013
getuid()                                                                                                                            = 2013
printf("UID %d started us but we we expe"..., 2013UID 2013 started us but we we expect 4242
)                                                                                 = 42
exit(1 <unfinished ...>
+++ exited (status 1) +++
```
Toutes ces inforations nous disent que ce fichier est un programme qui vraisemblablement demande que l'UID de l'utilisateur soit 4242.

avec *ltrace* on remarque qu'il utilise getuid() ce qui donne 2013 (notre ID)
regardons avec gdb:
```shell
level13@SnowCrash:~$ gdb level13
(gdb) disas main
```
```asm
Dump of assembler code for function main:
   0x0804858c <+0>:     push   %ebp
   0x0804858d <+1>:     mov    %esp,%ebp
   0x0804858f <+3>:     and    $0xfffffff0,%esp
   0x08048592 <+6>:     sub    $0x10,%esp
   0x08048595 <+9>:     call   0x8048380 <getuid@plt>
   0x0804859a <+14>:    cmp    $0x1092,%eax
   0x0804859f <+19>:    je     0x80485cb <main+63>
   0x080485a1 <+21>:    call   0x8048380 <getuid@plt>
   0x080485a6 <+26>:    mov    $0x80486c8,%edx
   0x080485ab <+31>:    movl   $0x1092,0x8(%esp)
   0x080485b3 <+39>:    mov    %eax,0x4(%esp)
   0x080485b7 <+43>:    mov    %edx,(%esp)
   0x080485ba <+46>:    call   0x8048360 <printf@plt>
   0x080485bf <+51>:    movl   $0x1,(%esp)
   0x080485c6 <+58>:    call   0x80483a0 <exit@plt>
   0x080485cb <+63>:    movl   $0x80486ef,(%esp)
   0x080485d2 <+70>:    call   0x8048474 <ft_des>
   0x080485d7 <+75>:    mov    $0x8048709,%edx
   0x080485dc <+80>:    mov    %eax,0x4(%esp)
   0x080485e0 <+84>:    mov    %edx,(%esp)
   0x080485e3 <+87>:    call   0x8048360 <printf@plt>
   0x080485e8 <+92>:    leave  
   0x080485e9 <+93>:    ret    
End of assembler dump.
```
Ce qui nous interresse ce sont ces deux lignes:

    - 0x08048595 <+9>:     call   0x8048380 <getuid@plt>
    - 0x0804859a <+14>:    cmp    $0x1092,%eax 

la première va récuperer l'ID avec getuid() et le mettre dans %eax
la seconde compare avec 0x1092 (4242)

On va mettre un break sur la ligne qui compare l'ID avec getuid()
```shell
(gdb) break *0x0804859a
Breakpoint 1 at 0x804859a
(gdb) run
Starting program: /home/user/level13/level13 

Breakpoint 1, 0x0804859a in main ()
(gdb) print $eax
$1 = 2013
```
On va alors changer le registre %eax et finir le programme
```shell
(gdb) set $eax=4242
(gdb) continue
Continuing.
your token is 2A31L79asukciNyi8uppkEuSx
[Inferior 1 (process 13336) exited with code 050]
```
on a notre token pour level14 !!