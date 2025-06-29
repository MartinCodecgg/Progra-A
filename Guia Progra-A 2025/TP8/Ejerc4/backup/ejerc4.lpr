program ejerc4;

const TOP = 20;

type
    stm = string[TOP];

function invertir(pal:stm; largo:byte):stm;
begin
     if largo = 0 then
        invertir:=''
     else
         invertir:= pal[largo] + invertir(pal,aux,largo - 1);
end;

var
   pal:stm;
begin
     writeln('Ingrese la palabra a invertir');
     readln(pal);
     writeln(invertir(pal,length(pal)));
     readln;
end.

