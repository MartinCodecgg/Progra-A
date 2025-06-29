program projectinciso19;
var
   n,max:integer;
   dentroconjunto:boolean;
   arch:text;

begin
     assign(arch,'datos.txt');
     dentroconjunto:=false;
     reset(arch);
     max:=0;
     while not eoln(arch) do
           begin
           read(arch,n);
           if n < 0 then
              begin
                   dentroconjunto:=true;
                   if max <>0 then                              //Recordar que los tipo entero ignoran los caracteres vacios
                      writeln(max);

                   max:=0;
                                                              //La idea del codigo es escribir el numero mayor al caer en un numero negativo
                                                              //Por ello la primer entrada entra diferente estando dentroconjunto en false, y si justo entra en
                                                              // un numero negativo sera true
              end
           else
                    if (dentroconjunto=true) and (n>max) then
                       max:=n;
            end;
        readln();
end.
