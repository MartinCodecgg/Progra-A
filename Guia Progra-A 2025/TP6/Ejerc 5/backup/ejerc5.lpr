program ejerc5;

const TOP=100;

type
    TMT = array[1..TOP,1..TOP] of real;
    TV = array[1..TOP] of word;

Function Buscar(Vcli:TV; n:byte; cli:word):byte;
var
   i:byte;
begin
     i:=1;
     while (i<n) and (cli <> Vcli[i]) do
           i:=i+1;
     if cli = Vcli[i] then
        buscar:=i
     else
         buscar:=0;
end;

Procedure Leer(var mt:TMT; var n:byte; var Vcli:TV);
var
   arch:text;
   tipo,pos,i,j:byte;
   monto:real;
   cli:word;    //Recordar que puede haber mas de 255 clientes tranquilamente
begin
     assign(arch,'datos.txt'); reset(arch);
     n:=0;
     while not eof(arch) do
           begin
                readln(arch,cli,tipo,monto);
                pos:=buscar(Vcli,n,cli);

                if pos=0 then
                   begin
                        n:=n+1;
                        writeln(cli);
                        Vcli[n]:=cli;
                        mt[n,1]:=0;
                        mt[n,2]:=0;
                        mt[n,3]:=0;
                        mt[n,4]:=0;
                        mt[n,tipo]:=monto;
                   end
                else
                    mt[pos,tipo]:=mt[pos,tipo]+ monto;
           end;
     close(arch);

     for i:=1 to n do
         begin
              for j:=1 to 4 do
                  write(mt[i,j]:8:2);
              writeln;
         end;
     writeln;
     writeln;
     for i:=1 to n do
         begin
              writeln(Vcli[i]);
         end;

end;

Procedure InciA(mt:TMT; n:byte);
var
   i,j:byte;      Vaux:TV;
begin
     for i:=1 to 4 do
         Vaux[i]:=0;

     for i:=1 to n do
         for j:=1 to 4 do
             if mt[i,j] <> 0 then
                Vaux[j]:=Vaux[j]+ 1;

     writeln('Total de compras de cada rubro');
     writeln('Supermercado: ',Vaux[1]);
     writeln('Combustible: ',Vaux[2]);
     writeln('Indumentaria: ',Vaux[3]);
     writeln('Otros: ',Vaux[4]);
end;

Procedure InciB(mt:TMT; Vcli:TV; n:byte);
var
   i,naux:byte;     Vaux:TV;
begin
     naux:=0;
     for i:=1 to n do
         if mt[i,1] > mt[i,3] then
            begin
                 naux:=naux+1;
                 Vaux[naux]:=Vcli[i];
            end;

     writeln('Los clientes que su monto en supermercado supera a indumentaria son: ');
     for i:=1 to naux do
         begin
              writeln(Vaux[i]);
         end;
end;

Function InciC(mt:TMT; n:byte):real;
var
   i,j:byte;  acum:real;
begin
     acum:=0;
     for i:=1 to n do
         for j:=1 to 4 do
             acum:=acum + mt[i,j];

     InciC:=acum/n;
end;

Function InciE(mt:TMT; n:byte):word;
var
   i,j,cont:byte;
begin
     cont:=0;
     for i:=1 to n do
         begin
              j:=1;
              while (j<4) and (mt[i,j] <> 0) do
                    j:=j+1;

              if mt[i,j] = 0 then
                 cont:=cont+1;
         end;

     InciE:=cont;
end;

var
   mt:TMT; Vcli:TV; n:byte;
begin
     Leer(mt,n,Vcli);
     InciA(mt,n);
     InciB(mt,Vcli,n);
     //Inciso C
     Writeln('El promedio de compra por cliente es de: ',InciC(mt,n):8:2);
     //Paso de hacer Inciso D
     //Inciso e
     writeln('El nro de clientes que no registraron compras en algun rubro es: ',InciE(mt,n));
     readln;
end.

