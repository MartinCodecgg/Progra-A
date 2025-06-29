program ejerc6;

function devolver(n1,n2:byte):byte;
var
    nro:byte;
begin
    nro:=random(n2 - n1 + 1) + n1;
    devolver:=nro;
end;

var
    n1,n2,i:byte;
                        //entre 10 y 50
begin
    randomize; //La funcion randomize se debe ejecutar siempre al comienzo del codigo y nunca en dentro de la funcion
    writeln('Ingrese los numeros n1<n2');
    readln(n1,n2);
    for i:=1 to 50 do
        begin
             writeln('El numero aleatorio generado es: ',devolver(n1,n2));
        end;
end.