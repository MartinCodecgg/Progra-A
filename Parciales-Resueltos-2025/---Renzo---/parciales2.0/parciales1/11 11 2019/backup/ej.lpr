program ej;
const
  max=100;
type
  tvs=array[1..max] of string;
  tvb=array[1..max] of byte;
  tvr=array[1..max] of real;
procedure armar(var nom:tvs;var edad:tvb;var dif:tvr;var n:byte);
var
  arch:text;
  c1,c2:char;
  pm,pa:real;
  pal:string;
  m:byte;
begin
     assign(Arch,'archivo.txt');
     reset(arch);
     while not eof(Arch) do
        begin
            read(arch,pa,pm);
            if ((pm>90) and (pa>140)) or ((pm<65) and (pa<100)) or (pa-pm<=25) then
            begin
                  n:=n+1;
                  m:=0;
                  pal:='';
                  read(Arch,c1,c2);
                  while c2<>'.' do
                     begin
                           m:=m+1;
                           if (c1='%') or (c1='&') or (C1='#') then
                            pal:=pal+c2;
                           c1:=c2;
                           read(Arch,c2);
                     end;
                  nom[n]:=pal;
                  edad[n]:=5*m;
                  dif[n]:=pa-pm;
                  writeln(dif[n]:0:2);
            end;
            readln(Arch);
        end;
     close(Arch);
end;
function promedio(edad:Tvb;dif:tvr;n,e,e2:byte):real;
var
  i,m:byte;
  pro:real;
begin
     m:=0;
     pro:=0;
     for i:=1 to n do
       if (edad[i]>=e) and (edad[i]<=e2) then
           begin
                 m:=m+1;
                 pro:=pro+dif[i];
           end;
     pro:=pro/m;
     promedio:=pro;
end;
procedure mostrarb(nom:tvs;edad:tvb;dif:tvr;var maxd:real;n:byte);
var
  maxn:string;
  maxe,i:byte;
begin
     for i:=1 to n do
       if dif[i]>maxd then
        begin
              maxd:=dif[i];
              maxe:=edad[i];
              maxn:=nom[i];
        end;
     writeln('nombre :',maxn,' edad ',maxe);
end;
function contd(dis:tvr;maxd,x:real;n:byte):byte;
var
  i,cont:byte;
begin
     cont:=0;
     maxd:=maxd*x/100;
     for i:=1 to n do
        if dis[i]<maxd then
         cont:=cont+1;
     contd:=cont;
end;
var
  nom:tvs;
  edad:tvb;
  dif:tvr;
  maxd,x:real;
  i,n,e,e2:byte;

begin
  n:=0;
  maxd:=-1;
  armar(nom,edad,dif,n);
  repeat
  writeln('ingrese los limites ');
  readln(e,e2);
  until e2>=e;
  writeln('el promedio es de ',promedio(edad,dif,n,e,e2):0:2);
  mostrarb(nom,edad,dif,maxd,n);
  writeln('ingrese x');
  readln(x);
  writeln(' la cantidad de personas que tienen un porcentaje de diferencia menor a ',x:0:0,' es de ',contd(dif,maxd,x,n));
  readln;

end.

