program ejerc1;

var
  car:char;

begin
     writeln('Ingrese el caracter');
     readln(car);
     if (car in ['a'..'z']) OR (car in ['A'..'Z']) then
        begin
             if car = upcase(car) then
                writeln('La letra es mayuscula')
             else
                 writeln('La letra es minuscula')
        end
     else
         writeln('El caracter no es una letra');

     READLN();
end.

