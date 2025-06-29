program punto2;

const TOP = 3;

Type
    TMT = array[1..TOP,1..TOP] of byte;
    TV = array[1..TOP] of byte;


Procedure Generar(mt:TMT; Var V:TV; i,j,n,posMax:byte; Var nv:byte);
begin
     if j>0 then
        begin
             if mt[i,j] mod 2 <> 0 then
                generar(mt,V,n,j-1,n,n,nv)
             else
                 begin
                      if mt[i,j] > mt[posMax,j] then
                         posMax:=i;

                      if i>1 then
                         generar(mt,V,i-1,j,n,posMax,nv)
                      else
                          begin
                               nv:=nv+1;
                               V[nv]:=mt[posMax,j];  //Pense que pedia la posicion, por ello fui llevando la posicion
                               generar(mt,V,n,j-1,n,n,nv);
                          end;
                 end;
        end;
end;

const
     Mat:TMT = ((1,2,4),
                (4,6,4),
                (7,8,4));

var
   mt:TMT; V:TV; n,m,nv,i:byte;
begin
     n:=3;
     m:=3;
     nv:=0;
     mt:=mat;
     Generar(mt,v,n,m,m,n,nv);
     writeln('nv es :',nv);
     for i:=1 to nv do
         writeln(V[i]);
     readln;
end.
