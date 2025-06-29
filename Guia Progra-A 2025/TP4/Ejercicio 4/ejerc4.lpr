program ejerc4;

function potencia(x:real;y:shortint):real;
var
   i:byte;
   aux:real;
begin
     if y > 0 then
        aux:=x
     else if y < 0 then
         begin
              aux:=1/x;
              x:=1/x;
         end
     else
         potencia:=1;

     for i:=2 to abs(y) do
         begin
              aux:=aux*x;
         end;

     if y <> 0 then
     potencia:=aux;
end;

var
   x:real;
   y:shortint;

begin
     writeln('Ingrese un numero para calcular su potencia, y su respectiva potencia');
     readln(x,y);
     writeln('Su potencia es: ',potencia(x,y):8:2);
     readln;
end.

