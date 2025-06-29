program ejerc21best;

var
   arch:text;
   n,maximo,contDis0,contNumeroso:byte;
   cierre1,condCierre:boolean;
begin
     condCierre:=false;
     cierre1:=false;
     contDis0:=0;
     contNumeroso:=0;
     maximo:=0;

     assign(arch,'datos.txt');
     reset(arch);
     read(arch,n);

     while not condcierre do
           begin
                if n = 0 then
                   begin
                        condCierre:=cierre1;

                        if maximo <> 0 then
                           begin
                                writeln('Maximo del subconjunto es ',maximo);
                                if contDis0 > contNumeroso then
                                   contNumeroso:=contDis0;
                           end;

                        ContDis0:=0;
                        maximo:=0;
                   end
                else
                    if n > maximo then
                       begin
                            maximo:=n;
                            contDis0:=contDis0+1;
                            if cierre1 then
                               cierre1:=false;
                       end;

                    read(arch,n);                      //Entonces si toca que la condicion de cierre es que toque dos veces seguidas un caracter
           end;                                        //lo mejor sera tener 2 boleans como este caso, si toca el caracter y es true el primer boolean
       writeln('El conjunto mas numeroso fue ',ContNumeroso);      //Se hace true el 2do boolean que es la condicion de corte
       readln;
end.
