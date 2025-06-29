program ejerc7;

var
   precio:real;
   talle,elec:char;
   cant:byte;

begin
     writeln('La camisa es de hombre(H) o mujer(M)');
     readln(elec);
     elec:= upcase(elec);
     if (elec = 'H') then
        precio:= 1000
     else
        precio:= 1200;

     precio:=precio*1.21;

     writeln('Ingrese el talle de la camisa');
     readln(talle);
     talle:= upcase(talle);

     if ((elec = 'H') AND (talle = 'S')) or ((elec = 'M') AND (talle = 'X')) then
        precio:=precio*0.95;

     writeln('Ingrese la cantidad que desea comprar');
     readln(cant);
     if (cant > 12) then
        precio:=precio*0.93;

     writeln('El precio unitario final es: ',precio:8:2);
     readln();


end.

