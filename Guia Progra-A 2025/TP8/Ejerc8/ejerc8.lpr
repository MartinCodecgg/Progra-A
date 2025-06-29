program ejerc8;

const
     TOPN = 3; TOPM = 4;

type
    TMT = array[1..TOPN,1..TOPM] of byte;
    TV = array[1..TOPN] of byte;

Procedure ArmarVec(mt:TMT; var V:TV; n,m,tope:byte);
begin
     if (n=1) and (m=1) then
        V[1]:=mt[1,1]           //Caso Base
     else
         if m > 0 then
            begin
                 ArmarVec(mt,V,n,m-1,tope);       //Caso Recurrente
                 if mt[n,m] > V[n] then
                    V[n]:= mt[n,m]
            end
         else
             begin
                  V[n]:=0;
                  ArmarVec(mt,V,n-1,tope,tope);   //Caso Recurrente
             end;
end;

const
     mt:TMT = ((1,2,5,6),
              (4,5,9,21),
              (1,2,3,55));

var
    V:TV; i:byte; n,m:byte;
begin
     n:=3; m:=4;
     ArmarVec(mt,V,n,m,m);


     //Adicional, Muestro el vector generado
     for i:=1 to n do
         Write(V[i]:4);
     writeln;
     readln;
end.
