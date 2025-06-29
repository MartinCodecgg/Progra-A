program ejerc2;

const
     MAX = 100;

type
    Tv = array[1..MAX] of integer;

procedure almacenar(var vec,vecW:Tv;var nv,nw:byte);
var
   arch:text;
   num:integer;

begin
     assign(arch,'datos.txt');
     reset(arch);
     nv:=0;
     nw:=0;

     while not eof(arch) do
           begin
                read(arch,num);

                if (num <> 0) then
                   if (num mod 2) = 0  then
                      begin
                           nv:= nv +1;
                           vec[nv]:=num;
                      end
                   else
                       begin
                            nw:=nw + 1;
                            vecW[nw]:=num;
                       end;
           end;
end;


Procedure mostrar(vec,vecW:Tv;nv,nw:byte);
var
   i:byte;
begin
     for i:=1 to nv do
         write(vec[i],' ');
     writeln();
     for i:=1 to nw do
         write(vecW[i],' ');
end;

var
   vec,vecW:Tv;
   nv,nw:byte;
begin
     almacenar(vec,Vecw,nv,nw);
     mostrar(vec,vecW,nv,nw);
     readln;
end.

{Ej 2) Dado un archivo de enteros, se pide almacenar en un vector V sólo los elementos impares y en otro
vector W, los pares, ignorando si hubiese, los ceros}
