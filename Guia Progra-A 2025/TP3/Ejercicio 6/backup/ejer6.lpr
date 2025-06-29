program ejer6;

const
     sueldoInicial=1000;

var
   mov:char;
   contFallidos:byte;
   monto,sueldo:real;

begin
     writeln('Ingrese un movimiento (D,R,F)');
     readln(mov);
     mov:=upcase(mov);
     sueldo:=sueldoInicial;                //Preguntar si no conviene inicializar mov con algun valor cualquiera para simplificar el codigo
     contFallidos:=0;         //Probablemente se puede optimizar aun mas el codigo en estos casos de ingreso de datos usando Repear y no While

     while (mov <> 'F') do
           begin
                if (mov = 'D') then
                   begin
                        writeln('Cuanto desea depositar');
                        readln(monto);
                        sueldo:=sueldo + monto;
                   end
                else if (mov = 'R') then
                   begin
                        writeln('Cuanto desea extraer');
                        readln(monto);
                        if (monto <= sueldo) then
                           sueldo:=sueldo - monto
                        else
                            begin contFallidos:=contFallidos + 1; writeln('Fondos insuficientes'); end;
                   end;

                   writeln('Ingrese un movimiento (D,R,F)');  //Considerar nunca evaluar dentro del if la condicion que ya evalua el while
                   readln(mov);
                   mov:=upcase(mov);

           end;

     writeln('Su sueldo final es de: $',sueldo:8:2);
     writeln('No pudo retirar dinero por insuficiencia de fondos ',contFallidos,' veces');
     readln;

end.

