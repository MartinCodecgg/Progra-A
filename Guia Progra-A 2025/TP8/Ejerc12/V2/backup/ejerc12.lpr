program ejerc12;

const
     TOP=3;

type
    TMT = array[1..TOP,1..TOP] of byte;

Function Validar(mt:TMT; i,j,m,suma:byte):boolean;
begin
     if i=0 then
        Validar:=true
     else
         if j>1 then
            begin
                 if i<>j then
                    suma:=suma+ mt[i,j];

                 Validar:=Validar(mt,i,j-1,m,suma);
            end
         else
             if mt[i,i] > suma then
                Validar:=Validar(mt,i-1,m,m,0) //Recordar que debo inicializar en cero el acum ante una nueva fila
             else
                 Validar:=false;
end;

const
     mt:TMT = ((1,2,3),(4,30,6),(7,9,40));

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
