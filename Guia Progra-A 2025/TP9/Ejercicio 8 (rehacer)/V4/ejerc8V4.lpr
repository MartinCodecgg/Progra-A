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

{Ej 8) La fábrica de Camperas (descripta en el ejercicio 4) debe satisfacer un pedido de un cliente, y cuenta
con la siguiente información:
# ARTICULO (1er. campo de secuencia, clave secundaria)
# TALLE (2do. campo de secuencia)
# COLOR (3er. campo de secuencia)
# CANTIDAD
 ARTICULO + TALLE + COLOR es Clave primaria
 ARTICULO + TALLE es Clave secundaria
Por cada pedido se pide actualizar el stock, en caso de no poder entregar lo posible e informar la cantidad
adeudada. }
program ejerc8V4;

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

    TregPedido=record
      cod:ST4;
      Talle:char;
      color:byte;
      cant:byte;
    end;
    TarchPedido=file of TregPedido;

Procedure CrearBinarioej4(var archPrenda:TarchPrenda);
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
     regPrenda.cant:=0;
     write(archPrenda,regPrenda);  //Aqui es donde guardo el centinela de otra forma me dara error en la lectura luego
     close(arch);
     //Mostrar Binario generado
     //Lo puedo hacer tanto con for o while, si hago con for tengo que usar una variable de mas
     seek(archPrenda,0);
     while not eof(archPrenda) do
           begin
                read(archPrenda,regPrenda);
                writeln(regPrenda.cod,' ',regPrenda.Talle,' ',regPrenda.color,' ',regPrenda.cant,' ',regPrenda.precio :8:2);
           end;
     close(archPrenda);
     writeln;
end;

Procedure CrearBinarioej8(var archPedido:Tarchpedido);
var
   arch:text;
   regPedido:TregPedido;
   car:char;
   i:byte;
begin
     assign(arch,'Pedidos.txt');
     reset(arch);
     rewrite(archPedido);

     while not eof(arch) do
           begin
                readln(arch,regPedido.cod,car,regPedido.talle,regPedido.color,regPedido.cant);
                write(archPedido,regPedido);
           end;
     writeln;
     regPedido.cod:='ZZZZ';
     write(archPedido,regPedido);
     close(archPedido);
     reset(archPedido);
     for i:=0 to filesize(archPedido)-1 do
         begin
              read(archPedido,regPedido);
              writeln(regPedido.cod,' ',regPedido.talle,' ',regPedido.color,' ',regPedido.cant);
         end;
     close(arch);
     close(archPedido);
     writeln;
end;

Function EsModificacion(regPrenda:TregPrenda; regPedido:TregPedido; maxPrenda:ST4):byte;
begin
  if (regPrenda.cod<regPedido.cod) or (regPrenda.cod>regPedido.cod)  then  //Para este caso solo guardo en el temp y no hago nada
     begin
          if regPedido.cod<maxPrenda then
             Esmodificacion:=1
          else    //Esto para validar que no me cague el programa un codigo en el archivo de pedidos que no este en el original
              Esmodificacion:=3;
     end
  else       //Modificacion, asumo no tener error
      begin
           if (regPrenda.talle<regPedido.talle) or (regPrenda.talle>regPedido.talle) then  //Hago lo mismo que antes con los codigos, ahora con los talles
               Esmodificacion:=1
           else  //Si son iguales prosigo a preguntar por el color
               begin
                    if (regPrenda.color<regPedido.color) or (regPrenda.color>regPedido.color) then //Nuevamente escribo y no hago nada
                        Esmodificacion:=1
                    else   //Ahora si finalmente modificacion
                        begin
                             if regPrenda.cant>=regPedido.cant then
                                Esmodificacion:=2
                             else
                                 Esmodificacion:=4;
                             //En el caso que si vaya a usar algo del archivo de actualizacion, ya sea por alta, baja o modificacion ahi
                             //debere leer por ambos archivos al final
                        end;
               end;
      end;
end;

Procedure Enfrenta(var archPrenda:TarchPrenda; var archPedido:TarchPedido);  //Un enfrentamiento con solo modificacion y pasar, sin alta ni baja
var
   regPrenda:TregPrenda;
   regPedido:TregPedido;
   archTemp:TarchPrenda;
   i:byte;
   maxPrenda:ST4;
begin
     assign(archTemp,'temp.dat');
     reset(archPrenda);

     seek(archPrenda,filesize(archPrenda)-2);
     read(archPrenda,regPrenda);
     maxPrenda:=regPrenda.cod;  //Esto para validar que no me cague el programa un codigo en el archivo de pedidos que no este en el original
     seek(archPrenda,0);

     reset(archPedido);
     rewrite(archTemp);
     //Leo afuera del while principal y en el while mas interno



     read(archPrenda,regPrenda); read(archPedido,regPedido);
     while not eof(archPrenda) or not eof(archPedido) do
         case Esmodificacion(regPrenda,regPedido,maxPrenda) of
         1: begin write(archTemp,regPrenda); read(archPrenda,regPrenda);
            end;
         2:
           begin
                regPrenda.cant:=regPrenda.cant-regPedido.cant;
                write(archTemp,regPrenda);
                read(archPrenda,regPrenda);
                read(archPedido,regPedido);
           end;
         3:begin
              writeln('Se adeudan: ',regPedido.cant,' Unidades de producto: ',regPedido.cod);
              read(archPrenda,regPrenda);
              read(archPedido,regPedido);
           end;
         4:begin
              writeln('Se adeudan: ',regPedido.cant-regPrenda.cant,' Unidades de producto: ',regPedido.cod);
              regPrenda.cant:=0;
              write(archTemp,regPrenda);
              read(archPrenda,regPrenda);
              read(archPedido,regPedido);
           end;
         end;

     writeln;
     write(archTemp,regPrenda);
     close(archPrenda);
     erase(archPrenda);
     close(archTemp);
     rename(archTemp,'Prendas.dat');

     //Adicional muestro el archivo temporal creado
     reset(archTemp);
     for i:=0 to filesize(archTemp)-1 do
         begin
              read(archTemp,regPrenda);
              writeln(regPrenda.cod,' ',regPrenda.Talle,' ',regPrenda.color,' ',regPrenda.cant,' ',regPrenda.precio :8:2);
         end;
     writeln;
end;

var
   archPrenda:TarchPrenda; archPedido:TarchPedido;
begin
     assign(archPrenda,'Prendas.dat');
     assign(archPedido,'Pedidos.dat');
     CrearBinarioej4(archPrenda);
     CrearBinarioej8(archPedido);
     Enfrenta(archPrenda,archPedido);
     readln;
end.
