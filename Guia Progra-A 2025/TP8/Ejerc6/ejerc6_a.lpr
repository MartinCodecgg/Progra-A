program ejerc6_a;

const
     TOP=5;
type
    TV = array[1..TOP] of real;

const
     V:TV = (1.5,2,-2,0,5);

Function BuscaLineal(V:TV; x:real; n:byte):byte;
begin
     if n=0 then
        BuscaLineal:=0
     else if V[n]= X then
            BuscaLineal:=n
     else
         BuscaLineal:=BuscaLineal(V,x,n-1);  //Recordar que siempre en recursividad debemos llamar recursivamente con n-1
end;

var
   n:byte;
begin
     n:=TOP;
     writeln('La funcion devuelve: ',BuscaLineal(V,5,n));
     readln;
end.
