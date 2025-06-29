program ejerc1;

var
  N,M:real;


begin
  writeln('Ingrese litros de pintura blanca que posee');
  readln(N);
  writeln('Ingrese litros de pintura negra que posee');
  readln(M);


  //writeln('Si tiene',N:8:2,'litros de pintura blanca, necesita', (N*1.4736):8:2,' litros de pintura negra');
  //No usar el 1.47 o estas cosas, da errores
  writeln('Si tiene',N:8:2,'litros de pintura blanca, necesita', (N*100/47.36):8:2,' litros de pintura negra');
  writeln('Si tiene',M:8:2,'litros de pintura negra, necesita', (M*0.4736):8:2,' litros de pintura negra');
  readln;

end.

