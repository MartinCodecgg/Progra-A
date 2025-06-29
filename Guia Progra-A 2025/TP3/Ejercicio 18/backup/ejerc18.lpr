{Ej 17) La cajera de un supermercado ha registrado varias ventas, de cada una sabe:
 Nombre del cliente ( “ ***** “ indica fin de datos )
 Cantidad de artículos que compró el cliente y por cada uno se conoce:
- Precio base del artículo
- Si está o no en promoción ( ‘S’ ó ‘N’ )
En el caso de estar en promoción, se realiza un descuento del 10% sobre el precio base.
Se pide ingresar los datos e informar:
a) Monto total de cada venta, el total del descuento y el precio final a pagar.
b) Nombre del cliente que compró la mayor cantidad de artículos en oferta.
c) Cuántos clientes compraron solo artículos en oferta}


program ejerc18;

type
     st20=string[20];

var
   nombre,nombreMax:st20;
   cant,cantMaxOferta,contOferta,cantCliSoloOferta,i:byte;
   precioBase,monto,precio,desc:real;      //Los precios o montos y estas cosas siempre hacerlos real
   promo:char;                              //Si desc acumula descuentos entonces debe ser real tambien porque precioBase es real
   condOferta:boolean;
   arch:text;


begin
     assign(arch,'datos.txt');
     reset(arch);
     cantMaxOferta:=0;
     cantCliSoloOferta:=0;
     nombre:='';                           //La mejor forma de inicializar un string o char es con el espacio vacio, semanticamente indica que solo se inicializo
                      //De todas formas no es correcto inicializar variables de esta forma solo para que el WHILE no valide con un valor basura
     while nombre <> '***' do
        begin                      //Es mejor usar el repeat en estos casos, leer ni bien empieza el repeat
           readln(arch,nombre);
           readln(arch,cant);

           Monto:=0;          //Lectura desde archivo --> WHILE
           precio:=0;         //Lectura desde teclado --> Repeat
           desc:=0;
           contOferta:=0;
           condOferta:=true;
           for i:=1 to cant do
               begin
                    promo:='N';
                    readln(arch,PrecioBase);  //Si hay un string o char al final de los elementos al leer con el readln, separar en varios readln o usar read
                    readln(arch,promo);         //Si no hacemos esto nos da un error desconocido
                    promo:=upcase(promo);
                    monto:=monto + PrecioBase;

                    if promo = 'S' then
                       begin
                            contOferta:=ContOferta + 1 ;
                            desc:=desc + PrecioBase*0.1;
                            precio:=precio + precioBase*0.9;
                       end
                    else
                        begin
                             condOferta:=false;
                             precio:=precio + precioBase;
                        end;
               end;

           if (contOferta > cantMaxOferta) then
              begin
                   cantMaxOferta:=contOferta;
                   nombreMax:=nombre;
              end;

           if condOferta then
              cantCliSoloOferta:=cantCliSoloOferta + 1;

           if nombre <>'***' then //Considerar siempre en el ciclo while, si hay que limitar la salida de datos a solo si no se cumple la condicon de corte
           writeln('El monto total es: ',monto:8:2,' El total del descuento es ',desc:8:2,' El precio final es ',precio:8:2);

        end;

     writeln('El cliente que compro la mayor cantidad de articulos en oferta es ',nombreMax);
     writeln('La cantidad de clientes que compraron articulos solo en oferta fue: ',cantCliSoloOferta);
     close(arch);  //Recordar siempre que hago un ejercicio de archivos, va el close(arch);
     readln;
end.

