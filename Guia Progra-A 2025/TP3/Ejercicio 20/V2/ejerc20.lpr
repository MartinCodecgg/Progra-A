program ejerc20;

var
   num:integer;
   arch:text;
   cont:byte;
   acum:word;

begin
     assign(arch,'datos.txt');
     reset(arch);
     read(arch,num);

     while num > 0 do
           read(arch,num);

     while not eof(arch) do
           begin
                read(arch,num);
                cont:=0;
                acum:=0;
                while (num > 0) do
                      begin
                           acum:=acum + num;
                           cont:=cont + 1;
                           read(arch,num);
                      end;
                if (cont > 0) and (num < 0) then
                   writeln('El promedio del subconjunto es: ',(acum/cont):8:2);
           end;
     readln;
end.
