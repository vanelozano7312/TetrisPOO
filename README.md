# Tetris: Programación orientada a objetos
___

El objetivo de este trabajo es emplear el paradigma de programación orientada a objetos para implementar un juego basado en tetrominos como lo es el tetris, por medio de la herramieta de Processing que usa java como lenguaje de programación.
En este tetris los tetrominos y sus rotaciones son representados como enteros de los cuales sus digitos en binario forman una matriz 4x4 tal que cada bit con valor de 1 es un cuadro del tetromino, por ejemplo:

$
\left(
\begin{array}{ll}
123 & 4 \\
1   & 234
\end{array}
\right)
$

La estructura del tetris desarrollado se basa en 2 clases principales, la clase Ficha y la clase Tablero. A continuación tenemos un diagrama que ilustra estas clases, sus atributos y sus métodos.
