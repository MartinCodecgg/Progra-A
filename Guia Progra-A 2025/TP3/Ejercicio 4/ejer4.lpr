program ejer4;

var
  pri,seg,i,n,pos,posicion:byte;      //Puede que a los valores tenga que darle integer o real [PREGUNTAR]
  max:integer;

begin
     Writeln('Ingrese la cantidad de numeros a ingresar');
     readln(n);

     writeln('Ingrese un numero');
     readln(pri);
     max:=-99999;
     pos:=1;

     for i:=1 to n-1 do
         begin
              writeln('Ingrese un numero');
              readln(seg);

              if ((pri-seg) > max) then
                 begin
                       max:=pri-seg;
                       posicion:=pos;
                 end;

              if (i mod 2 = 0 ) then
                 pos:= trunc(i/2)+1;

              pri:=seg;
         end;

     if (max <> -99999) then
        begin
             writeln('La maxima diferencia es: ',max);
             writeln('Corresponde al par: ',posicion);
        end;
     //Dejar mensaje aqui con else
     readln;
end.

