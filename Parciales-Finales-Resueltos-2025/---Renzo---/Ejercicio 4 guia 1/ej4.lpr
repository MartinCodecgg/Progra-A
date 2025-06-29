program ej4;
var
  ano1,ano2:word;
  mes1,mes2,dia1,dia2:byte;

begin
      writeln('ingrese la 1 fecha (dia/mes/año)');
      readln(dia1,mes1,ano1);
      writeln('ingrese la 2 fecha (dia/mes/año)');
      readln(dia2,mes2,ano2);
      if (ano1<ano2) or ((ano1=ano2) and ((mes1<mes2) or ((mes1=mes2) and (dia1<dia2)))) then
            writeln('la 1 fecha es mas antigua ',mes1 mod 4 +1,'trimestre')
      else
                  if (ano1<ano2) or ((ano1=ano2) and ((mes1<mes2) or ((mes1=mes2) and (dia1<dia2)))) then
                       writeln('la 1 fecha es mas antigua ',mes1 mod 4 +1,'trimestre')
                  else
                              writeln('las 2 fechas son iguales ',mes1 div 4 +1,' trimestre');
      readln;
end.

