program ej;
const
  m=100;
type
  st6=String[6];
  tv6=Array[1..m] of st6;
  tvr=Array[1..m] of real;
procedure insertar(var cod:tv6;var igg,igm:tvr;codigo:st6;iggx,igmx:real;var n:byte);
var
  i:byte;
begin
     i:=n;
     while (i>0) and (igg[i]<iggx) do
       begin
            cod[i+1]:=cod[i];
            igm[i+1]:=igm[i];
            igg[i+1]:=igg[i];
            i:=i-1;
       end;
        cod[i+1]:=codigo;
        igm[i+1]:=igmx;
        igg[i+1]:=iggx;
        n:=n+1;
end;
procedure armar(var cod:tv6;var igg,igm:tvr;var n:byte);
var
  arch:text;
  codigo:st6;
  v,pcr:char;
  iggx,igmx:real;
  begin
       assign(arch,'hispoado.txt');
       reset(Arch);
       while not eof(Arch) do
         begin
              readln(arch,codigo,v,pcr,iggx,igmx);
              if pcr='S' THEN
                 insertar(cod,igg,igm,codigo,iggx,igmx,n);
         end;
       close(Arch);
  end;
function supum(igg,igm:tvr;x,y:Real;n:byte):byte;
var
  cont,i:byte;
begin
     cont:=0;
     for i:=1 to n do
        if (igg[i]>x) and (igm[i]>y) then
           cont:=cont+1;
     supum:=cont;
end;
function busqueda(cod:tv6;k:St6;n:byte):byte;
var
  i:byte;
begin
     i:=n;
     while (i>0) and (cod[i]<>k) do
       i:=i-1;
     busqueda:=i;
end;
function porcentaje(igg,igm:tvr;n:byte):real;
var
  ac:real;
  i:byte;
begin
     i:=1;
     for i:=1 to n do
        if igm[i]>igg[i] then
           ac:=ac+1;
     if n=0 then
        ac:=0
     else
       ac:=ac/n;
     porcentaje:=ac;
end;
var
  cod:tv6;
  igg,igm:tvr;
  k:st6;
  x,y:real;
  aux,n:byte;

begin
     n:=0;
     armar(cod,igg,igm,n);
     writeln('ingrese el umbral x e y');
     readln(x,y);
     writeln('la cantidad de personas que superaron el umbral x e y es de ',supum(igg,igm,x,y,n));
     writeln('ingrese k');
     readln(k);
     aux:=busqueda(cod,k,n);
     if aux>n then
        writeln('no exsiste')
     else
       writeln(igg[aux], ' ' ,igm[aux]);
     writeln('el porcentaje de personas que tiene un igm>igg es de ',porcentaje(igg,igm,n):0:2);
     readln;

end.

