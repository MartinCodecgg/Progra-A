program ejerc6;

var
   n:integer;

begin
     writeln('Ingrese un numero');
     readln(n);
     writeln('El numero quitando las 3 ultimas cifras es ',n div 1000);
     writeln('La cifra que se encuentra en posicion de las centenas es ',(n div 100)mod 10);
     {Esto ya que el 100 divide al numero y da el COCIENTE de la division, diviendo a 1000 por 100 nos da 10, luego el mod 10 nos da el RESTO de la division
      en este caso 0. Entregandonos finalmente la cifra de la posicion de las centenas           }

     readln();
end.

