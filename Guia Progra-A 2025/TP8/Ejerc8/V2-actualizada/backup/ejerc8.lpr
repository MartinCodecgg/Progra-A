program ejerc8;

const
     TOPN = 3; TOPM = 4;

type
    TMT = array[1..TOPN,1..TOPM] of byte;
    TV = array[1..TOPN] of byte;

Procedure MaxFila(mt:TMT; i,j,m,max:byte; Var V:TV);
begin
     if i>0 then
        begin
             if mt[i,j] > max then
                max:=mt[i,j];

             if j>1 then
                MaxFila(mt,i,j-1,m,max,V)
             else
                 begin
                      V[i]:=max;
                      MaxFila(mt,i-1,m,m,0,V);
                 end;
        end;
end;

const
     mt:TMT = ((1,2,5,6),
              (4,5,9,21),
              (1,2,3,55));

var
    V:TV; i,n,m:byte;
begin
     n:=3; m:=4;
     MaxFila(mt,n,m,m,0,V);

     //Adicional, Muestro el vector generado
     for i:=1 to n do
         Write(V[i]:4);
     writeln;
     readln;
end.
