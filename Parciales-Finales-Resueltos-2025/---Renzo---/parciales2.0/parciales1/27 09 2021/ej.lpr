program ej;
const
  max=100;
type
  st16=string[16];
  tvs=Array[1..max] of st16;
  tvb=Array[1..max] of byte;
  tvr=Array[1..max] of real;
function busqueda(nom:tvs;nombre:st16;n:byte):byte;
var
  i:byte;
begin
     i:=1;
     while (i<=n) and (nom[i]<>nombre) do
         i:=i+1;
     busqueda:=i;
end;

procedure armar(var nom:tvs;var es,v:tvb;var pro:tvr;var n:byte);
var
  arch:text;
  nombre:st16;
  e,i:byte;
  tiempo:real;
begin
     assign(Arch,'archivo.txt');
     reset(Arch);
     while not eof(Arch) do
       begin
            readln(Arch,nombre,e,tiempo);
            i:=busqueda(nom,nombre,n);
            if i>n then
              begin
                   n:=n+1;
                   nom[n]:=nombre;
                   es[n]:=e;
                   pro[n]:=tiempo;
                   v[n]:=1;
              end
            else
               begin
                    v[i]:=v[i]+1;
                    pro[i]:=pro[i]+tiempo;
               end;
       end;
     close(Arch);
     for i:=1 to n do
       pro[i]:=pro[i]/v[i];
end;
procedure mostrar(es,v:tvb;n:byte);
var
  i:byte;
  ac:tvb;
begin
     ac[1]:=0; ac[2]:=0; ac[3]:=0; ac[4]:=0;
     for i:=1 to n do
       ac[es[i]]:=ac[es[i]]+v[i];
     writeln('mercedez ',ac[1]);
     writeln('mcloren ',ac[2]);
     writeln('ferrari ',ac[3]);
     writeln('william ',ac[4]);
end;
function nommin(nom:tvs;pro:tvr;v:tvb;n:byte):st16;
var
  i:byte;
  vmin:integer;
  min:Real;
  nombre:st16;
begin
     vmin:=-1;
     min:=9999;
     i:=n;
     for i:=1 to n do
       if (pro[i]<min) or ((pro[i]=min) and (v[i]>vmin)) then
         begin
              min:=pro[i];
              vmin:=v[i];
              nombre:=nom[i];
         end;
     nommin:=nombre;
end;
function val(es:tvb;pro:tvr;e:byte;t:real;n:byte):boolean;
var
  i:byte;
begin
     i:=n;
     while (i>0) and ((not(es[i]=e)) or (pro[i]<t)) do
       i:=i-1;
     val:=i=0;
end;
var
  nom:tvs;
  es,v:tvb;
  pro:Tvr;
  e,n:byte;
  validar:boolean;
  t:Real;
begin
     n:=0;
     armar(nom,es,v,pro,n);
     mostrar(es,v,n);
     writeln('el primer lugar es de ',nommin(nom,pro,v,n));
     writeln('ingrese el codigo del escudaje y el tiempo ');
     readln(e,t);
     validar:=val(es,pro,e,t,n);
     if validar then
       writeln('todos cumplen ')
     else
       writeln('no todos lo consiguieron');
     readln;
end.

