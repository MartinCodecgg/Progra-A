program ejerc2;

Function recursivo(t:byte):byte;
begin
     if t=0 then
        recursivo:=1
     else if (t mod 2)=0 then
          recursivo:= 1 + recursivo(t-1)
     else
         recursivo:=recursivo(t-1);

end;

begin
     writeln(recursivo(6));
     readln;
end.
