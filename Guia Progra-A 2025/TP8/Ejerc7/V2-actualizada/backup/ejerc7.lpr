program ejerc7;

const
     TOP = 3;

type
    TMT = array[1..TOP,1..TOP] of byte;

Function Min(mt:TMT; i,j,m:byte):byte;
var
   aux:byte;
begin
     if (i=1) and (j=1) then    //Caso base
        Min:=mt[i,j]
     else
         begin
              if j>1 then
                 aux:=Min(mt,i,j-1,m)
              else
                  aux:=Min(mt,i-1,m,m);

              if mt[i,j] > aux then
                 Min:=mt[i,j]
              else
                  min:=aux;
         end;
end;

const
     mt:TMT = ((5,3,3),
              (4,5,6),
              (7,8,9));
var
   n:byte;
begin
     n:=TOP;
     writeln('El elemento minimo de la matriz es: ',Min(mt,n,n,n));
     readln;
end.
