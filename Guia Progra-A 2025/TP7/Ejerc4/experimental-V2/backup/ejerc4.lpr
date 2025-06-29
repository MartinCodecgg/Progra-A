program ejerc4;          //Preguntar eficiencia

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
{
Procedure InsertaOrd2(var Vpunt:TVregPunt;var  m:byte;  nom:stm; total:byte);   //Recordar como funciona el algoritmo, no estudiar de memoria el metodo
Var                                                                              //Porque por ejemplo ahora lo tengo que adaptar con registros y cuesta
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
}

Procedure InsertaOrd(var Vpunt:TVregPunt; nom:stm; total:byte);
var
   j:byte;
begin
     j:=3;
     while (j>0) and (total >= Vpunt[j].total) do
         begin
              if j<3 then
                 Vpunt[j+1]:=Vpunt[j];
              j:=j-1;
         end;

      Vpunt[j+1].total:=total;
      Vpunt[j+1].nom:=nom;
end;

Procedure InciB(Vclub:TVregClub; n:byte);
var
   i:byte;    Vpunt:TVregpunt;
begin
     for i:=1 to 3 do
         Vpunt[i].total:=0;

     writeln(n);
    for i:=1 to n do
        InsertaOrd(Vpunt,Vclub[i].nom,Vclub[i].total);

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
