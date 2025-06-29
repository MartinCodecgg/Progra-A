program ejerc1;

Function Potencia(x,n:byte):real;
begin
     if n = 1 then                         //Caso base
        potencia:= x
     else                                  //Caso recurrente
         potencia:= x * Potencia(x,n-1);
end;

begin
     writeln(potencia(5,2):8:2);
     readln;
end.
