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

Procedure Inserta(var Vpunt:TVregPunt; nom:stm; total,pos:byte);
var
   i:byte;
begin
     for i:=3 downto pos do
         begin
              Vpunt[i+1].total:=Vpunt[i].total;
              Vpunt[i+1].nom:=Vpunt[i].nom;
         end;

     Vpunt[pos].total:=total;
     Vpunt[pos].nom:=nom;
end;

Procedure InciB(Vclub:TVregClub; n:byte);
var
   i,j:byte;    Vpunt:TVregpunt;
begin
     for i:=1 to 3 do
         Vpunt[i].total:=0;

    for i:=1 to n do
        begin
             j:=1;
             while (j<3) and (Vclub[i].total < Vpunt[j].total) do  //Si hay equipos que pueden tener el mismo puntaje entonces debo iterar por <= no <
                          j:=j+1;

             if (Vclub[i].total >= Vpunt[j].total) then
                Inserta(Vpunt,Vclub[i].nom,Vclub[i].total,j)
        end;

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
