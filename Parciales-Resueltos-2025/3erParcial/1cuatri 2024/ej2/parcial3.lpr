program parcial3;

Type
    TMAT=array[1..20,1..20] of integer;
    TVEC=array[1..20] of byte;





Procedure IngresaMatriz(Var Mat:TMAT; Var n:byte);
var
  i,j:byte;
begin
     writeln('Ingrese n'); readln(n);
     for i:=1 to n do
         for j:=1 to n do
             readln(Mat[i,j]);
end;

Procedure generarV(mat:TMAT; Var V:TVEC; n:byte; var k:byte);
var
  cont,j,i:byte;
  cumple:boolean;
begin
     k:=0;
     for j:=1 to n do
         begin
              cont:=0;
              i:=1;
              while (i<=n) and (cont<2) do
                    begin
                         if mat[i,j]=0 then
                            cont:=cont+1;
                         i:=i+1;
                    end;
              cumple:=cont=2;

              if cumple and (mat[j,j] mod 2 = 0 ) then
                 begin
                      k:=k+1;
                      V[k]:=j;
                 end;
         end;
     For i:=1 to k do
         writeln(V[k]);
end;

var
  Mat:TMat; V:TVEC; n,k:byte;
begin
     IngresaMatriz(mat,n);
     GenerarV(mat,V,n,k);
     readln;
end.
