program ejer11_b;

type
     st20=string[15];

var
   cantAprobados,N,nota1,nota2,nota3:byte;
   nombre:st20;
   prom:real;
   arch:text;

begin
     n:=0;                  //Recordar inicializar variables ni bien las creo
     cantAprobados:=0;
     assign(arch,'notas.txt');
     reset(arch);

     while not eof(arch) do
           begin
                readln(arch,nombre,nota1,nota2,nota3);              //Nuevamente para este caso conviene conviene el readln en la 1ra linea del while

                n:=n+1;
                prom:=(nota1+nota2+nota3)/3;
                writeln('El promedio del alumno ',nombre,' es :',prom:8:2);
                if (prom >= 4) then
                   begin
                        writeln('Esta aprobado');
                        cantAprobados:=cantAprobados+1;
                   end
                else
                   writeln('Esta desaprobado');

           end;
     writeln('Finalizo la carga de datos');
     writeln('El porcentaje de aprobados es: ',(cantAprobados/n)*100:8:2);   //Recordar multiplicar x 100 para sacar el porcentaje, y que el n va abajo
     readln;
end.
