program ejerc20;

var
   arch:text;
   cont:byte;
   acum:word;
   num:integer;
   dentroConjunto:boolean;

begin
     assign(arch,'datos.txt');
     reset(arch);
     acum:=0;cont:=0;
     dentroConjunto:=false;

     while not eof(arch) do
           begin
                read(arch,num);
                if (num<0) then
                   begin
                        dentroConjunto:=true;
                        if (cont>0) and (acum>0) then
                                write((acum/cont):8:2);
                        acum:=0;
                        cont:=0;
                   end

                else if dentroConjunto and (num>0) then
                     begin
                          cont:=cont+1;
                          acum:=acum+num;
                     end;

           end;
     readln();
end.

