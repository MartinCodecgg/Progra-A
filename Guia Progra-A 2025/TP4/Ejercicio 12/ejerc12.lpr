program ejerc12;

procedure mostrarSerie(cota:byte);
var
   i:byte;
   num,ant,ant2:word;
   begin
        i:=1;
        ant:=1;
        num:=1;
        while num < cota do
              begin
                   if i = 1 then
                      begin
                           write('1 ');
                           i:=i+1;
                      end
                   else if i = 2 then
                      begin
                           write('1 ');
                           i:=i+1;
                      end
                   else
                       begin
                            ant2:=num;
                            num:=ant + num;
                            write(num,' ');
                            ant:=ant2;
                       end
              end;
        writeln();
   end;

var
   n,i,cota:byte;
begin
     writeln('Ingrese el numero de cotas');
     readln(n);

     for i:=1 to n do
         begin
              writeln('Ingrese la cota');
              readln(cota);
              mostrarSerie(cota);
         end;
     readln;
end.

