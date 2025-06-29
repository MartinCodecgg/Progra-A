program ejerc15;

var
   car,letra:char;
   arch:text;
   cont:byte;

begin
     assign(arch,'datos.txt');
     reset(arch);
     cont:=0;

     writeln('Ingrese la letra a evaluar');
     readln(letra);

     read(arch,car);
     if (car = letra) then
        cont:=cont+1;

     while (car<>'.') do
           begin
                while (car<>' ') and (car<>'.') do
                      begin
                           read(arch,car);
                      end;
                if (car<>'.') then                  //Recordar en estos casos donde tenemos un while que valida la condicion del while inicial, debemos poner
                read(arch,car);                         //un if que valide la condicion del primer while, a la salida del 2do while
                if (car = letra) then                     //caso contrario entra en ciclo infinito
                   cont:=cont+1;
           end;
     writeln('La cantidad de veces que se encontro el caracter fue: ',cont);
     readln;
end.







{
Ej 15) A partir de un archivo de texto que contiene una secuencia de caracteres terminada en punto,
desarrollar un programa para cada item:
a) Cuántas palabras comienzan con una letra que ingresa por teclado.
b) Cuántas palabras contienen una letra que ingresa por teclado.
}

