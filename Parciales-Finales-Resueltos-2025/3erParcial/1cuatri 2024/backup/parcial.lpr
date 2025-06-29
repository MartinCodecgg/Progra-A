program parcial;

Const
     TOP=100;
Type
    ST8=string[8]; ST30=string[30]; ST5=string[5];

    TregCan=record
      Id:ST8; gen:byte; nom:ST30; dis:char; dur:word;
    end;
    Tarchcan=file of TregCan;

    TregInter=record
      Id:ST8; nom:ST30; contrato:char;
    end;
    TarchInter=file of TregInter;

    TregVec=record
      Id:ST8; Nom:ST30;
    end;
    TVinter=array[1..TOP] of TregVec;


Procedure CrearBinario(var archInter:TarchInter; var archCan:TarchCan);
var
   arch1,arch2:text;
   regInter:TregInter;
   regCan:TregCan;
   car:char;
   i:byte;
begin
     assign(arch1,'interpretes.txt'); assign(arch2,'canciones.txt');
     reset(arch1); reset(arch2);
     rewrite(archInter); rewrite(archCan);

     while not eof(arch1) do
           begin
                readln(arch1,regInter.Id,car,regInter.nom,car,regInter.contrato);
                write(archInter,regInter);
           end;
     regInter.ID:='99999999';
     write(archInter,regInter);

     while not eof(arch2) do
           begin
                readln(arch2,regCan.Id,regCan.gen,car,regCan.nom,car,regCan.dis,regCan.dur);
                write(archCan,regCan);
           end;
     regCan.ID:='99999999';
     write(archCan,regCan);

     seek(archInter,0);
     seek(archCan,0);
     for i:=0 to filesize(archInter)-1 do
         begin
              read(ArchInter,regInter);
              writeln(regInter.Id,' ',regInter.nom,' ',car,regInter.contrato);
         end;

     writeln;

     for i:=0 to filesize(archCan)-1 do
         begin
              read(archCan,regCan);
              writeln(regCan.Id,' ',regCan.gen,' ',regCan.nom,' ',regCan.dis,' ',regCan.dur);
         end;

     close(archInter); close(archCan); close(arch1); close(arch2);

     writeln;
end;

Procedure InsertaOrd(var Vinter:TVinter; var n:byte; Id:st8; nom:st30);
var
  i:byte;
begin
     i:=n;
     while (i>0) and (Id < Vinter[i].id) do    //El archivo viene en orden ascendente por ello ordenar y buscar de forma ascendente (<)
           begin
                Vinter[i+1].Id:=Vinter[i].Id;
                Vinter[i+1].nom:=Vinter[i].nom;
                i:=i-1;
           end;
     Vinter[i+1].Id:=Id;
     Vinter[i+1].nom:=nom;
     n:=n+1;
end;

Procedure GenerarV(Var archInter:TarchInter; var Vinter:TVinter; var n:byte);
var
   regInter:TregInter; nom:ST30; Id:ST8;
   i:byte;
Begin
     reset(archInter); n:=0;
     while not eof(archInter) do
           begin
                read(archInter,regInter);
                Id:=regInter.Id;
                nom:=regInter.nom;
                if regInter.contrato='S' then
                   InsertaOrd(Vinter,n,Id,nom);
           end;
     close(archInter);
     writeln('Se Muestra Vector');
     for i:=1 to n do
         writeln(Vinter[i].id,' ',Vinter[i].Nom);
end;

Procedure CortedeControl(var archCan:TarchCan; Vinter:TVinter; n:byte; x:byte);
var
   regCan:TregCan; DurTotal:Word;
   i,contDis,contNodis,contGenX:byte;
begin
     reset(archCan); DurTotal:=0; contGenX:=0; read(archCan,regCan);
     For i:=1 to n do
         begin
              while(Vinter[i].Id<regCan.Id) and not eof(archCan) do
                    read(archCan,regCan);
              if Vinter[i].Id=regCan.Id then
                 begin
                      contDis:=0; contNodis:=0; writeln('Nombre interprete: ',Vinter[i].nom);
                 end;
              while (Vinter[i].Id = regCan.Id) and not eof(archCan) do
                    begin
                         //writeln('itera while');
                         if (regCan.gen=X) and (regCan.dis='S') then
                            writeln(regCan.nom);

                         if regCan.dis='S' then
                            contDis:=contDis+1
                         else
                           contNodis:=contNOdis+1;

                         if regCan.gen=X then
                            begin
                                 DurTotal:=DurTotal+regCan.dur;
                                 contGenX:=contGenX+1;
                            end;

                         read(archCan,regCan);
                    end;
              writeln('La cantidad de temas disponibles y no disponibles considerando todos los generos es:',contDis,' ',contNOdis,' respecticamente');
         end;
     writeln;
     Writeln(DurTotal,' ',contgenX);
     writeln('La duracion media de los temas del genero ingresado en minutos es:' ,(DurTotal div 60)/contGenX:8:2);
     close(archCan);
end;

var
  archCan:TarchCan; archInter:TarchInter; Vinter:TVinter;
  n,x:byte;
begin
     assign(archCan,'canciones.dat');
     assign(archInter,'Interpretes.dat');
     CrearBinario(archInter,archCan);

     GenerarV(archInter,Vinter,n);
     writeln('Ingrese el genero'); readln(x);
     CortedeControl(archCan,Vinter,n,X);
     readln;
end.
