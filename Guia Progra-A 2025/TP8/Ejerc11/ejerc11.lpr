program ejerc11;

Procedure Generar(n,m,cont:byte);
begin
     if (n=1) and (m=1) then
        begin
             write(1:4);
        end
     else
         if m>0 then
            begin
                 cont:=cont+1;          //Si queremos generar de forma ascendentemente necesitaremos una variable adicional
                 Generar(n,m-1,cont);   //En este caso un contador que se aumenta en cada nueva columna
                 write(cont:4);           //Y debe de hacerse antes del llamado recursivo
            end
         else
             begin
                  Generar(n-1,n-1,0);
                  writeln;
             end;
end;

var
   n:byte;
begin
     writeln('Ingrese la dimension');
     readln(n);
     Generar(n,n,0);
     readln;
end.
