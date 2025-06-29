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


program ejerc17;

type
     st20=string[20];

var
   nombre,nombreMax:st20;
   cant,cantMaxOferta,contOferta,cantCliSoloOferta,i:byte;
   precioBase,monto,precio,desc:real;      //Los precios o montos y estas cosas siempre hacerlos real
   promo:char;                              //Si desc acumula descuentos entonces debe ser real tambien porque precioBase es real
   condOferta:boolean;


begin
     cantMaxOferta:=0;
     cantCliSoloOferta:=0;

     repeat
           writeln('Ingrese nombre del cliente, y la cantidad de articulos que compro');
           readln(nombre,cant);

           Monto:=0;
           precio:=0;
           desc:=0;
           contOferta:=0;
           condOferta:=true;
           for i:=1 to cant do
               begin
                    promo:='N';
                    writeln('Ingrese el precio base del articulo, y si esta en promocion S/N)');
                    readln(PrecioBase);  //Si hay un string o char al final de los elementos al leer con el readln, separar en varios readln o usar read
                    readln(promo);         //Si no hacemos esto nos da un error desconocido
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

           writeln('El monto total es: ',monto:8:2,' El total del descuento es ',desc:8:2,' El precio final es ',precio:8:2);

     until nombre = '***';   //Cuando uso repeat, poner al principio ya la condicion de corte, porque luego me olvido
     //Recordar cuando uso el repeat, debo cortar ante la opcion de corte (=), en cambio en while debo seguir mientras no suceda la condicion de corte(<>)
     writeln('El cliente que compro la mayor cantidad de articulos en oferta es ',nombreMax);
     writeln('La cantidad de clientes que compraron articulos solo en oferta fue: ',cantCliSoloOferta);

     readln;
end.

