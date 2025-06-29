program ejerc12;

var
  dia:byte;

begin
     writeln('Ingrese un dia del 1 al 31');
     readln(dia);

     case dia of
     1,8,15,22,29:writeln('Lunes');
     2,9,16,23,30:writeln('Martes');
     3,10,17,24,31:writeln('Miercoles');
     4,11,18,25:writeln('Jueves');
     5,12,19,26:writeln('Viernes');
     6,13,20,27:writeln('Sabado');
     7,14,21,28:writeln('Domingo');
     end;
     readln();
end.

