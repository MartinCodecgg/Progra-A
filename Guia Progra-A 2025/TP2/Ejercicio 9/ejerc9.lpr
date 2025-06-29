program ejerc9;

const
  sueldoBasico=8000;

var
   ventas,sueldo,x:real;
   dias:byte;

begin
     writeln('Ingrese el total de ventas');
     readln(ventas);
     writeln('Ingrese el monto x de ventas');
     readln(x);
     writeln('Cuantos dias falto');
     readln(dias);

     sueldo:=sueldoBasico;
     sueldo:=sueldo+ventas*0.05;

     if (ventas > x) then
        sueldo:=sueldo*1.03;


     if (ventas*0.02 > 1000) then
        sueldo:= sueldo + ventas*0.02
     else
       sueldo:=sueldo + 1000;


     if (dias > 2) then
        sueldo:=sueldo*0.93;

     writeln('Su sueldo final es de, ',sueldo:8:2,' pesos');
     readln();
end.

