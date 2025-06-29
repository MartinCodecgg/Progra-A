program parcial;

Const TOP = 100; precio =1;

Type
    TV = array[1..TOP] of byte;
    TVr = array[1..TOP] of real;


Function Calcular(cant,tam:byte; L:char):real;
var
   aux:real;
begin
     aux:=precio * cant;
     case L of
     'A':aux:=aux * 2;
     'B':aux:=aux * 3;
     'C':aux:=aux * 5;
     end;

     if tam = 2 then
        calcular:=aux* 1.5
     else
         calcular:=aux;
end;

Function Buscar(Vcant:TV; n,n2:byte):byte;
var
   i:byte;
begin
     i:=1;
     while(i < n) and (Vcant[i] <> n2) do
             i:=i+1;
     if Vcant[i] = n2 then
        Buscar:=i
     else
         Buscar:=0;
end;

Procedure Leer(Var Vcant,VmasL:TV; Var Vcosto:TVr; var n:byte);
var
   arch:text; car,L:char;    tam,cont,max:byte;       i:byte;
begin
     assign(arch,'datos.txt'); reset(arch); n:=0;
     while not eof(arch) do
           begin
                n:=n+1; read(arch,L,car,tam,car,car); Vcant[n]:=0; max:=0;
                while (car <> '.') and (not eof(arch)) do
                      begin
                           cont:=0;
                           while (car <> ' ') and (car <> '.') do
                                 begin
                                      cont:=cont+1; read(arch,car);
                                 end;
                           Vcant[n]:=Vcant[n] + 1;

                           if cont > max then
                              max:=cont;

                           if car <> '.' then      //Este ultimo if siempre tiene su trampita
                           read(arch,car);
                      end;
                VmasL[n]:=max;
                Vcosto[n]:=calcular(Vcant[n],tam,L);
                readln(arch);
           end;
     close(arch);

     for i:=1 to n do
         begin
              write(VmasL[i],' ',Vcosto[i]:8:2);
              writeln();
         end;
end;

Function InciA(VmasL:TV; Vcosto:TVr; n:byte):real;
var
   i,cont,max:byte; acum:real;
begin
     acum:=0;  max:=0;
     for i:=1 to n do
         begin
              if VmasL[i] > max then
                 Begin
                      max:=VmasL[i];
                      acum:=Vcosto[i]; cont:=1;
                 end
              else if VmasL[i] = max then
                 begin
                      acum:=acum + Vcosto[i];
                      cont:=cont+1;
                 end;
         end;

     InciA:=acum/cont;
end;

Procedure InciB(Vcant:TV; Vcosto:TVr; n:byte);
var
   n2,pos:byte;
begin
     writeln('Ingrese el entero');readln(n2);
     pos:=Buscar(Vcant,n,n2);
     if pos=0 then
        writeln('No existe palabra para el entero ingresado')
     else
         Writeln('El costo del folleto es: ',Vcosto[pos]:8:2);
end;

var
   Vcant,VmasL:TV; Vcosto:TVr; n:byte;

begin
     Leer(Vcant,VmasL,Vcosto,n);
     writeln('El costo del folleto con la palabra mas larga es: ',InciA(VmasL,Vcosto,n):8:2);
     InciB(Vcant,Vcosto,n);
     readln;
end.
