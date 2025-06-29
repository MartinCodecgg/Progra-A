program ejer10;

var
  frec,pri,seg:byte;
  arch:text;

begin
     assign(arch,'datos.txt');
     reset(arch);
     readln(arch,pri);
     frec:=1;                  //En este caso nos conviene separar parte de la logica fuera del while

     while not eof(arch) do
           begin
                readln(arch,seg);
                if (pri = seg) then
                   frec:=frec+1
                else
                    begin
                         writeln('numero: ',pri,' Frecuencia :',frec);
                         frec:=1;
                    end;

                pri:=seg;
           end;
     writeln('numero: ',pri,' Frecuencia :',frec);
     readln;

     //Se presetan problemas para leer el ultimo numero, lo ideal es entender que al leer el ultimo numero, da falso el while
     //Entonces para este caso deberemos mostrar el ultimo numero fuera del while, seria lo mejor
end.

