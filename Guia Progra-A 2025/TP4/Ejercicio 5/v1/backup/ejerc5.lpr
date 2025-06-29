program ejerc5;                    //Aclarar que x = detx/detS   siendo detS el determinante del sistema
                                   //Hacer de nuevo luego
function X(a,b,c,d,e,f:real):real;
var
   detS,detX:real;
begin
     detS:= a*e-b*d;
     detX:= c*e-b*f;

     readln;

     X:=detS/detX;
end;

function Y(a,b,c,d,e,f:real):real;
var
   detS,detY:real;

begin
     detS:= a*e-b*d;
     detY:= a*f-c*d;

     Y:=detY/detS;
end;

var
   a,b,c,d,e,f:real;

begin
     Writeln('Ingrese los coeficientes a,b,c,d,e,f   correspondiente al sistema   ax+by=c   dx+ey=f ');
     readln(a,b,c,d,e,f);
     write(a,b,c,d,e,f);
     //readln;
     writeln('El valor de x es: ',x(a,b,c,d,e,f):8:2);
     writeln('El valor de y es: ',y(a,b,c,d,e,f):8:2);
     readln();
end.

