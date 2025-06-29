program ejerc1;

function validar(car:char):boolean;
begin
     car:=upcase(car);
     if car in ['A'..'Z'] then
        validar:=true
     else
         validar:=false;
end;

var
   car:char;

begin
     writeln('Ingrese un caracter');
     readln(car);
     if validar(car) then
        writeln('Es una letra')
     else
         writeln('No es una letra');
     readln;
end.

