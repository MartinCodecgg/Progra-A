program ejerc6;

function devolver(n1,n2:byte):byte;
var
    nro:byte;

begin
    randomize;

    nro:=random(n2)+1;
    
    if nro > n2 then
        nro:=nro-n1
    else if nro < n1 then
            nro:=nro+n1

    devolver:=nro;

end;

var
    n1,n2:byte;
                        //entre 10 y 50
begin
    writeln('Ingrese los numeros n1<n2');
    readln(n1,n2);
    writeln('El numero aleatorio generado es: ',devolver(n1,n2));
end.