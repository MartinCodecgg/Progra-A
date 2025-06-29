program ejerc3;

const
     TOP = 100;   m = 4;

type
    TMT = array[1..TOP,1..TOP] of shortint;
    TV = array[1..TOP] of shortint;


Procedure Leer(var mt:TMT; var n:byte);
var
   Vaux:TV; i,j:byte;
   arch:text;
begin
     assign(arch,'Datos.txt');reset(arch);
     n:=0;
     while not eof(arch) do
           begin
                n:=n+1;
                for J:=1 to m do
                    read(arch,Vaux[j]);
                readln(arch);

                if (Vaux[m] mod Vaux[1]) = 0 then
                   for j:=1 to m do
                       mt[n,j]:=Vaux[j];
           end;

     for i:=1 to n do
         begin
              for j:=1 to m do
                 write(mt[i,j]:4);
              writeln;
         end;
end;

var
  mt:TMT; n:byte;
begin
     Leer(mt,n);
     readln;
end.

