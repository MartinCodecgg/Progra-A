program ejrec;
const
max=100;
type
  st9=string[9];
  st6=string[6];
  tvb=Array[1..max] of byte;
  tvr=Array[1..max] of real;
  tvs=Array[1..max] of st9;
procedure armar(var int:tvs;var genero,tema,tema2:tvb;var total:tvr;var m:byte);
var
  arch:Text;
  id:st9;
  v:char;
  gen:byte;
  car:char;
begin
     assign(Arch,'interprete.txt');
     reset(Arch);
     while not eof(arch) do
      begin
           readln(Arch,id,v,gen,v,car);
           if car='S' then
             begin
                   m:=m+1;
                   int[m]:=id;
                   genero[m]:=gen;
                   tema[m]:=0;
                   tema2[m]:=0;
                   total[m]:=0;
             end;
      end;
      close(Arch);
end;
function busqueda(int:tvs;id:st9;n:byte):byte;
var
  i:byte;
begin
     i:=1;
     while (i<=n) and (int[i]<>id) do
      i:=i+1;
     busqueda:=i;
end;

procedure armar2(int:tvs;var pocision,tema,tema2:tvb;var total:tvr;n,m:byte);
var
  id:st9;
  mus:st6;
  tiempo:real;
  dis:char;
  i,j:byte;
begin
     for i:=1 to n do
     begin
          writeln('ingrese el id del interprete');
          readln(id);
          id:=upcase(id);
          j:=busqueda(int,id,m);
          if j<=m then
            begin
             repeat
                  pocision[i]:=j;
                  writeln('ingrese el tema');
                  readln(mus);
                  if mus<>'ZZZ' then
                    begin
                          writeln('ingrese el tiempo y si esta disponible ');
                          readln(tiempo);
                          readln(dis);
                          dis:=upcase(dis);
                          if dis='S' Then
                            begin
                                  tema[j]:=tema[j]+1;
                                  total[j]:=total[j]+tiempo;
                            end
                          else
                              begin
                                  tema2[j]:=tema2[j]+1;
                            end
                    end;
             until mus='ZZZ';
          end
          else
             N:=N-1:
     end;
end;
function nom23(int:tvs;genero,pocision,tema,tema2:tvb;n:byte):st9;
var
  i,max:byte;
  nom:st9;
begin
     max:=0;
     for i:=1 to n do
        if (genero[pocision[i]] in[2..3]) and (tema2[pocision[i]]=0) and (tema[pocision[i]]>max) then
           begin
                 max:=tema[pocision[i]];
                 nom:=int[pocision[i]];
           end;
     if max=0 then
        nom23:=''
     else
       nom23:=nom;
end;
function duracionmedia(total:Tvr;pocision:tvb;n:byte):real;
var
  i:byte;
  ac:real;
begin
     ac:=0;
     for i:=1 to n do
       ac:=ac+total[pocision[i]];
     ac:=ac/n;
     duracionmedia:=Ac;
end;
procedure armarv(var int2:tvs;int:tvs;total:tvr;pocision:tvb;var k:byte;n:byte);
var
  i:byte;
  ac:real;
begin
     ac:=duracionmedia(total,pocision,n);
     for i:=1 to n do
          if total[pocision[i]]>ac then
             begin
                  k:=k+1;
                  int2[k]:=int[i];
             end;
end;
procedure mostrar(int2:tvs;k:byte);
var
  i:byte;
begin
     for i:=1 to k do
     writeln(int2[i]);
end;

procedure agregar(int:tvs;var total:tvr;var tema:tvb;l:st9;t:st6;d:real;n,m:byte);
var
  i:byte;
begin
     i:=busqueda(int,l,m);
     if i<=m then
        begin
               tema[i]:=tema[i]+1;
             total[i]:=total[i]+d;
        end;
end;
var
  int,int2:tvs;
  tema,tema2,genero,pocision:tvb;
  total:tvr;
  n,m,k:byte;
  l,aux:st9;
  d:real;
  t:st6;

begin
  m:=0;
  k:=0;
  writeln('ingrese n');
  readln(n);
  armar(int,genero,tema,tema2,total,m);
  armar2(int,pocision,tema,tema2,total,n,m);
  aux:=nom23(int,genero,pocision,tema,tema2,n);
  if aux='' then
      writeln('no exsiste ninguno ')
  else
    writeln(aux);
  armarv(int2,int,total,pocision,k,n);
  mostrar(int2,k);
   writeln('ingrese nombre , tema, y duracion ');
  readln(l);
  readln(t,d);
  agregar(int,total,tema,l,t,d,n,m);
  readln;
end.

