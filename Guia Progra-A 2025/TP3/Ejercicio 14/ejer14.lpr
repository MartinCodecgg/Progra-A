program ejer14;

var


begin
  Bool:=false ;
  Sum:=0;
  Readln( x );                 //Rta: Lo que hace es sumar numeros ingresados por teclado hasta que ingrese un 0 o la suma sea mayor a 100
                               //LOTE 1: 0  ; LOTE 2: 110 ; LOTE 3: 70 ;
  If x <>0 then
   Repeat
   Sum := Sum + x;
   If Sum > 100 then
   Bool :=true;
   Readln( x );
   Until ( x=0) or Bool;
   Writeln(‘Resultado’, Sum );

end.

