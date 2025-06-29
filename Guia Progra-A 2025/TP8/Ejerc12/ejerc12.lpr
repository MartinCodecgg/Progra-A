program ejerc12;

const
     TOP=3;

type
    TMT = array[1..TOP,1..TOP] of byte;

Function Validar(mt:TMT; n,m,tope,acum:byte):boolean;
begin
     if (n=1) and (m=1) then
        begin
             if mt[1,1] > acum then
                Validar:=true
        end
     else
         if m>0 then
            begin
                 if n<>m then
                    acum:=acum + mt[n,m];

                 Validar:=Validar(mt,n,m-1,tope,acum);
            end
         else
             if mt[n,n] > acum then
                Validar:=Validar(mt,n-1,tope,tope,0) //Recordar que debo inicializar en cero el acum ante una nueva fila
             else
                 Validar:=false;
end;

const
     mt:TMT = ((20,2,3),(4,30,6),(7,9,40));

var
   n:byte;
begin
     n:=TOP;

     if Validar(mt,n,n,n,0) then
        writeln('Cumple')
     else
         writeln('No cumple');
     readln;
end.
