# Documentation du langage d'édition de texte 
## Introduction 

Je me suis basé sur l'exemple donné : <br>
`home, mark b, next word, left 2, insert "foo" ,paste b (b + 10) ` <br>
Cependant, pour ma part mon langage ce déplace plus entre les mots et non pas par entre les charactères. On peut : <br> 
* Insérer
* Supprimer
* Subtituer 
* Copier 
* Coller 
* Se déplacer

Pour compiler le projet il suffit de lancer `make all` et ensuite de lancer l'éxecutable main 

## Syntaxe 

La syntaxe se base un tout petit peu sur vim et sur sed. <br>
` Ligne : command ` <br>
Les commandes de bases sont (type execute): <br>
* delete
* insert  
* copy
* paste 

Les mouvements sont de la forme (type move): 
* Home (Pour aller au début de la ligne) 
* End (Pour aller à la fin de la ligne)
* Int * direction ( Pour se déplacer le curseur d'un certain nombre de mot )

Les directions possibles sont Right et Left.

Il est ensuite possible de combiner les deux en suivant la syntaxe suivant : <br>
`execute move `

Toute les commandes possibles sont dans le type `command`

Il est aussi possible d'appliquer les commandes sur toutes les lignes avec le mot clé : GLOBAL <br>  On peut aussi appliquer les commandes sur la dernière ligne avec le mot clé : BOTTOM

Pour séparer les différentes commandes on utilise la virgule, et pour séparer les différentes lignes on utilise le point virgule. <br> 
Pour terminer les commandes on utilise deux points virgules a la suite (Comme sur OCaml)

## Quelques exemples possibles de commandes

`1 : copy, paste` <br> Copie la ligne et la colle sur la même ligne. 
Il faut aussi savoir qu'il est possible de copier sur une ligne et de copier sur une autre ligne <br>
`2 : copy 5 right ; 3 : paste;;` <br>
`2 : 1 right , insert "bonjour"; 3 : move 4 right, delete end , insert "bonjour salut", home ;;` <br> 
`BOTTOM : insert "test"; GLOBAL : 5 right, insert "bonjour"`

Avec `insert` on peut ajouter des phrases complètes. Ils seront aussi pris en compte pour les mouvements du curseur. Comme on a vu il est possible de se mouvoir avec les différents types de move.

# Implémentation

J'utilise un gap_buffer pour gérer les différentes commandes sur les lignes. Ce n'est pas exactement la même implémentation qu'un gap_buffer mais je me suis inspiré de cette structure de donnée pour gérer le tout.Je découpe la ligne en 2 listes, before , after, et la dernière liste représente le buffer qui retient les mots que l'on a copié. <br>
Ainsi entre les deux listes se trouvent le curseur. 

## Fichier 

* `ast.ml` contient tout pour créer l'arbre syntaxique
* `gap_buffer.ml` contient tout sur le type gap_buffer qui nous permet de gérer les commandes sur les lignes. 
* `main.ml` le main 
* `evaluate.ml` permet l'évaluation de l'AST 
* `lexer.mll` le lexer 
* `parser.mly` le parser 

 




