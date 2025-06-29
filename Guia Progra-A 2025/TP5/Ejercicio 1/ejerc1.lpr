program ejerc1;

const
     N = 9;

type
    Tv = array[1..N] of byte;

const
     Vejemplo:Tv=(1,2,3,4,5,6,7,8,9);

function suma(vec:tv;nv:byte):word;
var
   i:byte;
   aux:word;
begin
     aux:=0;
     for i:=1 to nv do
         begin
              aux:= aux + vec[i];
         end;
     suma:=aux;
end;

procedure mostrarPares(vec:tv;nv:byte);
var
   i:byte;
begin
     for i:=1 to nv do
         begin
              if (i mod 2) = 0 then
                 write(vec[i],' ');
         end;
     writeln();  //Recordar siempre que muestro algo con write, luego usar writeln(); para bajar de linea
end;

Function minimo(vec:tv;nv:byte):byte;
var
   i:byte;
   min:word;
begin
     min:=65000;
     for i:=1 to nv do
         begin
              if vec[i] < min then
                 min:=vec[i];
         end;
     minimo:=min;
end;

Function maximo(vec:tv;nv:byte):byte;
var
   i:byte;
   max:byte;
begin
     max:=0;
     for i:=1 to nv do
         begin
              if vec[i] > max then
                 max:=vec[i];
         end;
     maximo:=max;
end;

procedure generarVecB(vec:tv;nv:byte;var vecB:tv);
var
    i,j:byte;
begin
     j:=0;
     for i:=nv downto 1 do
         begin
              j:=j + 1;
              vecB[j]:=vec[i];
              write(vec[i],' ');
         end;
     writeln();
end;

var
   vec,vecB:tv;
   nv:byte;
begin
     vec:=Vejemplo;
     nv:=N;
     writeln('La suma de los elementos del vector es: ',suma(vec,nv));
     writeln('Los elementos en posiciones pares del vector son:');
     mostrarPares(vec,nv);
     writeln('El minimo del array es: ',minimo(vec,nv));
     writeln('El maximo del array es: ',maximo(vec,nv));
     writeln('El arreglo B generado y mostrado es:');
     generarVecB(vec,nv,vecB);   //No hace falta iniciar pues lo genero en el procedimiento a vecB
     readln;
end.

{Ej 1) Dado un arreglo A de N elementos reales, desarrollar subprogramas para:
a) Calcular la suma de sus elementos.
b) Mostrar los elementos que se encuentran en posiciones pares.
c) Calcular el máximo y el mínimo elemento.
d) Generar un arreglo B con los elementos de A permutado ( B[1]=A[N], B[2]=A[N-1] … B[N]=A[1] ).
Escribir el programa principal con las invocaciones a cada uno de los subprogramas, mostrando los
resultados correspondientes.
}
