program parcial;

Const
     TOP=100;
Type
    ST3=string[3]; ST8=string[8]; ST20=string[20];

    TregCarr=record
      cod:ST3; fecha:ST8; cant:word;
    end;
    TarchCarr=file of TregCarr;

    TregCirc=record
      cod:ST3; nom:ST20; capacidad:word; valor:real;
    end;
    TarchCirc=file of TregCirc;

    TVcirc=array[0..TOP] of ST3;

Procedure CrearBinario(var archCarr:TarchCarr; var archCirc:TarchCirc);
var
   arch1,arch2:text;
   RCarr:TregCarr;
   Rcirc:TregCirc;
   car:char;
   i:byte;
begin
     assign(arch1,'carreras.txt'); assign(arch2,'circuitos.txt');
     reset(arch1); reset(arch2);
     rewrite(archCarr);
     rewrite(archCirc);

     while not eof(arch1) do
           begin
                readln(arch1,Rcarr.cod,car,Rcarr.fecha,Rcarr.cant);
                write(archCarr,Rcarr);
           end;
     Rcarr.cod:='999';
     write(archCarr,Rcarr);

     while not eof(arch2) do
           begin
                readln(arch2,Rcirc.cod,car,Rcirc.nom,Rcirc.capacidad,Rcirc.valor);
                write(archCirc,Rcirc);
           end;
     Rcirc.cod:='999';   //Recordar estos van con comillas porque no olvidar que son string
     write(archCirc,Rcirc);

     seek(archCarr,0);
     seek(archCirc,0);

     for i:=0 to filesize(archCarr)-1 do
         begin
              read(archCarr,RCarr);
              writeln(Rcarr.cod,' ',Rcarr.fecha,' ',Rcarr.cant);
         end;
     writeln;

     for i:=0 to filesize(archCirc)-1 do
         begin
              read(archCirc,RCirc);
              writeln(Rcirc.cod,' ',Rcirc.nom,' ',Rcirc.capacidad,' ',Rcirc.valor:8:2);
         end;

     close(arch1); close(arch2);
     close(archCarr); close(archCirc);
end;

Function Buscar(Vcirc:TVcirc; n:byte; cod:st3):byte;
var
  i:byte;
begin
     i:=0;
     while (i<n) and (Vcirc[i]<> cod) do
           i:=i+1;

     buscar:=i;
end;

Procedure GenerarV(var archCirc:TarchCirc; Var Vcirc:TVcirc);
var
   Rcirc:TregCirc;
   i:byte;
begin
     i:=0;
     reset(archCirc);
     while not eof(archCirc) do           //RECORDAR, empiezo el i en 0 y aumento el i al final del while, luego de la lectura y de la logica
           begin
                read(archCirc,Rcirc);
                Vcirc[i]:=Rcirc.cod;
                i:=i+1;
           end;

     writeln;
     for i:=0 to filesize(archCirc)-1 do
         writeln(Vcirc[i]);
     close(archCirc);
end;

Procedure Listado(var archCarr:TarchCarr; var archCirc:TarchCirc; Vcirc:TVcirc);
var
   Rcarr:TregCarr;
   Rcirc:TregCirc;
   fechaMax,ImpTotal:real;
   STfechaMax:ST20;
   ActCarr:ST3;
   pos:byte;
   totalEntradas:word;
begin
     reset(archCarr);
     reset(archCirc);
     read(archCarr,Rcarr);
     fechaMax:=0;

     while not eof(archCarr) do
           begin
                ActCarr:=RCarr.cod;
                pos:=buscar(Vcirc,filesize(archCirc)-1,ActCarr);
                writeln('pos es: ',pos);
                writeln('n es: ',filesize(archCirc)-1);
                writeln('cod es: ',ActCarr);
                seek(archCirc,pos);
                read(archCirc,RCirc);
                writeln('Nombre de ciudad: ',RCirc.nom);
                while actCarr=RCarr.cod do
                      begin
                           writeln(RCarr.fecha,' ',RCarr.cant,' ',RCirc.capacidad/RCarr.cant:8:2);

                           totalEntradas:=totalEntradas+Rcarr.cant;
                           if RCarr.cant*RCirc.valor > fechaMax then
                              begin
                                   fechaMax:=RCarr.cant*RCirc.valor;
                                   STfechaMax:=RCarr.fecha;
                              end;
                           read(archCarr,RCarr);
                      end;
                writeln('Total entradas vendidas en la ciudad: ',totalEntradas);
                ImpTotal:=totalEntradas*Rcirc.valor;
           end;
     writeln('Importe total recaudado por entradas: ',ImpTotal:8:2);
     writeln('Promedio general de entrada vendidas por ciudad: ',ImpTotal/filesize(archCarr):8:2);
     writeln('Fecha en la que se realizo la mayor recaudacion: ',STfechaMax);
     close(archCarr); close(archCirc);

end;
var
   archCarr:TarchCarr; archCirc:TarchCirc;   Vcirc:TVcirc;
begin
     assign(archCarr,'carreras.dat');
     assign(archCirc,'circuitos.dat');
     CrearBinario(archCarr,archCirc);
     GenerarV(archCirc,Vcirc);
     Listado(archCarr,archCirc,Vcirc);
     readln;
end.
