program ejer9;

var
   arch:text;
   ant,num:byte;
   cond:boolean;

begin
     assign(arch,'datos.txt');
     reset(arch);
     //Suponemos que los datos vienen por linea
     readln(arch,ant);
     cond:=true;

     while not eof(arch) AND cond do
           begin
                readln(arch,num);
                if (num > ant) then
                   cond:=false;

                ant:=num;
           end;
     if cond then
        writeln('Los datos vienen ordenados de forma descendente')
     else
        writeln('Los datos NO vienen ordenados de forma descendente');
     close(arch);
     readln;
end.

