program ejerc23v2;

var
   condMayus,condMinus,condEspeciales:boolean;
   car:char;
   contValidas,contCaract,contDigit,contContrasenias,nroInvalidaMasLarga:byte;
   contrasenia,invalidaMasLarga:string;
   archE,archS:text;

begin
     assign(archE,'datos.txt'); reset(archE);
     assign(archS,'salida.txt');rewrite(archS);
     contValidas:=0;
     contContrasenias:=0;
     nroInvalidaMasLarga:=0;

     while not eof(archE) do
           begin
                read(archE,car);
                contrasenia:='';
                condMayus:=false;
                condMinus:=false;
                condEspeciales:=true;
                contCaract:=0;
                contDigit:=0;

                while (car <> ' ') and not eof(archE) do
                      begin
                           contrasenia:=contrasenia +car;
                           contCaract:=contCaract + 1;

                           if condEspeciales then
                           if car in ['a'..'z'] then
                              condMinus:=true
                           else if car in ['A'..'Z'] then
                              condMayus:=true
                           else if (car in ['0'..'9']) then
                              contDigit:=contDigit + 1
                           else
                               condEspeciales:=false;

                           read(archE,car);
                      end;

                      if contCaract <> 0 then
                      contContrasenias:=contContrasenias + 1;
                      writeln('Se sumo uno a cont contrasenias');
                      if condMayus and condMinus and condEspeciales and (contDigit = 4) and (contCaract >=8) then
                         begin
                              writeln(archS,contrasenia);
                              contValidas:=contValidas + 1;
                         end
                      else if length(contrasenia) > nroInvalidaMasLarga then
                           begin
                                nroInvalidaMasLarga:=length(contrasenia);
                                invalidaMasLarga:=contrasenia;
                           end;
           end;
     writeln('El porcentaje de contraseñas invalidas es: ',(100 - (contValidas/contContrasenias)*100):8:2,' %');
     Writeln(contcontrasenias);
     writeln('La contraseña invalida mas larga es: ',invalidaMasLarga,' de longitud: ',length(invalidaMasLarga));
     close(archE);close(archS);
     readln;
end.
