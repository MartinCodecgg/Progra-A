// PUNTO 1)
program parcial;

const TOP=100;

type
    ST5 = string[5];
    TMT = array[1..TOP,1..TOP] of real;
    TVst5 = array[1..TOP] of st5;
    TregB = record
          cod:st5; monto:real;
    end;
    TVreg = array[1..TOP] of TregB;

Function Buscar(Vcod: TVST5; cod:st5):byte;
var
   i:byte;
begin
     i:=1;
     while cod <> Vcod[i] do
           i:=i+1;
     buscar:=i;
end;

Procedure InsertaOrd(Var Vb:TVreg; Var nb:byte; cod:st5; finde:real);
var
   i:byte;
begin
     i:=nb;
     while (i>0) and (finde < Vb[i].monto) do
           begin
                Vb[i+1]:=Vb[i];
                i:=i-1;
           end;
     Vb[i+1].monto:=finde;
     Vb[i+1].cod:=cod;
     nb:=nb+1;
end;

Function InciA(mt: TMT; n:byte):byte;
var
   i,j,posMin:byte; acum,min:real;
begin
     min:=999999;
     for i:=1 to n do
         begin
              acum:=0;
              for j:=1 to 5 do
              acum:=acum+mt[i,j];

              acum:=acum/5;
              if acum < min then
                 begin
                      min:=acum;
                      posMin:=i;
                 end;
         end;
     InciA:=posMin;
end;

Procedure Mostrar(Vb:TVreg; nb:byte);
var
   i:byte;
begin
     for i:=1 to nb do
         writeln(Vb[i].cod,' ',Vb[i].monto:8:2);   //Si muestro monto --> real
end;

Procedure LeerRubro(Var Vcod:TVST5; Var n:byte);
var
   arch:text;
begin
     assign(arch,'rubros.txt'); reset(arch); n:=0;
     while not eof(arch) do
           begin
                n:=n+1;
                readln(arch,Vcod[n]);
           end;
     close(arch);
end;

Procedure Inicializar(var mt:TMT; n:byte);
var
   i,j:byte;
begin
     for i:=1 to n do
         for j:=1 to 7 do
             mt[i,j]:=0;
end;

Procedure LeerVenta(Var mt:TMT; Vcod:TVST5; n:byte);
var
   arch:text; cod:st5; monto:real;
   dia,pos:byte;
begin
     assign(arch,'Ventas.txt'); reset(arch);
     Inicializar(mt,n);
     while not eof(arch) do
           begin
                readln(arch,cod,dia,monto);
                pos:=buscar(Vcod,cod);
                mt[pos,dia]:=mt[pos,dia] + monto;
           end;
     close(arch);
end;

Procedure InciB(mt:TMT; Vcod:TVST5; n:byte; var Vb:TVreg; Var nb:byte);
var
   x:real; i,j:byte;    acum:real;
begin
     writeln('Ingrese X'); readln(x);
     for i:=1 to n do
         begin
              acum:=0;
              for j:=1 to 7 do
                  acum:=acum+mt[i,j];

              if acum > x then
                 InsertaOrd(Vb,nb,Vcod[i],mt[i,6]+mt[i,7]);
         end;
     Mostrar(Vb,nb);
end;


var
   mt:TMT; n,nb:byte;
   Vcod:TVST5; Vb:TVreg;

begin
     LeerRubro(Vcod,n); LeerVenta(mt,Vcod,n);
     writeln('El codigo de venta con menor venta promedio en los primeros 5 dias es: ',Vcod[InciA(mt,n)]);
     InciB(mt,vcod,n,vb,nb);
     readln;
end.



{
//PUNTO 2

Program Punto2;

Const TOP= 100;

type
    TMT = array[1..3,1..3] of integer;
    Treg = record
           i,j:byte;
    end;
    TVreg = array[1..TOP] of Treg;

Function Suma(mt:TMT; i,j:byte):integer;
begin
     if j = 0 then
        suma:=0
     else
         suma:=mt[i,j] + suma(mt,i,j-1);
end;


Procedure MinFila(mt:TMT; i,j:byte; var suma:integer; var pos:byte);
begin
     //if j = 0 then
     //   suma:=0;       Al ser un procedimiento, no debo hacer el suma:=0; solo sumo mientras este en indices validos
     if j>0 then
        begin
             suma:=mt[i,j] + suma;
             if mt[i,j] < mt[i,pos] then
                pos:=j;
             minFila(mt,i,j-1,suma,pos);
        end;
end;

Procedure Generar(mt:TMT; var V:TVreg; i,m:byte; var n2:byte);
var
   pos:byte; suma:integer;
begin
     if i>0 then
        begin
             suma:=0;
             pos:=m; //Si voy a usar el mismo pos para calcular el minimo, debo asegurarme de pasarlo con un valor valido, por ej el primero que va a evaluar
             MinFila(mt,i,m,suma,pos);
             if suma > 0 then
                begin
                     n2:=n2+1;                                                 //IMPORTANTE !! Si paso un parametro y el parametro es Var en el procedimiento, debo pasar la variable con algun valor                                                                                                  //Y no solo el valor
                     V[n2].j:=pos;
                     V[n2].i:=i;
                end;
             Generar(mt,V,i-1,m,n2);
        end;
end;


var
   mt:TMT; V:TVreg; n,m,n2,i:byte;

Const
     mat:TMT = ((-9,-10,-20),
               (4,5,6),
               (7,8,9));
begin
     //carga
     mt:=mat;
     n:=3; m:=3;
     Generar(mt,V,n,m,n2);
     for i:=3 DOWNTO 1 do
         writeln(V[i].i,V[i].j:4);  //Solo dejo espacios al 2do, para separar del primero
     readln;
end.
}
