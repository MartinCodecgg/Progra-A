program ejerc1;

Function Potencia(x:real; n:shortint; aux:real):real;
begin
     if n < 0 then                //En realidad habria que validar cosas como el n negativo primer if, y si n=-1 fuera de la funcion,
        begin                           //Y usar solo la funcion solo si tiene sentido, n >=1 o n<-1
             n:= abs(n);
             aux:=1/aux;
             x:=1/x;
        end;
     if n = 1 then
        Potencia:=aux
     else if n = 2 then                         //Caso base
        aux:= aux * x
     else                                  //Caso recurrente
         aux:= aux * Potencia(x,n-1,aux);

     Potencia:=aux;
end;

begin
     writeln(potencia(2,1,2):8:2);  //De principio ya se hace una iteracion(numero *1), luego resta multiplicar n-1 veces
     readln;
end.

