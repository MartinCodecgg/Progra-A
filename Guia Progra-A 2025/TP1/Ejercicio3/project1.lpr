program project1;

const
     paga=200;
     descPrevisional=11;
     descCoberturaMedica=5;

var
  X:word;

begin
     writeln('Ingrese la cantidad de horas trabajadas');
     readln(x);

     writeln('Su sueldo bruto es ',x*paga);
     writeln('Su sueldo neto es ',(x*paga*(100-descPrevisional-descCoberturaMedica)/100):8:2);
     //Recordar dejar espacios al poner cada coma si sigue un numero, o si tiene detras uno
end.

