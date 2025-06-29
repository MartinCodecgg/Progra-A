program ejerc11;

var
   tipo:char;
   contFallidos:byte;
   sueldo,monto:real;
   arch:text;


begin
     assign(arch,'datos.txt');
     reset(arch);
     readln(arch,sueldo);

     contFallidos:=0;

     while not eof(arch) do
           begin
                readln(arch,tipo,monto);
                tipo:=upcase(tipo);
                if (tipo = 'D') then
                   sueldo:=sueldo + monto
                else
                    if (sueldo >= monto) then
                       sueldo:=sueldo - monto
                    else
                        contFallidos:=contFallidos + 1;

           end;
     writeln('El saldo final de la cuenta es: ',sueldo:8:2);
     writeln('Intento retirar saldo insuficiente ',contFallidos,' veces');
     readln();

end.

