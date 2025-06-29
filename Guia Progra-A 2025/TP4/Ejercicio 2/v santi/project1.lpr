program project1;

function fact(n:byte):word;
var
   aux:byte;i:byte;
begin
     aux:=1;
     for i:=n downto 0 do
         if i>0 then
            aux:=aux*i;
     fact:=aux;
end;

var
   n:byte;

begin
      readln(n);
      writeln(fact(n));
      readln;
end.

