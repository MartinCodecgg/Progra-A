program ejerc8;

var
   edad,deportes:byte;
   precio:real;
   natacion:char;

begin
     writeln('Ingrese su edad');
     readln(edad);
     writeln('Ingrese la cantidad de deportes que realiza');
     readln(deportes);

     case edad of
     0..4: precio:=0;
     5..12: precio:= 750;
     13..18: precio:=1200;
     else
         precio:= 1800;
     end;

     if (edad >= 5) AND (deportes > 2) then
        precio:=precio+250;

     writeln('Realiza natacion (S/N)');
     readln(natacion);
     natacion:=upcase(natacion);
     if (natacion ='S') then
        precio:=precio + 800;

     writeln('El total a pagar es: ', precio:8:2);

     readln();
end.

