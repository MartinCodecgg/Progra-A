program punto2;

Const TOP=4;

Type
    TMT = array[1..TOP,1..TOP] of byte;

Function Indice(mt:TMT; i,j,n,pos,elem:byte):byte;
begin
     if j=0 then
        begin
             if elem=0 then
                indice:=0
             else
                 indice:=pos;
        end
     else
         begin
              if (mt[i,j]>elem) and (mt[i,j] mod 2 <> 0) then
                 begin
                      elem:=mt[i,j];
                      pos:=i;
                 end;
              if i>1 then
                 indice:=indice(mt,i-1,j,n,pos,elem)
              else
                  indice:=Indice(mt,n,j-2,n,pos,elem);
         end;
end;

const
     mat:TMT = ((12,4,2,2),
               (5,2,2,2),
               (10,2,6,2),
               (1,14,10,2));

var
    mt:TMT;      n,m,aux:byte;

begin
     mt:=mat;
     n:=4;
     m:=4;
     if (m mod 2) <> 0 then
        m:=m-1;

     aux:= Indice(mt,n,m,m,0,0);
     if aux = 0 then
        writeln('Ningun elemento cumple la condicion')
     else
         writeln('El indice es ',aux);
     readln;
end.
