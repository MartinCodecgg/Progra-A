program ejerc7;

procedure procesar(var nombre:string[20];var total:real);
var
    i,n:byte;
    total,imp:real;
begin
    writeln('Ingrese Nombre');
    readln(nombre);
    writeln('Es responsable Inscripto? (S/N)');
    readln(tipo);
    tipo:=upcase(tipo);
    total:=0;
    for i:=1 to n do
      begin
            writeln('Ingrese el importe del mes ',i);
            readln(imp);
            total:=total + imp;    
      end;

    write('El comercio: ',nombre,);
    if tipo = 'S' then
        writeln('     Responsable Inscripto')
    else
        writeln('     No Responsable Inscripto');
    
    writeln('Pago un importe de iva de :',total*0.79);
end;    

var
    nombre,nombreMin:string[20];
    tipo:char;
    totalIva,min:real;
begin
    writeln('Ingrese la cantidad de comercios');
    readln(cant);
    min:=99999;
    for i:=1 to cant do
        begin
            procesar(nombre,total);

            if total < min then
                begin
                    min:=total;
                    nombreMin:=nombre;
                end;
        end;
end.