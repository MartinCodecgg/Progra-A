program xd3;

var
  arch:text;
  i,ult:word;
  espacios:string;

begin
     assign(arch,'salida3.txt');
     rewrite(arch);

     writeln(arch,'if (number = 0) then'+ #13#10 + '    writeln(''El numero es: '',number)');
     writeln('if (number = 0) then'+ #13#10 + '    writeln(''El numero es: '',number)');

     writeln(arch,'Else'+#13#10+'    Begin'+#13#10+'         if (number = 1) then'+ #13#10 + '            writeln(''El numero es: '',number)');
     for i:=1 to 5 do
         begin
              espacios := StringOfChar(' ', i * 9);
              writeln(arch,espacios+ 'Else'+#13#10+espacios,'    Begin'+#13#10+espacios,'         if (number = ',i,') then'+#13#10+espacios,'            writeln(''El numero es: '',number)');
              ult:=i;
         end;

     //writeln(arch,'    End');
     for i:=1 to 6 do
         begin
              espacios := StringOfChar(' ', ult * 9);
              ult:=ult-1;
              writeln(arch,espacios+ '    End');
         end;
     //espacios := StringOfChar(' ', ult * 9);
     //writeln(arch,espacios+ '    End;');





     //writeln('Else'+#13#10+'    Begin'+#13#10+'         if (number = ',i,') then'+ #13#10 + '    writeln(''El numero es: '',number)');
     //+#13#10+'    end'
     close(arch);
     readln;
end.

