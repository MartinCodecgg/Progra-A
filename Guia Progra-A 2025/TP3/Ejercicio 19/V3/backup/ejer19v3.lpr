program ejer19V3;

var
   num,max:integer;
   arch:text;

begin
     assign(arch,'datos.txt');
     reset(arch);
     read(arch,num);

     while num > 0 do     //Salteo los primeros numeros porque no me interesan, seria mejor un
           read(arch,num);

     while not eof(arch) do
           begin
                read(arch,num);     //Siempre un while con la condicion principal y otro que itere sobre el caso mas probable
                max:=-1;
                while (num > 0) do
                      begin
                           if num > max then   //Considerar siempre en estos casos si tengo un while que valida una condicion, primero evaluo la condicion
                              max:=num;          //Y luego recien leo otra vez el archivo
                           read(arch,num);
                      end;
                if (max > 0) and (num < 0) then    // tambien podria haber puesto and not eof arch, aunque queda mejor con el numero negativo
                   writeln('El maximo del subconjunto es: ',max);     //Porque justamente el numero negativo delimita el conjunto
           end;
     readln;
end.

