program ejerc4;

var
   dia1,dia2,mes1,mes2:byte;
   anio1,anio2:word;

begin
     writeln('Ingrese fecha 1');
     readln(dia1,mes1,anio1);
     writeln('Ingrese fecha 2');
     readln(dia2,mes2,anio2);

     if (anio1>anio2) then
        writeln('La fecha 1 es mas mas reciente, y su trimestre es: ',mes1 div 4 +1)
     else if (anio2>anio1) then
        writeln('La fecha 2 es mas mas reciente, y su trimestre es: ',mes2 div 4 +1)
     else
         begin
              if (mes1>mes2) then
                 writeln('La fecha 1 es mas mas reciente, y su trimestre es: ',mes1 div 4 +1)
              else if (mes2>mes1) then
                 writeln('La fecha 2 es mas mas reciente, y su trimestre es: ',mes2 div 4 +1)
              else
                  begin
                       if (dia1>dia2) then
                          writeln('La fecha 1 es mas mas reciente, y su trimestre es: ',mes1 div 4 +1)
                       else if (dia2>dia1) then
                          writeln('La fecha 2 es mas mas reciente, y su trimestre es: ',mes2 div 4 +1)
                       else
                           writeln('La fecha 2 es mas mas reciente, y su trimestre es: ',mes2 div 4 +1);
                  end;
         end;

                             //Al poner begin y end, poner begin y abajo y el end ya, y escribir en el medio
     readln();
end.

