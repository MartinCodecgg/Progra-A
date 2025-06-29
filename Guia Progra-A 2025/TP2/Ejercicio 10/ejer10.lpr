program ejer10;

const
     costoBasico=1350;
     peliculas=200;
     deportes=270;
     internetCon6mb=800;
     internet10mbConWIFI=1000;
     opcionGrabar=150;

var
   car:char;
   costo:real;
   condInternet:boolean;

begin
     costo:=costoBasico;
     condInternet:=false;

     writeln('Desea añadir el paquete de peliculas S/N');
     readln(car);
     car:=upcase(car);
     if (car='S') then
        costo:=costo + peliculas;

     writeln('Desea añadir el paquete de deportes S/N');
     readln(car);
     car:=upcase(car);
     if (car='S') then
        costo:=costo + deportes;

     writeln('Desea el paquete de internet? (S/N)');
     readln(car);
     car:=upcase(car);
     if (car = 'S') then
        begin
             writeln('Desea internet con 6MB o 10MB + WIFI (6/W)');
             readln(car);
             car:=upcase(car);
             if (car='6') then
                costo:=costo+internetCon6mb
             else
                costo:=costo+internet10mbConWIFI;

             condInternet:=true;

        end;


     writeln('Desea añadir la opcion de grabar peliculas? S/N');
     readln(car);
     car:=upcase(car);
     if (car='S') then
        costo:=costo + opciongrabar;

     if condInternet then
        costo:=costo*0.75;

     writeln('El costo final es: ',costo:8:2);
     readln();



end.

