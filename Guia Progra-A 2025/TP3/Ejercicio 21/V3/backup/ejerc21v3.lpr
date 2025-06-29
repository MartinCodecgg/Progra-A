program ejerc21v3;

var
   arch:text;
   num,max,contDis0,contNumeroso,i:byte;

begin
     assign(arch,'datos.txt');
     reset(arch);
     contNumeroso:=0;
     i:=0;
     max:=1;
     read(arch,num);

     while max <> 0 do
           begin
                max:=0;
                contDis0:=0;
                while num <> 0 do
                      begin
                           if (num > max)  then
                              max:=num;
                           contDis0:=contDis0 + 1;

                           read(arch,num);
                      end;
                if max <> 0 then   //En el write que va fuera del while anidado, debemos verificar si es necesario poner un if que valide
                writeln('El maximo del subconjunto es: ',max);                                               //las condiciones de los while
                if (contDis0 > contNumeroso) and (num = 0) then
                begin
                   contNumeroso:=contDis0;
                   i:=i + 1;
                end;
                read(arch,num);  //Ya en si, si ponemos un while con un primer read fuera del el, deberemos poner otro read al final del while
           end;                     //Esto se cumple siempre, ya sea si hay un ciclo anidado que usa otro read o no
     if i <> 0 then
     writeln('El orden del subconjunto mas numeroso es: ',i);
     readln;
end.
