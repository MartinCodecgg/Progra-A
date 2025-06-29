program ejerc6;

function devolver(n1,n2:byte):byte;
var
    nro:byte;

begin
    randomize;

    nro:=random(n2)+1;
    
    if nro < n1 then
            nro:=nro+n1;

    devolver:=nro;

end;

var
    n1,n2,i:byte;
                        //entre 10 y 50
begin
    writeln('Ingrese los numeros n1<n2');
    readln(n1,n2);
    for i:=1 to 20 do
        begin 
    writeln('El numero aleatorio generado es: ',devolver(n1,n2));
        end;
end.