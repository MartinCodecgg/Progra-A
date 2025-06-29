program ejerc7;

const
     TOP = 3;

type
    TMT = array[1..TOP,1..TOP] of byte;

Function HallarMin(mt:TMT; n,m,tope:byte):byte;
var
   aux:byte;
begin
     if (n=1) and (m=1) then    //Caso base
        HallarMin:=mt[n,m]
     else
         if m>0 then
            begin
                 aux:=HallarMin(mt,n,m-1,tope);     //Recurrente
                 if mt[n,m] < aux then
                    HallarMin:=mt[n,m]//Como justamente el algoritmo busca el minimo de toda la matriz en este caso podemos usar la variable de la funcion
                 else                    //Para ir asignandole los minimos
                     HallarMin:=aux;
            end
         else
             HallarMin:=HallarMin(mt,n-1,tope,tope)  //El parametro tope es necesario ya que siempre que bajemos de fila necesitamos
                                                        //comenzar nuevamente desde la ultima columna
end;

const
     mt:TMT = ((5,3,3),
              (4,5,6),
              (7,8,9));
var
   n:byte;
begin
     n:=TOP;
     writeln('El elemento minimo de la matriz es: ',HallarMin(mt,n,n,n));
     readln;
end.
