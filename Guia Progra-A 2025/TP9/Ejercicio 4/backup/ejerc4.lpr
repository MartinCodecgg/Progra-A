{Ej 4) Una fábrica de camperas tiene organizado su stock de la siguiente manera en un archivo de tipo:
# CODIGO de ARTICULO (cadena de 4) (1er. campo de secuencia, clave secundaria)
# TALLE ( S, M, L, X) (2do. campo de secuencia, clave secundaria)
# COLOR (1=Negro, 2=Marrón, 3=Azul, 4=Rojo) (3er. campo de secuencia, clave secundaria)
# CANTIDAD de PRENDAS
# PRECIO de COSTO
 Clave primaria: CODIGO de ARTICULO + TALLE + COLOR
Se desea obtener el siguiente listado:
Stock de Prendas
Código: XXXX
 Talle Cantidad Precio Costo
 X 999 $ 99999.99
 . . . . . . . . .
Código: XXXX
. . .
Cantidad Total: 9999
Porcentaje de Prendas Negras: 99.99 % }
program ejerc4;

const
     TOP=100;
Type
    ST4=string[4];

    TregPrenda=record
      cod:ST4;
      Talle:char;
      color:byte;
      cant:byte;
      precio:real;
    end;
    TarchPrenda=file of TregPrenda;

Procedure CrearBinario(var archPrenda:TarchPrenda);
var
   arch:text;
   regPrenda:TregPrenda;
   car:char;
begin
     assign(arch,'prendas.txt');
     reset(arch);
     rewrite(archPrenda);

     while not eof(arch) do
           begin
                readln(arch,regPrenda.cod,car,regPrenda.Talle,regPrenda.color,regPrenda.cant,regPrenda.precio);
                write(archPrenda,regPrenda);
           end;
     regPrenda.cod:='ZZZZ';
     write(archPrenda,regPrenda);  //Aqui es donde guardo el centinela de otra forma me dara error en la lectura luego
     close(arch);
     //Mostrar Binario generado
     //Lo puedo hacer tanto con for o while, si hago con for tengo que usar una variable de mas
     seek(archPrenda,0);
     while not eof(archPrenda) do
           begin
                read(archPrenda,regPrenda);
                writeln(regPrenda.cod,' ',car,regPrenda.Talle,' ',regPrenda.color,' ',regPrenda.cant,' ',regPrenda.precio :8:2);
           end;
     close(archPrenda);
end;

Procedure ListadoCorte2(var archPrenda:TarchPrenda);
var
   regPrenda:TregPrenda;
   actPrenda:ST4;
   actTalle:char;
   actPrecio:real;
   contNegro,ContActTalle:byte;
   acumPrenda:word;
begin
     reset(archPrenda);
     read(archPrenda,regPrenda);
     acumPrenda:=0;
     contNegro:=0;

     while not eof(archprenda) do
           begin
                actPrenda:=regPrenda.cod;
                writeln('Codigo: ',regPrenda.cod);
                while regPrenda.cod = actPrenda do
                      begin
                           actTalle:=regPrenda.talle;
                           actPrecio:=regPrenda.precio;
                           write('    Talle: ',regPrenda.talle,'    ');
                           contActTalle:=0;
                           while (regPrenda.talle=actTalle) and (regPrenda.cod = actPrenda) do
                                 begin
                                      contActTalle:=contActTalle+regPrenda.cant;
                                      acumPrenda:=acumPrenda+regPrenda.cant;
                                      if regPrenda.color=1 then  //Es decir si el color es negro
                                         contNegro:=contNegro+regPrenda.cant;

                                      read(archPrenda,regPrenda);
                                      //writeln('Itera while');
                                 end;
                           writeln('Cantidad :',contActTalle,' Precio Costo: ',actPrecio:8:2);
                      end;
           end;
     close(archPrenda);
     writeln('El porcentaje de prendas negras es: ',(contNegro/acumPrenda)*100:8:2);
end;

var
   archPrenda:TarchPrenda;
begin
     assign(archPrenda,'Prendas.dat');
     CrearBinario(archPrenda);
     ListadoCorte2(archPrenda);
     readln;
end.
