program parcial;

const TOP = 100; areas=10;

Type
    ST30 = string[20]; ST10 = string[10];
    TMT = array[1..TOP,1..areas] of real;
    TV = array[1..areas] of byte;
    TregP = record
          puesto:ST10; sueldo:real; cont:byte;
    end;
    TVregP = array[1..TOP] of TregP;
    TregB =record
          area:byte; sueldo:real;
    end;
    TVregB = array[1..areas] of TregB;


Function Buscar(Vpuesto:TVregP; puesto:st10):byte;
var
   i:byte;
begin
     i:=1;
     while puesto <> Vpuesto[i].puesto do
           i:=i+1;
     buscar:=i;
end;

Procedure Inicializar(Var mt:TMT; Var Varea:TV; Var Vpuesto:TVregP; n:byte);
var
   i,j:byte;
begin
     for i:=1 to n do
         for j:=1 to areas do
             mt[i,j]:=0;

     for j:=1 to areas do
         Varea[j]:=0;
     for i:=1 to n do
         Vpuesto[i].cont:=0;
end;

Procedure LeerSalarios(Var Vpuesto:TVregP; Var n:byte);
var
   arch:text;        i:byte;
begin
     assign(arch,'salarios.txt'); reset(arch); n:=0;
     while not eof(arch) do
           begin
                n:=n+1;
                readln(arch,Vpuesto[n].puesto,Vpuesto[n].sueldo);
           end;
     close(arch);

     for i:=1 to n do
         writeln(Vpuesto[i].puesto,Vpuesto[i].sueldo:8:2);
end;

Procedure LeerEmpleados(Var mt:TMT; Var Varea:TV; var Vpuesto:TVregP; n:byte);
var
   arch:text; pos,area:byte; empleados:ST30;
   hora:word; car:char; puesto:ST10;       i,j:byte;
begin
     assign(arch,'empleados.txt'); reset(arch);
     inicializar(mt,Varea,Vpuesto,n);
     while not eof(arch) do
           begin
                readln(arch,empleados,area,car,puesto,hora);
                pos:=buscar(Vpuesto,puesto);
                mt[pos,area]:=mt[pos,area] + Vpuesto[pos].sueldo * hora;
                Vpuesto[pos].cont:=Vpuesto[pos].cont+1;
                Varea[area]:=Varea[area] + 1;
           end;
     close(arch);

     for i:=1 to n do
         begin
              for j:=1 to areas do
                  write(mt[i,j]:8:2);
              writeln;
         end;
end;

Function InciA(Vpuesto:TVregP; n,x:byte):byte;
var
   i,cont:byte;
begin
     cont:=0;
     for i:=1 to n do
         if Vpuesto[i].cont > x then
            cont:=cont+1;

     InciA:=cont;
end;

Procedure mostrar(Vb:TVregB; nb:byte);
var
   i:byte;
begin
     for i:=1 to nb do
         writeln(Vb[i].area,'  ',Vb[i].sueldo:8:2);
end;

Procedure InciB(mt:TMT; n:byte; Varea:TV; Var Vb:TVregB; Var nb:byte);
var
   j,i:byte; acum:real;
begin
     nb:=0;
     for j:=1 to areas do
         begin
              acum:=0;
              i:=1;
              while (i<=n) and (mt[i,j] <> 0 ) do
                    begin
                         writeln(mt[i,j]:8:2);
                         acum:=acum+mt[i,j];
                         i:=i+1;
                    end;
              if (i=n+1) then  //Esta es una forma valida de recorrer pero con una iteracion de mas, que en este caso es valida porque aparte de buscar
                 begin           //estamos acumulando, es decir debemos iterar en i=n
                      nb:=nb+1;
                      writeln(acum:8:2,' ',Varea[j]);
                      Vb[nb].sueldo:=acum/Varea[j];
                      Vb[nb].area:=j;
                 end;
         end;
end;

var
   mt:TMT; n,x,nb:byte; Vb:TVregB;
   Varea:TV; Vpuesto:TVregP;
begin
   LeerSalarios(Vpuesto,n);
   writeln('Se lee empleados');
   LeerEmpleados(mt,Varea,Vpuesto,n);
   writeln('Inciso A');
   Writeln('Ingrese x'); readln(x);
   writeln('La cantidad de puestos es: ',InciA(Vpuesto,n,x));
   InciB(mt,n,Varea,Vb,nb);
   mostrar(vb,nb);
   readln;
end.
