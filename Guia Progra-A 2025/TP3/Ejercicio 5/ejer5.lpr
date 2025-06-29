program ejer5;

var
  k,q:word;
  i:byte;

begin
     writeln('Ingrese k y q a continuacion');
     readln(k,q);

     //Supongo que este ejercicio fue pensado para usar un while del tipo , while (num < q) do  , y num:=k*i, pero de esta forma es mas eficiente
     for i:=1 to (q div k -1) do   //parentesis no necesario, se le resta 1 para asegurarse que sea menor a q
         begin
              writeln(k*i);
         end;

     readln();
end.

