{Ej 16) Una empresa de autos de alquiler posee N vehículos y ha registrado la siguiente información de los
viajes realizados, por cada uno de ellos:
 Patente
 Total de litros de combustible consumidos
Y por cada viaje realizado
 - Kilómetros recorridos. (0 indica fin de datos).
Se pide ingresar los datos e informar:
a) Por cada vehículo el consumo que tuvo (cantidad de litros por km. recorrido)
b) Patente del vehículo que más viajes hizo.
c) Total de litros consumidos por el auto que hizo la menor cantidad de kms. }

program ejerc16;

var
   n,TotalLitros,km,acumKm,nroPatenteMax,MinKm,litroMinKm: word;
   patente,patentemax:string;
   contViajes,i:byte;


begin
     writeln('Ingrese la cantidad de vehiculos');
     readln(n);
     nroPatenteMax:=0;
     Minkm:=65000;

     for i:=1 to n do
         begin
              writeln('Ingrese la patente y el total de litros de combustible consumidos');
              readln(patente,TotalLitros);

              acumKm:=0;
              km:=1;         //Hubiese sido mas conveniente en este caso usar un repeat, porque estamos leyendo datos desde teclado
              contViajes:=0;
              while km <> 0 do
                 begin
                      Writeln('Cuantos kilometros realizo en el viaje');
                      readln(km);
                      acumkm:=acumkm+km;
                      contViajes:=contViajes+1;
                 end;

              if contViajes > nroPatenteMAX then
                 begin
                      nroPatenteMax:=contViajes;
                      patenteMax:=patente;
                 end;

              if acumKm < Minkm then
                 litroMinKm:=TotalLitros;

              writeln('La patente ',patente,' tuvo un consumo de ',(TotalLitros/acumKm):8:2,' litros por km recorrido');
         end;

     writeln('La patente del vehiculo que mas viajes hizo fue ',patenteMax);
     writeln('El vehiculo que menos kilometros realizo consumio un total de: ',litroMinKm);

     readln;

     //La solucion no esta del todo bien, ya que si hay 2 patentes que realizaron el mismo consumo maximo de km, solo mostrara la primera
     //Lo cual no es justo, deberia mostrar las dos o mas, esto se puede solucionar usando arrays que todavia no vimos

end.



