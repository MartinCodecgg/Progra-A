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
Porcentaje de Prendas Negras: 99.99 %
}


{Ej 8) La fábrica de Camperas (descripta en el ejercicio 4) debe satisfacer un pedido de un cliente, y cuenta
con la siguiente información:
# ARTICULO (1er. campo de secuencia, clave secundaria)
# TALLE (2do. campo de secuencia)
# COLOR (3er. campo de secuencia)
# CANTIDAD
 ARTICULO + TALLE + COLOR es Clave primaria
 ARTICULO + TALLE es Clave secundaria
Por cada pedido se pide actualizar el stock, en caso de no poder entregar lo posible ,informar la cantidad
adeudada. }
program ejerc8;

Const
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

    TregPedido=record
      cod:ST4;
      Talle:char;
      color:byte;
      cant:byte;
    end;
    TarchPedido=file of TregPedido;

    //Ordenado
    TVcolor=array[1..4] of byte;
    TVtalle=array[1..4] of TVcolor;
    TregOrd=record
     cod:ST4;
     Vtalle:TVtalle;
    end;
    TarchOrd=file of TregOrd;

    TVcod=array[0..TOP] of ST4;

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
     writeln;
     close(archPrenda);
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
     for i:=0 to filesize(archPedido)-1 do
         begin
              writeln(regPedido.cod,' ',' ',regPedido.talle,' ',regPedido.color,' ',regPedido.cant);
         end;
     close(arch);
     writeln;
end;

Procedure ArchivoOrdenado(var archPrenda:TarchPrenda; var archOrd:TarchOrd);
var
   regPrenda:TregPrenda;
   regOrd:TregOrd;
   actPrenda:ST4;
   actTalle:char;
   actColor,talle,i:byte;
begin
     reset(archPrenda);
     read(archPrenda,regPrenda);
     rewrite(archOrd);

     while not eof(archprenda) do
           begin
                actPrenda:=regPrenda.cod;
                regOrd.cod:=regPrenda.cod;  //1)
                while regPrenda.cod = actPrenda do
                      begin
                           actTalle:=regPrenda.talle;
                           case regPrenda.talle of
                               'L':talle:=1;
                               'M':talle:=2;
                               'S':talle:=3;
                               'X':talle:=4;
                           end;
                           for i:=1 to 4 do
                               regOrd.Vtalle[talle][i]:=0;
                           while (regPrenda.talle=actTalle) and (regPrenda.cod = actPrenda) do
                                 begin
                                      actColor:=regPrenda.color;
                                      while (regPrenda.color=actColor) and (regPrenda.talle=actTalle) and (regPrenda.cod = actPrenda) do
                                            begin
                                                 regOrd.Vtalle[talle][actColor]:=regOrd.Vtalle[talle][actColor] + regPrenda.cant;
                                                 read(archPrenda,regPrenda);
                                            end;
                                 end;
                      end;
                write(archOrd,regOrd);
           end;
     close(archPrenda);

     seek(archOrd,0);
     //MostrarOrdenado Generado
     for i:=0 to filesize(archOrd)-1 do
         begin
              read(archOrd,regOrd);
              writeln(regOrd.cod);
         end;
end;

Procedure GenerarV(var archOrd:TarchOrd; var Vcod:TVcod);
var
   i:byte;
   regOrd:TregOrd;
begin
     reset(archOrd);
     for i:=0 to filesize(archOrd)-1 do
         begin
              read(archOrd,regOrd);
              Vcod[i]:=regOrd.cod;
         end;
end;

function Buscar(Vcod:TVcod; n:byte; cod:ST4):byte;
var
   i:byte;
begin
     i:=0;
     while (i<n) and (Vcod[i]<>cod) do
           i:=i+1;
     buscar:=i;
end;

Procedure ProcesarCompras(var archPedido:TarchPedido; var archOrd:TarchOrd; Vcod:TVcod);
var
   regPedido:TregPedido;
   regOrd:TregOrd;
   archTemp:TarchOrd;
   i,pos,talle:byte;
begin
     reset(archPedido);
     reset(archOrd);
     assign(archTemp,'temp.dat');
     rewrite(archTemp);
     for i:=0 to filesize(archPedido)-1 do
         begin
              read(archPedido,regPedido);
              pos:=buscar(Vcod,filesize(archOrd)-1,regPedido.cod);
              seek(archOrd,pos);
              read(archOrd,regOrd);
              case regPedido.talle of
                  'L':talle:=1;
                  'M':talle:=2;
                  'S':talle:=3;
                  'X':talle:=4;
              end;
              if regOrd.Vtalle[talle][regPedido.color]>=regPedido.cant then
                 begin
                      regOrd.Vtalle[talle][regPedido.color]:=regOrd.Vtalle[talle][regPedido.color] - regPedido.cant;
                      write(archTemp,regOrd);
                 end
              else
                  begin
                       writeln('Se adeudan: ',regPedido.cant - regOrd.Vtalle[talle][regPedido.color]);
                       regOrd.Vtalle[talle][regPedido.color]:=0;;
                  end;
         end;
     close(archOrd);
     erase(archOrd);
     close(archTemp);
     rename(archTemp,'ArchivoOrdenado.dat');
     close(archPedido);
end;

var
   archPrenda:TarchPrenda; archPedido:TarchPedido;  archOrd:TarchOrd; Vcod:TVcod;
begin
     assign(archPrenda,'Prendas.dat');
     assign(archPedido,'Pedidos.dat');
     assign(archOrd,'ArchivoOrdenado.dat');
     CrearBinarioej4(archPrenda);
     CrearBinarioej8(archPedido);
     archivoOrdenado(archPrenda,archOrd);
     GenerarV(archOrd,Vcod);
     ProcesarCompras(archPedido,archOrd,Vcod);
     readln;
end.
