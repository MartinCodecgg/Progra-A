program ejerc5v2;

function Det(n1,n2,n3,n4:real):real;

begin
     Det:=n1*n2-n3*n4;
end;

var
   a,b,c,d,e,f,detS:real;
begin
     Writeln('Ingrese los coeficientes a,b,c,d,e,f   correspondiente al sistema   ax+by=c   dx+ey=f ');
     readln(a,b,c,d,e,f);

     detS:=Det(a,e,b,d);

     writeln('La solucion para x es: ',(det(c,e,b,f)/detS):8:2);
     writeln('La solucion para y es: ',(det(a,f,c,d)/detS):8:2);
     readln;
end.

