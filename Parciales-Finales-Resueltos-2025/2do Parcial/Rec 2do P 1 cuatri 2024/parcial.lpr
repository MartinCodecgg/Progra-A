program parcial;

Const TOP=100;

Type
    ST5 = string[5];
    TMT=array[1..TOP,1..TOP] of word;
    TregInt= record
             nom:ST5; gen:byte;
    end;
    TVreg=array[1..TOP] of TregInt;
    TVaux=array[1..6] of byte;

Procedure Leer(var mt:TMT; var Vint:TVreg; var n,m:byte);
var
   arch:text; s:char;    i,j:byte;
begin
     assign(arch,'ranking.txt');reset(arch);
     readln(arch,n); m:=0;
     while not eof(arch) do
           begin
                read(arch,Vint[m+1].nom,Vint[m+1].gen);
                for i:=1 to N do
                    read(arch,mt[i,m+1]);
                readln(arch,s,s);
                if S='S' then
                   m:=m+1;
           end;
     close(arch);

     writeln(n,' ',m);
     for i:=1 to n do
         begin
              for j:=1 to m do
                  begin
                       write(mt[i,j]:4);
                  end;
              writeln;
         end;

     writeln;

     for i:=1 to m do
         writeln(Vint[i].nom,'  ',Vint[i].gen);

end;

Function InciA(mt:TMT; n,m:byte; T:Word):byte;
var
   j,i,cont:byte;
begin
     cont:=0;
     for j:=1 to m do
         begin
              i:=1;
              while (i<n) and (mt[i,j]>T) do
                    i:=i+1;
              if mt[i,j] > T then
                 cont:=cont+1;
         end;
     InciA:=cont;
end;

Procedure Mostrar(Vint2:TVreg; nb:byte);         //Falto en el original
var
   i:byte;
begin
     writeln('Mostrando');
     for i:=1 to nb do
         writeln(Vint2[i].nom,' ',Vint2[i].gen);
end;

Function Promedio(mt:TMT; N,M:BYTE):real;
var
   i,j:byte;  acum:word;
begin
     acum:=0;
     for i:=1 to n do
         for j:=1 to m do
             acum:=acum+mt[i,j];
     writeln(acum,' ',n,' ',m);
     promedio:=acum/(n*m);
end;

Function MaxDur(mt:TMT; n,j:byte):byte;
var
   i,posmax:byte; max:word;
begin
     max:=0;
     for i:=1 to n do
         if mt[i,j] > max then
            begin
                 max:=mt[i,j];
                 posMax:=i;
            end;
     MaxDur:=posMax;
end;

Procedure InciB(Vint:TVreg; mt:TMT; n,m:byte; var Vint2:TVreg; Var nb:byte);
var
   j:byte;   prom:real;  mayorDur:word;
begin
     prom:=Promedio(mt,n,m); nb:=0;
     writeln(prom:8:2);
     for j:=1 to m do
         begin
              mayorDur:=maxDur(mt,n,j);
              writeln(mayorDur);
              if mt[mayorDur,j] > prom then
                 begin
                      writeln('itera');
                      nb:=nb+1;
                      Vint2[nb]:=Vint[j];
                 end;
         end;
     mostrar(Vint2,nb);
end;

Procedure InciC(Vint:TVreg; m:byte);
var
   Vaux:TVaux; j:byte;
begin

     for J:=1 to 6 do
         Vaux[j]:=0;
     for j:=1 to m do
         Vaux[Vint[j].gen]:=Vaux[Vint[j].gen] + 1;

     for j:=1 to 6 do
         writeln('Del genero ',j,' hay ',Vaux[j],' Canciones');
end;

var
   mt:TMT; n,m,nb:byte; T:word;
   Vint,Vint2:TVreg;
Begin
     Leer(mt,Vint,n,m);
     writeln('Ingrese T'); readln(T);
     Writeln(InciA(mt,n,m,T),' superan en todos sus canciones el tiempo ingresado');
     InciB(Vint,mt,n,m,Vint2,nb);
     InciC(Vint,m);
     readln;
end.
