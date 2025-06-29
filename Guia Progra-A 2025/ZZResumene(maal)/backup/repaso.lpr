program repaso;

const TOP = 100;
type TV = array[1..TOP] of byte;

(*Metodos para Vectores*)

(*BUSQUEDA*)
//Busqueda sabiendo que el elemento puede no estar
{A pesar que se recorre el arreglo y se conoce la cantidad de elementos del vector, se utiliza un ciclo While y no un For. Porque el avance sobre el arreglo depende de dos condiciones:
Todavía quedan componentes por inspeccionar: 1) (i <= N) , 2) No se encontró el valor buscado ( V[i] <> X )
El índice se inicia antes del ciclo y se incrementa mientras no se encuentre el valor buscado.          }


Function Buscar (V:TV; N:byte; x:integer):byte;
Var
   i: byte;
Begin
     i:=1;
     while (i < N) and (x <> V[i]) do
            i:= i+1;

     if V[i]=X then
        Buscar := i
     else
         Buscar:= 0;
End;

{Lo que hace es ir recorriendo desde el principio hasta el final del vector, Mientras no me caigo(i<=N) y mientras no lo encuentre, voy aumentando el i
Una vez da falso pregunto si lo encontré o si me cai, y doy i o 0 según corresponda }


//Busqueda sabiendo que el elemento esta
{b) Se sabe que el elemento esta, solo se requiere su Posición
Para este caso no es necesario controlar el índice(analizar si me caigo) }

Function Busca( V:TV; x:integer ):byte;    //Notar que no es necesario N
Var
   i: byte;
Begin
     i:=1;
     While x <> V[ i ] do
           i:= i+1;
     Busca := i
end;

//Busqueda sabiendo que el arreglo esta ordenado
{C) Si el arreglo esta ordenado no debe recorrerlo hasta el final para determinar que x no está en el arreglo, por lo tanto se avanza mientras X > V[i]. }

Function BuscaOrd ( V:TV; N:byte; x:integer ):byte;
Var
 i: byte;
Begin
     i:=1;
     While (i < N) and (x > V[ i ]) do
           i:= i+1;
     If V[ i ] = x then
        BuscaOrd := i
     Else
         BuscaOrd:= 0;
End;

{El cambio respecto al A, es que al estar ordenado, por ejemplo si busco el 2 de un arreglo que contiene los números ordenados del 1 al 10
una vez que el 2 sea mayor que v[i] que seria para i=3, significa que ya lo paso, entonces ahi deberia salir del ciclo }


//Búsqueda Binaria
{Si el arreglo está ordenado no es eficiente recorrerlo secuencialmente, en el peor caso debe hacer N comparaciones.
La estrategia es “partir” a la mitad el arreglo y analizar si el elemento del medio es el valor buscado
de no serlo puede ser menor y se descarta la mitad derecha o mayor descartándose la mitad izquierda.
Este proceso implica redefinir el limite derecho o izquierdo de un subarreglo donde se aplicara el mismo criterio.
El proceso finaliza cuando lo encuentra o cuando ya no es posible redefinir un subarreglo. }

Function BusquedaBinaria ( V:TV; N:byte; x:integer ):byte;
Var
   Medio, Pri, Ult: byte;
Begin
     Pri := 1;
     Ult := N;
     Medio:=(Pri + Ult) DIV 2;
     While (Pri < Ult) and (x <> V[ Medio ]) do
           Begin
                If x < V[ Medio ] then
                   Ult := Medio - 1
                Else
                    Pri:= Medio + 1;

                Medio:=(Pri + Ult) DIV 2;
           End;

           If x = V[medio] then
           BusquedaBinaria:=medio
           Else
               busquedaBinaria:=0;
End;

{Es decir el algoritmo funciona asi
Las variables pri y ult son los limites de los intervalos, y medio es el elemento del medio
Al principio del código se asigna a pri 1 y a ult N, se halla el medio, y luego entra al while principal
Mientras pri<ult, esto nos chifla que no hemos llegado al fin del vector, esto daría falso cuando queramos tomar un intervalo de fin mayor al propio N
Mientras X sea distinto de v[medio] cuando sea igual ya lo encontró y sale del while
Una vez sale de while pregunta si llego al fin de archivos y no lo encontró o lo encontró
Explicación while: Una vez entra al while pregunta si X es mayor o menor que el valor medio, si es menor, el pri se mantiene como esta
y el ultimo es medio-1 descartándose el valor del medio que claramente no es
Y si es mayor, se toma el Intervalo después del valor medio, pri=medio+1, el ult se mantiene como esta }


(*Eliminacion de un vector*)
{Eliminar en un arreglo V de N elementos el que está en la posición Pos. El proceso “compacta” el arreglo corriendo todos los elementos hacia la izquierda (desde Pos + 1 hasta N).
Además Se decrementa la cantidad de elementos (N-1) }

Procedure Elimina ( Var V: Tv; Var N : Byte; Pos:Byte);
Var
   i: Byte;
Begin
     For i:= Pos to N-1 do     //Es hasta N -1 porque dentro del for se analiza V+1
         V[ i ] := V[ i+1 ];
     N:=N-1;                     //Se decrementa 1 a la variable que lleva la longitud del vector
End;

{Es decir corre todos los elementos hacia la izquierda, desde el elemento que esta en pos hasta N-1}
{Para eliminar un elemento, es probable que requiera antes hacer una búsqueda, ya que necesito la posición del elemento(Pos) }


(*Inserción*)
//Inserción en un vector no ordenado, Requiere la posición(pos) de lugar a donde debe insertarse
{Insertar en un arreglo V de N elementos el valor X en la posición Pos. El proceso “abre” el
arreglo para hacer lugar al nuevo valor. Se corren todos los elementos hacia la derecha (desde
N hasta Pos).
Se incrementa la cantidad de elementos (N+1) }

Procedure Inserta( Var V:TV; Var N:Byte; Pos: Byte; X:Integer);
Var
 i: Byte;
Begin
     For i := N downto Pos do
         V[ i+1 ] := V[ i ];
     V[ Pos ]:= X;
     N := N+1;
End;
//Se debe asegurar que el vector tenga N+1 espacios definidos
{Lo que hace con el for es empezar desde la derecha y va hacia izquierda, corre todos los elementos que están delante de pos, un lugar a la derecha
Cuando termina, inserta el valor en pos
Y se aumenta 1 a la variable que lleva la longitud del vector }


(*Inserción Ordenada*)
//No requiere la posición(pos)
{Si la inserción es en un arreglo ordenado, no se debe determinar la posición.
El proceso busca de derecha a izquierda y realiza el corrimiento simultáneamente ,se incrementa la cantidad de elementos (N+1).  }

Procedure InsertaOrdenado( Var V: TV; Var N: Byte; X: byte);
Var
   J: Byte;
Begin
     J:= N;
     While ( J > 0 ) and (X < V[ J ] ) do
           Begin
                V[ J+1 ] := V [ j ] ;
                J := J-1;
           End;
     V[ J+1 ] := X ;   //Se debe hacer J+1 ya que en la ultima iteracion se hizo j:= j-1
     N := N+1;
End;

{Lo que hace es usar la variable J en este caso como índice, y va recorriendo(buscando el lugar donde deberia insertarse)
a la vez que si no lo encuentra va corriendo los elementos hacia la derecha
Explicación While, j>0 verifica que no terminamos de analizar todo el vector, cuando este da falso, significa que el elemento a insertar es menor a todos
los elementos del vector. Entonces sale del while y lo inserta como primer elemento
Por otro lado x<v[j] va buscando el elemento, una vez que llega al elemento se cumple que x=v[j] entonces ahí no corre nada
sale del while e inserta el elemento x.
V[j+1]=v[j] se usa para correr a la derecha, y por cada vez que entra j:=j-1 porque busca de derecha a izquierda
Finalmente aumenta uno al N del vector  }

Procedure Diferencias;
begin
     {






     }
end;

var
   n:byte;
   V:TV;
   x,pos:byte;
begin
     n:=0;x:=0;v[1]:=0; //Solo para que no me tire los warning

     pos:= buscar(v,n,x);                 //Busqueda, el elemento puede no estar
     pos:= busca(v,x);                    //Busqueda, sabiendo que el elemento esta
     pos:= buscaOrd(v,n,x);               //Busqueda, el arreglo viene ordenado
     pos:= busquedaBinaria(v,n,x);        //BusquedaBinaria, una busqueda mas eficiente para un arreglo ordenado
     Elimina(v,n,pos);                    //Eliminacion
     Inserta(v,n,pos,x);                  //Insercion
     InsertaOrdenado(v,n,x);              //Insercion Ordenada

     Diferencias;                         //Ignorar
end.
