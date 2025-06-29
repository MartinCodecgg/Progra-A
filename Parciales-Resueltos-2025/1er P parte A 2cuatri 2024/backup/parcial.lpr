program parcial;

Type st7 = string[7];

var
   arch:text;bajada,ficha,costo,max,aux:real;
   n,cant,contViajes,TotalViajes,contBaul,acumBaul,acumfichas,i:byte; PatMax,pat:st7; Baul,UsoBaul:boolean;
   equip:char;

begin
     assign(arch,'Viajes.txt');reset(arch); max:=0;
     readln(arch,N,Bajada,Ficha,costo); totalViajes:=0;
     UsoBaul:=false; contBaul:=0;
     For i:=1 to N do
         begin
              readln(arch,pat); Baul:=false; contViajes:=0;
              acumBaul:=0; acumFichas:=0;
              read(arch,cant);
              while cant <> 0 do
                    begin
                         readln(arch,equip,equip);  //Recordar que si tengo que leer un char y estan separados por espacios, debo leer el char dos veces
                         acumFichas:=acumFichas + cant;                  //Para saltearme el ñoqui
                         if equip = 'S' then
                            Begin
                                 Baul:=true;
                                 contBaul:=contBaul+1;
                                 acumBaul:=acumBaul+1;
                            end;
                         contViajes:=contViajes+1;
                         read(arch,cant);
                    end;
              readln(arch);
              aux:=(acumfichas*ficha+acumBaul*costo+contViajes*bajada);
              if aux > max then
                 begin
                      max:=aux;
                      patMax:=pat;
                      if Baul then
                         usoBaul:=true
                      else
                          usoBaul:=false;
                 end;
              writeln('Los fichas promedio por viaje fueron: ',(acumfichas/contViajes):8:2);
              totalViajes:=totalViajes + contViajes;
         end;
     writeln('Porcentaje de viajes que usaron Baul entre todos los viajes es: ',(contBaul/totalViajes)*100:8:2);
     writeln('La patente que mas recaudo es: ',PatMax);
     if usoBaul then
        writeln('Si uso Baul');
     readln;
end.
