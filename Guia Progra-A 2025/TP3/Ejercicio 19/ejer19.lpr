program ejer19;

var
   arch:text;
   num,max:integer;
   i:byte;

begin
     assign(arch,'datos.txt');
     reset(Arch);
     num:=1;
     repeat
           read(arch,num);
           //writeln('nro: ',num);
     until (num<0);
     while not eof(arch) do
           begin
               // if (num>0) then

                max:=-1;
                read(arch,num);
                //writeln('nro: ',num);
                i:=1;
                while (num > 0 ) do
                      begin
                           if (i<>1) then
                           begin
                           read(arch,num);
                           //writeln('nro: ',num);
                           end;
                           if (num > max) then
                              max:=num;
                           i:=0;


                      end;
                if (max <> -1) then
                writeln('El maximo del conjunto de numeros es:',max);


           end;
     readln;

end.

