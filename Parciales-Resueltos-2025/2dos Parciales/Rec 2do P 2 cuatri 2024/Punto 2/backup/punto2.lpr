program punto2;

Const TOP=4;

Type
    TMT = array[1..TOP,1..TOP] of byte;

Procedure Indice(mt:TMT; i,j,n,elem:byte; var pos:byte);
begin
     if j>0 then
        begin
             if (mt[i,j] > elem ) and (mt[i,j] mod 2 <> 0) then
                begin
                     elem:=mt[i,j];
                     pos:=i;
                end;
             if i>1 then
                Indice(mt,i-1,j,n,elem,pos)
             else
                 Indice(mt,n,j-2,n,elem,pos);
        end;
end;


const
     mat:TMT = ((12,4,7,8),
               (5,14,9,2),
               (10,13,6,7),
               (1,1,11,4));

var
    mt:TMT;      n,m,pos:byte;

begin
     mt:=mat;
     n:=4;
     m:=4;
     if (m mod 2) <> 0 then
        m:=m-1;
     pos:=0;
     Indice(mt,n,m,m,0,pos);
     //Si pos se mantiene en cero es porque ningun elemento cumple la condicion
     if pos = 0 then
        writeln('Ningun elemento cumple la condicion')
     else
         writeln('El indice es ',pos);
     readln;
end.
