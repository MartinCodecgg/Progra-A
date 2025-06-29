program ejer3;

var
   i,n,rep,num,ant:byte;

begin
     writeln('Ingrese la cantidad de numeros');
     readln(n);

     writeln('Ingrese un numero');
     readln(ant);
     rep:=0;

     for i:=1 to n-1 do
         begin
              writeln('Ingrese un numero');
              readln(num);

              if (num > ant) then
                 rep:=rep + 1

              ant:=num;
         end;


     writeln('La cantidad de veces que se repitio un numero fue: ',rep);
     readln();
end.

