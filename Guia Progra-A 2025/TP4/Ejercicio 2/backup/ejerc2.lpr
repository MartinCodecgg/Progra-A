program ejerc2;

function calcular(n:byte):word;
var
   i:byte;
   aux:word;
begin
     if n = 1 then
        calcular:=1
     else
         begin
              aux:=n;
              for i:=n-1 downto 1 do
                  begin
                       aux:=aux * (i);
                  end;
              calcular:=aux;
         end;
end;

var
   n:byte;

begin
     writeln('Ingrese un numero');
     readln(n);
     writeln('El factorial del numero es: ',calcular(n));
     readln;
end.

