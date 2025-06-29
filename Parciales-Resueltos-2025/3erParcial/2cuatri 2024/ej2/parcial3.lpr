program parcial3;

Type
    TMAT=array[1..20,1..20] of integer;
    TVec=array[1..20] of integer;

Procedure IngresaMatriz(var MAT:TMAT; var n,m:byte);
var
   i,j:byte;
begin
     writeln('Ingresa n y m'); readln(n,m);
     for i:=1 to n do
         for j:=1 to m do
             readln(mat[i,j]);
end;

Procedure IngresaVec(Var Prim:Tvec; var p:byte);
var
   k:byte;
begin
     writeln('Ingrese P'); readln(P);
     for k:=1 to P do
         readln(Prim[k]);
end;

Function CalculaCant(MAT:TMAT; PRIM:TVEC; n,m,p:byte):byte;
var
   cantFilas,j,i,k:byte; cond:boolean;
begin
     cantFilas:=0;
     for i:=1 to n do
         begin
              j:=1; cond:=true;
              while (j<=m) and cond do
                    begin
                         k:=1;
                         while (k<=p) and (MAT[i,j] mod PRIM[k]=0) do
                               k:=k+1;
                         if MAT[i,j] mod PRIM[k-1]<>0 then
                            cond:=false;
                         j:=j+1;
                    end;
              if cond then
                 cantFilas:=cantFilas+1;
         end;
     calculaCant:=cantFilas;
end;

var
   Mat:TMAT; PRIM:TVEC; n,m,p:byte;
begin
     IngresaMatriz(MAT,n,m);
     IngresaVec(PRIM,P);
     writeln('Hay ',CalculaCant(MAT,PRIM,n,m,p),' filas con todos sus elem multiplos de algun elem del vector');
     readln;
end.
