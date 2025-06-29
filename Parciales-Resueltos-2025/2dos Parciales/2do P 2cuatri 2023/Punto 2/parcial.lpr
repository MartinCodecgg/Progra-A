program parcial;

Const TOP = 3;

Type
    TMT = array[1..TOP,1..TOP] of byte;
    TV = array[1..TOP] of byte;

Function Informar(mt:TMT; i,j,m:byte; V:TV):Byte;
begin
     if i=0 then
        informar:=0
     else
         begin
              if mt[i,j] mod V[i] <> 0 then
                 Informar:=Informar(mt,i-1,m,m,v)
              else
                  begin
                       if j>1 then
                          informar:=informar(mt,i,j-1,m,v)
                       else
                           informar:=1+informar(mt,i-1,m,m,v);
                  end;
         end;
end;

const Mat:TMT = ((2,2,2),(4,4,4),(7,8,9));
      Vec:TV = (2,2,2);
var
   mt:TMT; V:TV; n,m:byte;
begin
     n:=3; m:=3;
     mt:=mat;
     V:=vec;
     write('La cantidad de filas que cumplen con la condicion son: ',Informar(mt,n,m,m,V));
     readln;   //15min
end.
