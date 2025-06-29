program ejerc1;

const
     TOP=100;

type
    TMT = array[1..TOP,1..TOP] of shortint;
    TV = array[1..TOP] of shortint;

procedure armarMt(var mt:TMT; var n,m:byte);
var
   i,j:byte;
   arch:text;
begin
     assign(arch,'datos.txt');reset(arch);
     readln(arch,n,m);

     for i:=1 to n do
         for j:=1 to m do
             read(arch,mt[i,j]);
         readln(arch);
end;

function hallarMax(mt:TMT; fila,m:byte):shortint;
var
   j:byte;
   max:shortint;
begin
     max:=mt[fila,1];
     for j:=1 to m do
         if mt[fila,j] > max then
            max:=mt[fila,j];

     hallarMax:=max;
end;

Procedure InciA(mt:TMT; n,m:byte; var va:TV);
var
   i,j:byte;
begin
     for i:=1 to n do
         va[i]:=hallarMax(mt,i,m);

     //Muestro la matriz
     for i:=1 to n do
         begin
              for j:=1 to m do
                  write(mt[i,j]:4);
              writeln;
         end;

     //Muestro el arreglo
     for i:=1 to n do
         write(va[i],' ');
     writeln;
end;


Function Sumar(mt:TMT; n,j:byte):shortint;
var
   i:byte; sum:shortint;
begin
     sum:=0;
     for i:=1 to n do
         if mt[i,j] mod 2 <> 0 then
         sum:=sum + mt[i,j];

     Sumar:=sum;
end;

Procedure InciB(mt:TMT; n,m:byte; var Vb:TV);
var
   j:byte;  aux:shortint;
begin
     for j:=1 to m do
         begin
              aux:=sumar(mt,n,j);
              if aux <> 0  then
                 Vb[j]:=aux;
         end;

     //Adicional muestro el arreglo generado
     for j:=1 to m do
         write(vb[j],' ');
     writeln;                 //Recordar, SIEMPRE que muestro algo usando write luego hacer un writeln para bajar de linea


end;

Function InciC(mt:TMT; n,x:byte):real;
var
   i:byte;  aux:real;
begin
     aux:=0;
     for i:=1 to n do
         aux:= aux + mt[i,x];

     InciC:=aux/n;
end;

var
   mt:TMT; n,m,x:byte; Va:TV;  Vb:TV;

begin
     armarMt(mt,n,m);
     InciA(mt,n,m,Va);
     InciB(mt,n,m,Vb);
     writeln('Ingrese la columna X');
     readln(x);
     writeln('El promedio de los elementos de la columna X ingresada es:',InciC(mt,n,x):8:2);
     readln;
end.

