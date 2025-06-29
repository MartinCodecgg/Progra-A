program ej;
const
  max=9;
type
  tvb=array[0..9] of byte;
procedure esp(var cont,maximo:Tvb);
var
  i:integer;
begin
      for i:=0 to max do
        begin
             cont[i]:=0;
             maximo[i]:=0;
        end;
end;
procedure armar(var cont,maximo:Tvb);
var
  arch:text;
  num:byte;
  i:integer;
begin
      assign(Arch,'archivo.txt');
      reset(arch);
      while not eof(Arch) do
        begin
             readln(Arch,num);
             i:=num div 10;
             if num>maximo[i] then
                maximo[i]:=num;

        end;
      close(Arch);
end;
procedure mostrar(cont,maximo:Tvb);
var
  i:integer;
begin
      for i:=0 to max do
        writeln('la decena ',i,' aparecieron ',cont[i],' numeros y el maximo fue ',maximo[i]);
end;
function val(cont:Tvb):boolean;
var
  i:integer;
begin
      i:=max;
      while (i>=0) and (cont[i]>0) do
        i:=i-1;
      val:=i<0;
end;
var
  cont,maximo:tvb;

begin
    esp(cont,maximo);
    armar(cont,maximo);
    mostrar(cont,maximo);
    if val(cont) then
       writeln('aparecieron numeros en todas las decenas')
    else
      writeln('no aparecieron numeros en todas las decenas');
    readln;
end.

