program ejerc11;   //Supondremos que viene desde archivo asi practicamos insercion ordenada

uses sysutils;

const
     TOP = 100;

type
    st10 = string[10];
    TVnombre = array[1..TOP] of st10;
    TVlanzamiento = array[1..TOP] of byte;

procedure Leer(var vec:TVnombre; var vecL1,vecL2:TVlanzamiento; var n:byte);
var
   arch:text;
   nombre:st10;
   l1,l2,I:byte;
begin
     assign(arch,'datos.txt');
     reset(Arch);
     n:=0;

     while not eof(arch) do
           begin
                readln(arch,nombre,L1,L2);
                n:= n+1;
                vec[n]:=trim(nombre);
                vecL1[n]:=L1;
                vecL2[n]:=L2;
           end;

end;

function buscar(vec:TVnombre; n:byte; nombre:string):byte;    //Se sabe que el nombre existe y el vector esta ordenado --> Busqueda Binaria (sabiendo q existe)
var
   pri,ult,medio:byte;
begin
     pri:=1;
     ult:=N;
     medio:= (ult+pri) div 2;

     while (pri < ult) and (nombre <> vec[medio]) do
           begin
                if nombre < vec[medio] then
                   ult := medio - 1
                else
                    begin
                         pri:=medio + 1;
                    end;
                medio:= (ult+pri) div 2;
           end;
     buscar:= medio;
end;

var
   vec:TVnombre;
   vecL1,vecL2:TVlanzamiento;
   n,pos,i:byte;
   nombre:string;
begin
     leer(vec,vecL1,vecL2,n);

     //Inciso C
     writeln('Ingrese un nombre'); //Recordar que el archivo debe venir ordenado para que el programa este funcione
     readln(nombre);
     pos:= buscar(vec,n,nombre); //Suponemos que el atleta existe
     writeln('pos es ',pos);
     for i:=1 to n do
         write(vec[i],' ');
     writeln('El atleta ',vec[pos],' 1er lanzamiento :',vecL1[pos],' ; segundo lanzamiento: ',vecL2[pos]);
     readln;
end.

