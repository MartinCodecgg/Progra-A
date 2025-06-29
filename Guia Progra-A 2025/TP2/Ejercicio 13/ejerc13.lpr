program ejerc13;

const
     dolar=120.80;       //Usar el punto no coma en pascal para los decimales
     euro=150.10;
     real=26.50;

var
   x:word;
   tipo:char;

begin
     writeln('Ingrese su cantidad de pesos');
     readln(x);
     writeln('Ingrese el tipo de moneda a convertir (D,E,R)');
     readln(tipo);
     tipo:=upcase(tipo);

     case tipo of
     'D':writeln('Puede comprar ',trunc(x/dolar));
     'E':writeln('Puede comprar ',trunc(x/euro));
     'R':writeln('Puede comprar ',trunc(x/real));

     end;
     readln();
end.

