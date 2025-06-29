program ejerc23;

var
   condContinuar,condMayus,condMinus,condEspeciales:boolean;
   car:char;
   contValidas,contCaract,contDigit,contContrasenias,nroInvalidaMasLarga:byte;
   contrasenia,invalidaMasLarga:string;
   archE,archS:text;

begin
     assign(archE,'datos.txt'); reset(archE);
     assign(archS,'salida.txt');rewrite(archS);

     condContinuar:=true;
     condMayus:=false;
     condMinus:=false;
     condEspeciales:=true;
     contCaract:=0;
     contDigit:=0;
     contValidas:=0;
     contContrasenias:=0;
     nroInvalidaMasLarga:=0;
     contrasenia:='';
     car:=#0;

     while not eof(archE) do
           begin
                read(archE,car);

                if (car <> ' ') and not eof(archE) then
                   begin
                        contCaract:=contCaract + 1;
                        contrasenia:=contrasenia + car;

                        if condEspeciales then
                        if car in ['a'..'z'] then
                           condMinus:=true
                        else if car in ['A'..'Z'] then
                           condMayus:=true
                        else if (car in ['0'..'9']) then
                           contDigit:=contDigit + 1
                        else
                            condEspeciales:=false;

                        if not condContinuar then
                               condContinuar:=true;

                   end
                else if condContinuar then          //[Preguntar] como podria hacerlo con ciclos anidados realmente, sin usar los booleans
                    begin
                         condContinuar:=false;
                         contContrasenias:=contContrasenias + 1;

                         if condMayus and condMinus and condEspeciales and (contDigit = 4) and (contCaract >=8) then
                             begin
                                  writeln(archS,contrasenia);
                                  contValidas:=contValidas + 1;
                             end
                         else
                             if length(contrasenia) > nroInvalidaMasLarga then
                             begin
                                  nroInvalidaMasLarga:=length(contrasenia);  //piso el numero y tambien la propia palabra, siempre
                                  invalidaMasLarga:=contrasenia;
                             end;

                         condMayus:=false;
                         condMinus:=false;         //Recordar reinicializar variables
                         condEspeciales:=true;
                         contCaract:=0;
                         contDigit:=0;
                         contrasenia:='';
                    end;
           end;

    writeln('El porcentaje de contraseñas invalidas es: ',(100 - (contValidas/contContrasenias)*100):8:2,' %');
    writeln('La contraseña invalida mas larga es: ',invalidaMasLarga,' de longitud: ',length(invalidaMasLarga));
    close(archE);close(archS);  //En el caso de escritura, para que termine de escribir en el archivo, si o si debemos usar el close(archS)
    readln;                       //caso contrario no imprime nada
end.


{Ej 23) Un archivo contiene palabras (letras mayúsculas, minúsculas, dígitos, caracteres especiales)
separadas entre sí por uno o más blancos. Se debe verificar para cada una si se trata de una contraseña
válida, y en ese caso grabarla en un archivo de salida. Indicar al final del proceso el porcentaje de
palabras que no son contraseñas válidas y mostrar la contraseña inválida más larga (puede no existir).
 Una contraseña válida debe:
 estar conformada como mínimo por 8 caracteres,
 incluir obligatoriamente, al menos una letra mayúscula y al menos una minúscula
 incluir exactamente cuatro dígitos.
 no contener caracteres diferentes de letras y digitos.
Ejemplo:
eR68G12a 91jY643ebjp eRty74kLh 24fG92 aj85gT32 eL8j$8215 dGb9357jKoup
La salida del programa sería:
El % de contraseñas inválidas es 57.14
La longitud de la contraseña inválida más larga es de 11 caracteres}
