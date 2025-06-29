program ejerc22v2;

var
   car:char;
   nroPalabraMasVocales,contVocales,contCapicuas,i:byte;
   archE,archS:text;
   palabra,palabraAlReves,palabraMasVocales:string;

begin
     assign(archE,'datos.txt');reset(archE);
     assign(archS,'salida.txt');rewrite(archS);

     nroPalabraMasVocales:=0;
     contCapicuas:=0;

     while not eof(archE) do
           begin
                read(archE,car);
                contVocales:=0;
                palabra:='';
                palabraAlreves:='';

                while (car <> ' ') and not eof(archE) do
                      begin
                           palabra:=palabra + car;
                           if car in ['a','e','i','o','u'] then
                              contVocales:=contVocales+1;

                           read(archE,car);
                      end;
                if contVocales > nroPalabraMasVocales then
                   begin
                        nroPalabraMasVocales:=contVocales;
                        palabraMasVocales:=palabra;
                   end;

                for i:=length(palabra) downto 1 do
                    palabraAlReves:=palabraAlreves + palabra[i];

                if palabra = palabraAlReves then
                   contCapicuas:=contCapicuas + 1;

                if length(palabra) > 4  then
                      writeln(archS,palabraAlreves);
           end;
     writeln('La palabra con mas cantidad de vocales de texto es: ',palabraMasVocales);
     writeln('La cantidad de palabras palindromas(capicuas) es: ',contCapicuas);
     close(archE);close(archS);
     readln;
end.
