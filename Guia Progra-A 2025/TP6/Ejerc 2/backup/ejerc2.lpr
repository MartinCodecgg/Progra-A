program ejerc2;

const
     TOP=100; //Aqui en const vendria el k que es dato
type
    st10=string[10];
    TMT = array[1..TOP,1..TOP] of real;
    TV = array[1..TOP] of st10;

Procedure Leer(var mt:TMT; var n,m:byte; var Valum:TV);
var
   i,j:byte;
   arch:text;
begin
     assign(arch,'notas.txt');reset(arch); n:=0;

     while not eof(arch) do
           begin
                n:=n+1;
                m:=0;
                read(arch,Valum[n]);
                while not eoln(arch) do     //En realidad no seria necesario ya que k es dato
                      begin
                           m:=m+1;
                           read(arch,mt[n,m]);
                      end;
                readln(arch);
           end;

     for i:=1 to n do
         begin
              for j:=1 to m do
                  write(mt[i,j]:8:2);
              writeln;
         end;
end;

Procedure InciA(mt:TMT; Valum:TV; n,m:byte);
var
   i,j:byte;
begin
     for i:=1 to n do
         begin
              j:=1;
              while (j<m) and (mt[i,j] >=5) do
                    j:=j+1;
              if mt[i,j] >= 5 then
                 writeln(Valum[i]);
         end;
end;

Procedure InciB(mt:TMT; Valum:TV ; n,m:byte);  //Procurar primero poner las dimensiones de la matriz y luego los demas vectores
var
   i,j:byte;   aux:real;
begin
     for i:=1 to n do
         begin
              writeln('El alumno ',Valum[i]);
              aux:=0;
              for j:=1 to m do
                  aux:= aux+ mt[i,j];
              aux:=aux/m;
              if aux >= 7 then
                 writeln('Promociona')
              else if aux>=5 then    //No es necesario preguntar si es menor a 7 porque ya pregunte antes
                 writeln('Habilita')
              else
                  writeln('Desaprueba');
         end;
end;

var
   mt:TMT; Valum:TV;  n,m:byte;
begin
     Leer(mt,n,m,valum);
     InciA(mt,Valum,n,m);
     InciB(mt,Valum,m,n);
     readln;
end.
