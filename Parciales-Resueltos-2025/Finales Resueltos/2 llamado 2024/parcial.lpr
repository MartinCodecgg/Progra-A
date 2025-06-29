program parcial;

Type
    ST20=string[20];

    TregBod=record
      Nom:ST20; Varied:word; zona,comer:byte; cant:word;
    end;

    TarchBod=file of TregBod;

    TregHis=record
      nom:ST20; CantG,cantF:word;
    end;
    TarchHis=file of TregHis;

    TVzona=array[0..99]of word;

Procedure CrearBinarios(var archHis:TarchHis; var archBod:TarchBod);
var
   arch1,arch2:text;
   regBod:TregBod;
   regHis:TregHis;
   i:byte;
begin
     assign(arch1,'bodegas.txt'); assign(arch2,'historia.txt');
     reset(arch1); reset(arch2);
     rewrite(archHis); rewrite(archBod);

     while not eof(arch1) do
           begin
                readln(arch1,regBod.Nom,regBod.Varied,regBod.zona,regBod.comer,regBod.cant);
                write(archBod,regBod);
           end;
     regBod.Nom:='99999999999999999999';
     write(archBod,regBod);

     while not eof(arch2) do
           begin
                readln(arch2,regHis.nom,regHis.cantG,regHis.cantF);
                write(archHis,regHis);
           end;

     regHis.Nom:='99999999999999999999';
     write(archHis,regHis);

     writeln('Mostrando archivos binarios');
     writeln;
     seek(archBod,0); seek(archHis,0);
     for i:=0 to filesize(archBod)-1 do
         begin
             read(archBod,regBod);
             writeln(regBod.Nom,' ',regBod.Varied,' ',regBod.zona,' ',regBod.comer,' ',regBod.cant);
         end;
     writeln;

     for i:=0 to filesize(archHis)-1 do
         begin
              read(archHis,regHis);
              writeln(regHis.nom,' ',regHis.cantG,' ',regHis.cantF);
         end;
     writeln;
     close(arch1); close(arch2); close(archBod); close(ArchHis);

end;

Procedure InicializaVzona(Var Vzona:TVzona);
var
   i:byte;
begin
     for i:=0 to 99 do
         Vzona[i]:=0;
end;

Function HallarZonaMax(Vzona:TVzona):shortint;
var
   i:byte; max:shortint; maxBot:word;
begin
     max:=-1; //no es necesario en realidad, ya esta abajo
     maxBot:=0;
     for i:=0 to 99 do
         begin
              if Vzona[i]>maxBot then
                 begin
                      maxBot:=Vzona[i];
                      max:=i;
                 end
              else if Vzona[i]=maxBot then
                   max:=-1;

         end;
     HallarZonaMax:=max;
end;

Procedure Enfrenta(var archBod:TarchBod; var archHis:TarchHis);
var
   regBod:TregBod; regHis:TregHis;
   totGranel,totFracc,Ggranel,Gfracc:word;
   Vzona:TVzona; archTemp:TarchHis; aux:shortint;
   actBod:ST20; actVaried:byte;
begin
     reset(archBod); reset(archHis); read(archBod,regBod);
     writeln('Produccion de litros 2024'); read(archHis,regHis);
     assign(archTemp,'Temp.dat');
     rewrite(archTemp);

     while not eof(archBod) do
           begin
                ActBod:=regBod.nom;
                writeln(ActBod);
                writeln('Variedad Total Litros a granel  Total Botellas fraccionadas');
                Gfracc:=0;Ggranel:=0;
                while ActBod=regBod.nom do
                      begin
                           ActVaried:=regBod.Varied; totGranel:=0;
                           write(ActVaried,' '); //Recordar poner un espacio al final si hago un write solo
                           totFracc:=0;
                           InicializaVzona(Vzona);
                           while (ActVaried = regBod.Varied) and (ActBod=regBod.nom) do
                                 begin
                                      if regBod.comer=1 then
                                         totGranel:=totGranel+regBod.cant
                                      else
                                          begin
                                               totFracc:=totFracc+regBod.cant;
                                               Vzona[regBod.zona]:=Vzona[regBod.zona] + regBod.cant;
                                          end;
                                      read(archBod,regBod);
                                 end;
                           write(totgranel,' ',totFracc);
                           Ggranel:=Ggranel+totgranel;
                           Gfracc:=Gfracc+totFracc;
                      end;
                writeln;  //Recordar luego de hacer write, cuando ya terminan todos estos, meto un writeln para mostrar bien
                while (regHis.nom<ActBod) and not eof(archHis) do
                      begin
                           write(archTemp,regHis);
                           read(archHis,regHis);
                      end;
                if regHis.nom=actBod then
                   begin
                        regHis.cantG:=regHis.cantG+Ggranel;
                        regHis.cantF:=regHis.cantF+Gfracc;
                        write(archTemp,regHis);
                        read(archHis,regHis);
                        //read(archBod,regBod);   SI LO LEO EN EL CORTE DE CONTROL NO LO LEO EN EL ENFRENTAMIENTO
                   end
                else
                    begin
                         regHis.nom:=regBod.nom;
                         regHis.cantF:=Gfracc;
                         regHis.cantG:=Ggranel;
                         write(archTemp,regHis);
                         //read(archBod,regBod);  SI LO LEO EN EL CORTE DE CONTROL NO LO LEO EN EL ENFRENTAMIENTO
                    end;

                aux:=hallarZonaMax(Vzona);
                if aux>=0 then
                   writeln('La zona de mayor produccion es: ',aux)
                else
                    writeln('No existe zona con mayor produccion que todas las demas');
           end;
     regHis.nom:=regBod.nom;
     write(archTemp,regHis);
     close(archTemp);close(archBod);close(archHis);
     erase(archHis); rename(archTemp,'Historia.dat');
     //Recordar este orden: 1) GRABO CENTINELA 2) CIERRO A TODOS 3) BORRO ORIGINAL 4) RENOMBRO TEMPORAL
end;

var
   archBod:TarchBod; archHis:TarchHis;
begin
     assign(archBod,'Bodegas.dat');
     assign(archHis,'Historia.dat');
     CrearBinarios(archHis,archBod);
     Enfrenta(archBod,archHis);
     readln;
end.
