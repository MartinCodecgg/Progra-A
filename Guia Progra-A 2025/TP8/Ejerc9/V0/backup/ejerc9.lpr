program ejerc9;

Function Validar(n:word):boolean;
begin
     if n in [0..9] then
        Validar:=true
     else
         if (n mod 10) >= ((n div 10) mod 10) then
            validar:= validar(n div 10)
         else
             validar:=false;
end;

var
   n:word;
begin
     writeln('Ingrese el numero');
     readln(n);
     if validar(n) then
        writeln('Las cifras del numero estan de forma creciente')
     else
         writeln('Las cifras del numero NO estan de forma creciente');
     readln;
end.
