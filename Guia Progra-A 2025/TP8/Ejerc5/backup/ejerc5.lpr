program ejerc5;

const
     TOP=5;

type
    TV = array[1..TOP] of shortint;   //shortint es [-128 a 127]

Function Suma(V:TV ;n:byte):shortint;
begin
     if n=0 then
        suma:=0
     else
         suma:= V[n] + suma(V,n-1);
end;

Procedure Mostrar(V:TV; n:byte);
begin
     if n > 1 then
        Mostrar(V,n-1);
     write(V[n]:4);//Si el caso base hace lo mismo que el caso recurrente (la sentencia), considerar un caso de ausencia de caso base, y hacerlo de esta forma
end; //Es decir con n>1, asi cuando n=1 hace la sentencia unicamente

Procedure MostrarInv(V:TV; n:byte);
begin
     write(V[n]:4);
     if n > 1 then
        MostrarInv(V,n-1);
end;

Function HallarMax(V:TV; max:shortint; n:byte):shortint;
var
   aux:shortint;
begin
     if n = 1 then
        HallarMax:=V[n]
     else
        begin
             aux:=HallarMax(V,max,n-1);
             if aux > V[n] then
                max:=aux
             else
                 max:=V[n];
        end;
     HallarMax:=max;
end;

Function Promedio(V:TV; n,top:byte):real;
begin
     if n=0 then
        promedio:=0
     else
         promedio:= V[n] + promedio(V,n-1,top);

     //if n = top then    //Se evalua en cada iteracion, no tiene sentido
     //promedio:=aux/top;  //Es mejor dividir por n afuera,
end;

const
     V:TV=(1,2,3,4,5);

var
   n:byte;
begin
     n:=TOP;
     writeln('La suma de los elementos del vector es: ',Suma(V,n));
     Mostrar(V,n);
     writeln;             //Siempre que escribo algo en horizontal recordar bajar de linea al final del proceso
     writeln('Muestra invertido');
     MostrarInv(V,n);
     writeln;
     writeln('El maximo de los elementos del vector es: ',HallarMax(V,-128,n));
     writeln('El promedio de los elementos es: ',(promedio(V,n,n)/n):8:2);  //[*****PREGUNTAR*****]
     readln;
end.

