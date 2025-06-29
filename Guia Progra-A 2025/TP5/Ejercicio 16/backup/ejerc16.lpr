program ejerc16;   //Hay que usar una funcion de busqueda para determinar pos y luego eliminacion para eliminar

const TOP = 9;
type
    TV = array[1..TOP] of shortint;

const
     A:TV = (-2,0,-1,1,1,0,1,1,0);

function buscar(vec:TV; n,x:byte):byte;
var
   i:byte;
begin
     i:=1;
     while (i < n) and (x <> vec[i]) do
           i:= i+1;

     if vec[i] = x then
        buscar := i
     else
         buscar:=0;
end;

procedure eliminar(var vec:TV; var n:byte; pos:byte);
var
   i:byte;
begin
     for i:= pos to n-1 do     //Recordar hasta n-1 porque va hasta i+1
         begin
              vec[i]:= vec[i+1];
         end;
     n:=n-1;
end;


var
   vec:TV;
   n,pos,i:byte;
begin
     n:=TOP;
     vec:=A;   //Recordar si le cambio el nombre a una variable luego debo recorrer todo buscando donde mas use la variable
     pos:= buscar(vec,n,0);

     while pos <> 0 do
           begin
                eliminar(vec,n,pos);
                pos:= buscar(vec,n,0);
           end;

     for i:=1 to n do
         write(vec[i],' ');
     readln;
end.
