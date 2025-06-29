program ejerc1;

var
   i,n,num,posicion,ocurrencia:byte;
   max:integer;
   min:word;


begin
     writeln('Ingrese la cantidad de numeros a evaluar');
     readln(n);
     max:=-99999;
     min:=9999;


     for i:=1 to n do
         begin
              writeln('Ingrese un numero');
              readln(num);
              if (num > max) then
                 begin
                      max:=num;
                      posicion:=i;
                      ocurrencia:=1;
                 end
              else if (num = max) then
                   ocurrencia:=ocurrencia+1;

              if not (num mod 2 = 0 ) then
                 if (num < min) then
                    min:= num;


         end;

      if (min = 9999) then
         writeln('No existe numero impar')
      else
          writeln('El numero impar mas grande es: ',min);

      writeln('El numero maximo es: ',max,' aparecio ',ocurrencia,' veces,y su posicion es: ',posicion);


      readln();
end.

