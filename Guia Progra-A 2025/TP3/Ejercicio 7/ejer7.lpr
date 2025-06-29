program ejer7;

type
     st20=string[20];

var
   cantAprobados,N,nota1,nota2,nota3:byte;
   nombre:st20;
   prom:real;

begin
     writeln('Ingrese el nombre del alumno');
     readln(nombre);
     writeln('Ingrese sus 3 notas');
     readln(nota1,nota2,nota3);
     n:=0;                  //Recordar inicializar variables ni bien las creo
     cantAprobados:=0;

     while (nombre <> '***') do     //Preguntar eficiencia de este codigo, quizas es mejor poner todo dentro del while e inicializar nombre
           begin
                n:=n+1;
                prom:=(nota1+nota2+nota3)/3;
                writeln('El promedio del alumno es :',prom:8:2);
                if (prom >= 4) then
                   begin
                        writeln('Esta aprobado');
                        cantAprobados:=cantAprobados+1;
                   end
                else
                   writeln('Esta desaprobado');

                writeln('Ingrese el nombre del alumno');
                readln(nombre);

                if (nombre <> '***') then
                   begin
                        writeln('Ingrese sus 3 notas');
                        readln(nota1,nota2,nota3);
                   end;


           end;
     writeln('Finalizo la carga de datos');
     writeln('El porcentaje de aprobados es: ',(n/cantAprobados)*100:8:2);   //Recordar multiplicar x 100 para sacar el porcentaje
     readln;
end.

