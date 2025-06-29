program ejerc24;

var
   car1,car2:char;
   arch,archS:text;
   i:char;

begin
     assign(arch,'datos.txt');reset(arch);
     assign(archS,'salida.txt');rewrite(archS);
     read(arch,car1);

     repeat
                read(arch,car2);
                while (car2 <> ' ') and (car2 <> '.') do
                      begin
                           if (car1 in ['a'..'z']) and (car2 in ['0'..'9']) then
                              begin
                                   for i:='1' to car2 do
                                       begin
                                            write(archS,car1);
                                       end;
                                   car2:='*';
                              end
                           else if car1 <> '*' then
                                write(archS,car1);

                           car1:=car2;
                           read(Arch,car2);
                           if car2 = ' ' then
                              begin
                                   write(archS,car1);
                                   car1:=' '
                              end;
                      end;
     until car2 = '.';

     write(archS,car1);
     write(archS,'.');
     writeln('Process ending');
     writeln('Se escribio en el archivo:');
     close(arch);close(archS);
     reset(archS);
     while not eof(archS) do
           begin
                read(ArchS,car2);
                write(car2);
           end;
     readln;
end.
