program parcial;

Const TOP = 100;

Type
    ST3 = string[3];
    TMT = array[1..TOP,1..TOP] of real;
    TregA = record
          cod:ST3; Costo:real;
    end;
    TVregA = array[1..TOP] of TregA;

Function Buscar(V:TVregA; aero:st3):byte;
var
   i:byte;
begin
     i:=1;
     while aero <> V[i].cod do
           i:=i+1;
     buscar:=i;
end;

Procedure Mostrar(Va:TVregA; na:byte);
var
   i:byte;
begin
     for i:=1 to na do
         writeln(Va[i].cod,' ',Va[i].costo:8:2);
end;

Procedure LeerAero(Var Vaero:TVregA; var n:byte);
var
   arch:text;
begin
     assign(arch,'aeropuertos.txt'); reset(arch); n:=0;
     while not eof(arch) do
           begin
                n:=n+1;
                readln(arch,Vaero[n].cod,Vaero[n].costo);
           end;
     {
     for i:=1 to n do
         write(Vaero[i].costo:8:2);
     writeln;
     }
     close(arch);
end;

Procedure Inicializar(var mt:TMT; n:byte);
var
   i,j:byte;
begin
     for i:=1 to n do
         for j:=1 to n do
             mt[i,j]:=0;
end;

Procedure LeerVuelo(var mt:TMT; n:byte; Vaero:TVregA);
var
   arch:text; origen,dest:ST3;  car:char;
begin
     assign(arch,'Vuelos.txt'); reset(arch);
     Inicializar(mt,n);
     while not eof(arch) do
           readln(arch,origen,car,dest,mt[buscar(Vaero,origen),buscar(Vaero,dest)]);

     close(arch);
end;

Procedure InciA(mt:TMT; n:byte; Vaero:TVregA; var Va:TVregA; var na:byte);
var
   k,i,j,cont:byte; acum,x:real;
begin
     writeln('Ingrese X'); readln(x); na:=0;
     for k:=1 to n do
         begin
              if Vaero[i].costo < X then
                 begin
                      acum:=0; cont:=0;
                      for j:=1 to n do
                          begin
                               if mt[k,j] <> 0 then
                                  begin
                                       acum:=acum + mt[k,j];
                                       cont:=cont +1;
                                  end;
                          end;
                      for i:=1 to n do
                          begin
                               if mt[i,k] <> 0 then
                                  begin
                                       acum:=acum + mt[i,k];
                                       cont:=cont +1;
                                  end;
                          end;
                      na:=na+1;
                      Va[na].cod:=Vaero[k].cod;
                      Va[na].costo:=acum/cont;
                 end;
         end;
     Mostrar(Va,na);
end;

Procedure InciB(mt:TMT; n:byte; Vaero:TVregA);
var
   origen,destino:ST3;  C,aux,directo:real;
   j,posO,posD:byte;   car:char;
begin
     writeln('Ingrese Origen,Destino y costo');
     readln(origen,car,destino,c);

     posO:=Buscar(Vaero,origen);
     posD:=Buscar(Vaero,destino);
     directo:=C * mt[posO,posD] + Vaero[posO].costo + Vaero[posD].costo;

     j:=1; aux:=directo;
     while (j<=n) and (aux >= directo) do
           begin
                writeln('aux es',aux);
                if (mt[posO,j] <> 0) and (j<>posD) and (mt[j,posD]<>0) then
                   aux:=C*(mt[posO,j]+mt[j,posD]) + Vaero[posO].costo + Vaero[j].costo + Vaero[posD].costo;

                j:=j+1;
           end;
     if directo <= aux then
        writeln('El precio del vuelo directo es: ',directo:8:2)
     else
         writeln('El codigo de la escala es: ',j-1,' El precio final es :', aux:8:2);
end;

var
     mt:TMT; n,na:byte;
     Vaero,Va:TVregA;
begin
     LeerAero(Vaero,n);
     LeerVuelo(mt,n,Vaero);
     InciA(mt,n,Vaero,Va,na);
     InciB(mt,n,Vaero);
     readln;
end.
