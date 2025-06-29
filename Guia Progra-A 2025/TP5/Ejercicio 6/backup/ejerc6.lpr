program ejerc6; //Solo hare el inciso C

procedure hallarMasLarga(palabraMasLarga:string);
var
   arch:text;
   palabra:string;
   car:char;
begin
     assign(arch,'Datos.txt'); reset(arch);
     palabraMasLarga:='zzzzzzzzzzzz';
     while not eof(arch) do
           begin
                read(arch,car);
                palabra:='';
                while (car <>'.') and (car <> ' ') and (car <> ',') and not eof(arch) do
                      begin
                           write('entro 2do while');
                           palabra:=palabra + car;
                           read(arch,car);
                      end;

                if eof(arch) then     //Debo preguntar si salio por llegar al final de archivo para terminar de sumar la ultima letra
                   begin    //Fijarse siempre en el final del ciclo como se evalua todo, casi siempre en estos casos hay que hacer un if de este estilo
                        palabra:=palabra+car;
                   end;

                if (length(palabra) > 0) and (palabra < palabraMasLarga) then
                   palabraMasLarga:=palabra;

           end;

     writeln('La palabra que aparece antes en el diccionario es :',palabraMasLarga);
end;

var
   palabraMasLarga:string;
begin
     hallarMasLarga(palabraMasLarga);
     readln;
end.
