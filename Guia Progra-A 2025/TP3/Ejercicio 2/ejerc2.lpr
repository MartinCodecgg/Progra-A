program ejerc2;

type
    st20 = string[20];

const
     sueldoBasico = 15000;

var
  i,n,anios:byte;
  nombre:st20;
  sueldo,acumMonto:real;

begin
     writeln('Ingrese la cantidad de empleados');
     readln(n);
     acumMonto:=0;
     for i:=1 to n do
         begin
              sueldo:=sueldoBasico;
              writeln('Ingrese el nombre del empleado');
              readln(nombre);
              writeln('Ingrese antiguedad en años');
              readln(anios);

              case anios of
              0..5:sueldo:=sueldo*1.05;
              6..10:sueldo:=sueldo*1.08;
              11..15:sueldo:=sueldo*1.12;
              else
                  sueldo:=sueldo*1.2;
              end;

              sueldo:=sueldo*0.89;
              sueldo:=sueldo - 500;

              writeln('Nombre del empleado: ',nombre,' Tiene un sueldo de: ',sueldo:8:2);

              acumMonto:= acumMonto + sueldo;
         end;

         Writeln('El monto promedio de cada empleado es: ',(acumMonto/n):8:2);
         readln();
end.

