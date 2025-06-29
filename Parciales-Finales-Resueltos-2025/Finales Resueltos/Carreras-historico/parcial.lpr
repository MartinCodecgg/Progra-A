program parcial;

Type
    ST5=string[5]; ST20=string[20];
    TRcarr=record
      esc:ST5; pilot:ST20; tiempo:word;
    end;
    TAcarr=file of TRcarr;

    TRhis=record
      esc:ST5; cant:byte; tiempo:real;
    end;

    TAhis=file of TRhis;


//Ignorar
Procedure CrearBinario(var Acarr:TAcarr; var Ahis:TAhis);
var
   arch1,arch2:text;
   Rcarr:TRcarr; Rhis:TRhis;
   car:char;
   i:byte;
begin
     assign(arch1,'carreras.txt'); assign(arch2,'historico.txt');
     reset(arch1); reset(arch2);
     rewrite(Acarr); rewrite(Ahis);

     while not eof(arch1) do
           begin
                readln(arch1,Rcarr.esc,car,Rcarr.pilot,Rcarr.tiempo);
                write(Acarr,Rcarr);
           end;
     Rcarr.esc:='ZZZZZ';  //El centinela que agrego debe ser ZZZZ... si es un string y no 99999...
     write(Acarr,Rcarr);

     while not eof(arch2) do
           begin
                readln(arch2,Rhis.esc,Rhis.cant,Rhis.tiempo);
                write(Ahis,Rhis);
           end;
     Rhis.esc:='ZZZZZ';
     write(Ahis,Rhis);

     seek(Acarr,0);
     seek(Ahis,0);

     for i:=0 to filesize(Acarr)-1 do
         begin
              read(Acarr,Rcarr);
              writeln(Rcarr.esc,' ',Rcarr.pilot,' ',Rcarr.tiempo);
         end;
     writeln;
     for i:=0 to filesize(Ahis)-1 do
         begin
              read(Ahis,Rhis);
              writeln(Rhis.esc,' ',Rhis.cant,' ',Rhis.tiempo:8:2);
         end;
     writeln;
end;

Procedure Enfrenta(var Acarr:TAcarr; var Ahis:TAhis);
var
   Rcarr:TRcarr; Rhis:TRhis; ActCarr:ST5;
   Atemp:TAhis; cantGan,posMejorTime,i:byte;
   MejorTime,AcumTime:word;
begin
     assign(Atemp,'Temp.dat');
     reset(Acarr);
     reset(Ahis);                                                //es un minimo!!
     rewrite(Atemp); read(Acarr,Rcarr); read(Ahis,Rhis);MejorTime:=65000; i:=0;

     while not eof(Acarr) do  //Primero hago corte de control para generar el resumen y luego recien enfrento
           begin
                ActCarr:=Rcarr.esc; CantGan:=0; AcumTime:=0;

                while ActCarr=Rcarr.esc do
                      begin
                           AcumTime:=AcumTime+Rcarr.tiempo;
                           CantGan:=CantGan+1;
                           if Rcarr.tiempo<MejorTime then  //MEJOR TIME ES UN MINIMO!!
                              begin
                                   MejorTime:=Rcarr.tiempo;
                                   posMejorTime:=i;
                              end;
                           i:=i+1;
                           read(Acarr,Rcarr);
                      end;
                                    //Se usa en el enfrentamiento ActCarr y no Rcarr.esc

                //Una vez que toco otra escuderia, ya tengo hecho el resumen y procedo a enfrentar
                while (Rhis.esc<ActCarr) and not eof(Ahis) do   //En este caso solo escribo y no toco el resumen
                      begin
                           //Se usa while porque pueden ser varios los que tengo que pasar
                           write(Atemp,Rhis);
                           writeln('La escuderia: ',Rhis.esc, ' No gano ninguna carrera en el ultimo anio');
                           writeln('Itera while: ',i);
                           read(Ahis,Rhis);
                      end;
                if Rhis.esc=ActCarr then   //Modificacion
                   begin
                        Rhis.cant:=Rhis.cant+cantGan;
                        if AcumTime/cantGan<Rhis.tiempo then
                           Rhis.tiempo:=AcumTime/cantGan;
                        write(Atemp,Rhis);
                        read(Ahis,Rhis);
                   end
                else                       //Alta
                    begin
                         Rhis.cant:=CantGan;
                         Rhis.tiempo:=AcumTime/CantGan;
                         Rhis.esc:=ActCarr;
                         write(Atemp,Rhis);
                    end;
           end;
     Rhis.esc:=Rcarr.esc;
     write(Atemp,Rhis);  //Grabo centinela
     seek(Acarr,posMejorTime);
     read(Acarr,Rcarr);
     writeln('El nombre del piloto que ha tenido el mejor tiempo en el ultimo anio fue: ',Rcarr.pilot,' ,Pertenece a la escuderia ',Rcarr.esc);
     close(Ahis); close(Atemp); close(Acarr);
     erase(Ahis); rename(Atemp,'Historico.dat');



     //ADICIONAL MUESTRO ACTUALIZADO
     reset(Atemp);
     writeln;
     for i:=0 to filesize(ATemp)-1 do
         begin
              read(Atemp,Rhis);
              writeln(Rhis.esc,' ',Rhis.cant,' ',Rhis.tiempo:8:2);
         end;
     close(Atemp);
end;

var
   Acarr:TAcarr; Ahis:TAhis;
begin
     assign(Acarr,'carreras.dat');
     assign(Ahis,'historico.dat');
     CrearBinario(Acarr,Ahis); //Ignorar
     Enfrenta(Acarr,Ahis);
     readln;
end.
