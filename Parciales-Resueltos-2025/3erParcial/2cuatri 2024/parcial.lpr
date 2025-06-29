program parcial;

const
     MAX=100; TOP=100;
Type
    ST8=string[8]; STMAX=string[MAX];
    TregTrab=record
      fecha:ST8; tipo:byte; color,tam:char;
    end;
    TarchTrab=file of TregTrab;

    TVdescrip=array[0..TOP] of STMAX;

Procedure Descripciones(var Vdescrip:TVdescrip);
var
   arch:text;
   n:byte;
begin
     assign(arch,'Descripciones.txt');
     reset(arch);
     n:=0;
     while not eof(arch) do
           begin
                n:=n+1;
                readln(arch,Vdescrip[n]);
           end;
     close(arch);
end;

Function CalculaCosto(Tipo:byte; tam:char):real;
var
   aux:real;
begin
     aux:=1500;
     case tipo of
     20..35:aux:=aux*1.10;
     36..50:aux:=aux*1.25;
     end;

     if tam='m' then
        aux:=aux*1.05
     else if tam='g' then
          aux:=aux*1.15;

     CalculaCosto:=aux;
end;

Procedure CortedeControl(var archTrab:TarchTrab; Vdescrip:TVdescrip);
var
   regTrab:TregTrab; ActTipo,contColor:byte; costo:real;
   strFecha:ST8;
   ActFecha:ST8; Tchico,Tmed,Tgran,TotalImpresos,FechaMax:word;
begin
     reset(archTrab);
     read(archTrab,regTrab);
     FechaMax:=0;

     while not eof(archTrab) do
           begin
                actFecha:=regTrab.fecha;
                writeln('Fecha: ',actFecha);

                while actFecha=regTrab.fecha do
                      begin
                           actTipo:=regTrab.tipo; totalImpresos:=0; contColor:=0;
                           Tchico:=0; Tmed:=0; Tgran:=0; costo:=0;
                           write('Tipo Impreso Tchico Tmediano Tgrande costo');
                           while (actTipo=regTrab.tipo) and (actFecha=regTrab.fecha) do
                                 begin
                                      case regTrab.tam of
                                      'c':Tchico:=Tchico+1;
                                      'm':Tmed:=Tmed+1;
                                      'g':Tgran:=Tgran+1;
                                      end;
                                      costo:=costo+CalculaCosto(actTipo,regTrab.tam);
                                      totalImpresos:=totalImpresos+1;
                                      if regTrab.color='s' then
                                           contColor:=contColor+1;
                                 end;
                           write(Vdescrip[regTrab.tipo], ' ');
                           write(Tchico,' ',Tmed,' ',Tgran,' ',costo:8:2);
                      end;
                writeln('Porcentaje color sobre el total de impresos de la fecha: ',(contColor/totalImpresos)*100:8:2);
                if totalImpresos>FechaMax then
                     begin
                          FechaMax:=TotalImpresos;
                          StrFecha:=actFecha;
                     end;
           end;
     writeln('Fecha con mayor cantidad de impresos: ',StrFecha);
     close(archTrab);
end;

var
   archTrab:TarchTrab; Vdescrip:TVdescrip;
begin
     assign(archTrab,'Trabajos.dat');
     Descripciones(Vdescrip);
     CortedeControl(archTrab,Vdescrip);
end.
