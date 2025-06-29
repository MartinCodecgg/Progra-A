program ejerc1;

const TOP = 100;     stmax = 10;

type
    stm = string[stmax];   //Para nombres usar solo 10 de longitud,
    TVstm = array[1..TOP] of stm;
    TregF = Record
          dia,mes:byte;
          anio:word;
    end;
    TVregF= array[1..TOP] of TregF;
    TV = array[1..4] of byte;


Procedure Leer(var Vfecha:TVregF; var Vnom:TVstm; var n:byte);
var
   arch:text;
begin
     assign(arch,'datos.txt'); reset(arch); n:=0;
     while not eof(arch) do
           begin
                n:=n+1;
                readln(arch,Vnom[n],Vfecha[n].dia,Vfecha[n].mes,Vfecha[n].anio);
           end;
end;

Function InciA(Vfecha:TVregF; n:byte):stm;
var
   i,max,tipoMax:byte; Vaux:TV;
begin
     for i:=1 to 4 do
         Vaux[i]:=0;
     for i:=1 to n do
         begin
              case Vfecha[i].mes of
              12,1,2:Vaux[1]:=Vaux[1]+1;
              3..5:Vaux[2]:=Vaux[2]+1;
              6..8:Vaux[3]:=Vaux[3]+1;
              9..11:Vaux[4]:=Vaux[4]+1;
              end;
         end;
     max:=0;
     for i:=1 to 4 do
         if Vaux[i] > max then
            begin
                 max:=Vaux[i];
                 tipoMax:=i;
            end;

     case tipoMax of
     1:InciA:='Verano';
     2:InciA:='Otoño';
     3:InciA:='Invierno';
     4:InciA:='Primavera';
     end;
end;

var
   Vnom:TVstm;
   Vfecha:TVregF;
   n:byte;

begin
     Leer(Vfecha,Vnom,n);
     writeln('La estacion que mas se festejan cumpleaños es: ',InciA(Vfecha,n));
     readln;
end.

