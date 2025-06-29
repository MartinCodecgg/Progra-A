
program parcial;

Const TOP = 100;

Type
    st4 = string[4];
    TMT = array[1..TOP,1..TOP] of real;
    TVST4 = array[1..TOP] of ST4;
    TVhora = array[1..24] of byte;
    TregC = record
          Zona:st4; Vhora:TVhora; nh:byte;
    end;

    TVregC = array[1..TOP] of TregC;

Function Buscar(Vzona:TVST4; cod:st4; n:byte):byte;
var
   i:byte;
begin
     i:=1;
     while (i<n) and (cod <> Vzona[i]) do
           i:= i+1;

     if Vzona[i] = cod then
        Buscar:=i
     else
         Buscar:=0;
{
Otra forma valida de recorrer pero con una iteracion de mas
     i:=1;
     while (i<=n) and (cod <> Vzona[i]) do
           i:= i+1;

     if (i=n+1) then
        Buscar:=0
     else
         Buscar:=i;

}
{
Esto ultimo no es valido ya que no valida correctamente Vzona[n]
i:=1;
while (i<n) and (cod <> Vzona[i]) do
      i:= i+1;

if i=n then
   Buscar:=0
else
    Buscar:=i;
}
end;

Procedure GenerarV(mt:TMT; i:byte; var Vaux:TVhora; var naux:byte);
var
   j:byte; max:real;
begin
     max:=-1;
     for j:=1 to 24 do
         if max < mt[i,j] then
            begin
                 naux:=1;
                 Vaux[1]:=j;
                 max:=mt[i,j];
            end
         else if max = mt[i,j] then
              begin
                   naux:=naux+1;
                   Vaux[naux]:=j;
              end;
end;

Procedure Leer(Var mt:TMT; Var Vzona:TVST4; Var n:byte);
var
   arch:text; cod:st4; hora,pos,j:byte;
begin
     assign(arch,'precios.txt'); reset(arch); n:=0;
     while not eof(arch) do
           begin
                read(arch,cod,hora);
                pos:=buscar(Vzona,cod,n);
                if pos = 0 then
                   begin
                        n:=n+1;
                        Vzona[n]:=cod;
                        for j:=1 to 24 do
                            mt[n,j]:=0;
                        readln(arch,mt[n,hora]);
                   end
                else
                    readln(arch,mt[pos,hora]);
           end;
     close(arch);
end;

Function InciA(mt:TMT; n:byte):byte;
var
   i,j,cont,posMin:byte; acum,min:real;
begin
     min:=999999;
     for i:=1 to n do
         begin
              acum:=0; cont:=0;
              for j:=1 to 24 do
                  begin
                       acum:=acum+mt[i,j];
                       if mt[i,j] <> 0 then
                          cont:=cont + 1;
                  end;
              if (acum/cont) < min then
                 begin
                      min:=acum/cont;
                      posMin:=i;
                 end;
         end;
     InciA:=posMin;
end;

Procedure InciB(mt:TMT; Vzona:TVST4; n:byte);
var
   zona:st4; hora,pos:byte; km:real;
begin
     writeln('Ingrese zona,hora,km (separe con espacios)');
     readln(zona,hora,km);
     pos:=buscar(Vzona,zona,n);
     if pos = 0 then
        writeln('La zona ingresada no existe')
     else
         begin
              if mt[pos,hora] = 0 then
                 writeln('No se brinda servicio en esa hora')
              else
                  writeln('El precio a abonar por el viaje es: ',mt[pos,hora]*km*10:8:2);
         end;
end;


Procedure InsertaOrd(Var Vc:TVregC; Var nc:byte; Vaux:TVhora; zona:st4; naux:byte);
var
   i:byte;
begin
     i:=nc;
     while (i>0) and (zona > Vc[i].zona) do
           begin
                Vc[i+1]:=Vc[i] ;
                i:=i-1;
           end;
     Vc[i+1].zona:=zona;
     Vc[i+1].Vhora:=Vaux; Vc[i+1].nh:=naux;
     nc:=nc+1;
end;

Procedure Mostrar(Vc:TVregC; nc:byte);
var
   i,j:byte;
begin
     for i:=1 to nc do
         begin
              write(Vc[i].zona,' ');
              for j:=1 to Vc[i].nh do
                  write(Vc[i].Vhora[j]:4);
              writeln;
         end;
end;

Procedure InciC(mt:TMT; Vzona:TVST4; n:byte; Var Vc:TVregC; Var nc:byte);
var
   i,j,naux:byte; Vaux:TVhora;
begin
     for i:=1 to n do
         begin
              j:=1;
              while (j<24) and (mt[i,j] <> 0) do
                    j:=j+1;
              if mt[i,j] <> 0 then
                 begin
                      generarV(mt,i,Vaux,naux);
                      InsertaOrd(Vc,nc,Vaux,Vzona[i],naux);
                 end;
         end;
     Mostrar(Vc,nc);
end;

var
   mt:TMT; Vzona:TVST4; n,nc:byte;      z1,z2:st4;
   Vc:TVregC;             car:char;
begin
     Leer(mt,Vzona,n);
     Writeln('El codigo de zona con menor precio por cuadra es: ',Vzona[InciA(mt,n)]);
     InciB(mt,Vzona,n);
     InciC(mt,Vzona,n,Vc,nc);
     readln;
end.


{
Program Punto2;

Const TOP = 3;

Type
    TMT = array[1..TOP,1..TOP] of integer;

Function Suma(mt:TMT; i,j,n:byte):integer;
var
   aux:integer;
begin
     if i=0 then
        Suma:=0
     else
         begin
              if (mt[i,j] = mt[j,i]) and (mt[i,j] > 0) then    //No hace falta la condicion de j>i porque ya la valido en el else del if con j>i+1
                 aux:=mt[i,j]                                     //Es decir en ningun momento voy a estar en la diagonal
              else
                  aux:=0;

              if j>i+1 then
                 suma:=aux + Suma(mt,i,j-1,n)
              else
                  suma:=aux + suma(mt,i-1,n,n);
         end;
end;

const
     mat:TMT= ((1,2,3),(2,3,4),(3,4,5));

var
   mt:TMT; n:byte;
begin
     //carga
     mt:=mat;
     n:=3;
     writeln('La suma es:' ,Suma(mt,n-1,n,n));
     readln;
end.
}
// De 2,15 hs Parcial , 1.30 hs parcial, 1,50 con prueba
