program ejerc4;

const TOP= 100;

type
    stm = string[10];
    TregClub= record
            nom:stm;
            total:byte;
    end;
    TVregClub = array[1..TOP] of TregClub;
    TVregPunt = array[1..3] of TregClub;

Procedure Leer(var Vclub:TVregClub; n:byte);
var
   arch:text;   tipo:char;
   i,k,cant:byte;
begin
     assign(arch,'datos.txt'); reset(arch);

     For k:=1 to n do
           begin
                readln(arch,Vclub[k].nom);
                readln(arch,cant);
                for i:=1 to cant do
                    begin
                         readln(arch,tipo);
                         case tipo of
                         'G':Vclub[k].total:=Vclub[k].total + 3;
                         'E':Vclub[k].total:=Vclub[k].total + 1;
                         'P':Vclub[k].total:=Vclub[k].total + 0;
                         end;
                    end;

           end;
end;

Procedure Mostrar(Vclub:TVregClub; n:byte);
var
   i:byte;
begin
     for i:=1 to n do
         begin
              writeln(Vclub[i].nom);
              writeln(Vclub[i].total);
         end;
     writeln;
end;

Procedure InsertaOrd(var Vpunt:TVregPunt;var  m:byte;  nom:stm; total:byte);   //Recordar como funciona el algoritmo, no estudiar de memoria el metodo
Var
   i: Byte;
Begin
     i:=m;
     While ( i > 0 ) and (total > Vpunt[i].total ) do
           Begin
                Vpunt[i+1].total := Vpunt[i].total ;
                Vpunt[i+1].nom := Vpunt[i].nom ;
                i:=i-1;
           End;
     Vpunt[i+1].total:= total ;
     Vpunt[i+1].nom:= nom ;
     m:= m+1;

end;
                                                                                  //Porque por ejemplo ahora lo tengo que adaptar con registros y cuesta
Procedure InciB(Vclub:TVregClub; n:byte);
var
   i,m:byte;    Vpunt:TVregpunt;
begin
     m:=0;
     for i:=1 to 3 do
         Vpunt[i].total:=0;
     for i:=1 to n do
         InsertaOrd(Vpunt,m,Vclub[i].nom,Vclub[i].total);

     writeln('Los punteros de la tabla son :');
     for i:=1 to 3 do
         writeln(Vpunt[i].nom);

end;

var
   Vclub:TVregClub; n:byte;
begin
     writeln('Ingrese la cantidad de equipos');
     readln(n);
     Leer(Vclub,n);
     Mostrar(Vclub,n);
     InciB(Vclub,n);
     readln(n);
end.
