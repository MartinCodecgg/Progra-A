{Ej 22) A partir de un archivo de texto que contiene palabras separadas entre sí por uno o más blancos
desarrollar un programa para:
a) Mostrar la palabra con más cantidad de vocales del texto.
b) Grabar en un texto de salida las palabras con más de cuatro letras pero escritas al revés.
c) Contar cuántas son palíndromas (capicúas).}

program ejerc22;

var
   car:char;
   nroPalabraMasVocales,contVocales,contCapicuas,i:byte;
   archE,archS:text;
   palabra,palabraAlReves,palabraMasVocales:string;
   cond:boolean;

begin
     assign(archE,'datos.txt');reset(archE);
     assign(archS,'salida.txt');rewrite(archS);

     cond:=true;
     contVocales:=0;
     nroPalabraMasVocales:=0;
     contCapicuas:=0;
     palabra:='';
     palabraAlReves:='';
     car:=#0;   //Inicializo el char como el caracter nulo

     while not eof(archE) do
           begin
                read(archE,car);
                if (car <> ' ') and not eof(archE) then  //Prestar atencion que si pongo un if luego del while con la condicion de corte principal
                   begin                                   //Debere añadir tambien en el if la condicion de corte principal
                        palabra:= palabra + car;

                        if car in ['a','e','i','o','u'] then
                           contVocales:=contVocales+1;

                        if not cond then
                           cond:=true;
                   end
                else if cond then    //cond se asegura que no muestre los datos dos veces cuando aparezcan dos espacios seguidos
                    begin
                         cond:=false;
                         if contVocales > nropalabraMasVocales then
                            begin
                                 nropalabraMasVocales:=contVocales;
                                 palabraMasVocales:=palabra;
                            end;

                         for i:=length(palabra) downto 1 do
                             palabraAlReves:=palabraAlreves + palabra[i];

                         if palabra = palabraAlReves then
                            contCapicuas:=contCapicuas + 1;

                         if length(palabra) > 4  then
                               writeln(archS,palabraAlreves);

                         palabra:='';
                         palabraAlReves:='';
                         contVocales:=0;
                    end;
           end;

         writeln('La palabra con mas cantidad de vocales de texto es: ',palabraMasVocales);
         writeln('La cantidad de palabras palindromas(capicuas) es: ',contCapicuas);
         close(archE);close(archS);
         readln;
end.
