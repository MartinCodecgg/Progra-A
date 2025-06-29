program ej;
const
  max=100;
type
  st2=string[2];
  st8=string[8];
  st30=string[30];
  tvb=Array[1..max] of byte;
  tv2=Array[1..max] of st2;
  tvs=Array[1..max] of st30;
  tvc=Array[1..max] of char;
  tvw=Array[1..max] of word;
procedure armar(var cod2:tv2;var cods:tvs;var region:tvc;var n:byte;var importe:tvw;var can1,can,v:tvb);
var
  arch:text;
  num:byte;
  b:char;
begin
    assign(arch,'provincia.txt');
    reset(Arch);
    while not eof(Arch) do
      begin
           n:=n+1;
           importe[n]:=0; v[n]:=0; can[n]:=0;
           readln(arch,cod2[n],b,cods[n],b,region[n],can1[n]);
      end;
    close(Arch);
end;
function busqueda(cod2:tv2;codx:string;n:byte):byte;
var
  i:byte;
begin
    i:=1;
    while cod2[i]<>codx do
      i:=i+1;
    busqueda:=i;
end;
procedure armar2(var v,con:tvb;var importe:tvw;cod2:tv2;n:byte);
var
  arch:text;
  codx:string[6];
  cody:st2;
  b,d:char;
  i,h:byte;
  ing:word;
begin
    assign(Arch,'censo.txt');
    reset(Arch);
    while not eof(Arch) do
      begin
           read(Arch,codx,cody,b,d);
           if d='S' then
              begin
                   read(arch,h,ing,b,b);
                   i:=busqueda(cod2,cody,n);
                   v[i]:=v[i]+1;
                   importe[i]:=importe[i]+ing;
                   con[i]:=con[i]+h;
              end;
           readln(Arch);
      end;
    close(Arch);
end;
procedure regiones(con:tvb;region:tvc;n:byte);
var
  i:byte;
  reg:tvb;
begin
    reg[1]:=0;  reg[2]:=0; reg[3]:=0;
    for i:=1 to n do
        case region[i] of
        'C':reg[1]:=reg[1]+con[i];
        'N':reg[2]:=reg[2]+con[i];
        'S':reg[3]:=reg[3]+con[i];
        end;
    writeln('centro ',reg[1]);
    writeln('norte ',reg[2]);
    writeln('sur ',reg[3]);
end;
function prov(cods:tvs;importe:tvw;v:tvb;n:byte):st30;
var
  i:byte;
  aux,may:real;
  p:st30;
begin
    may:=-1;
    for i:=1 to n do
        begin
             if v[i]>0 then
             aux:=importe[i]/v[i]
             else
             aux:=0;
             if aux>may then
                begin
                     may:=aux;
                     p:=cods[i];
                end;
        end;
    prov:=p;
end;
function total(cod2:tv2;con,can1:Tvb;importe:tvw;cody:st2;n:byte):real;
var
  i:byte;
begin
    i:=busqueda(cod2,cody,n);
    if i>n then
       total:=-1
    else
      if con[i]>can1[i] then
         total:=importe[i]*0.1
      else
        total:=0;
end;
var
  cod2:tv2;
  cods:tvs;
  can1,con,v:tvb;
  importe:tvw;
  n:byte;
  cody:st2;
  region:tvc;
  aux:real;

begin
  n:=0;
  armar(cod2,cods,region,n,importe,can1,con,v);
  armar2(v,con,importe,cod2,n);
  regiones(con,region,n);
  writeln('provincia con mayor ingreso promedio es ',prov(cods,importe,v,n));
  writeln('ingrese el codigo');
  readln(cody);
  aux:=total(cod2,con,can1,importe,cody,n);
  if aux=-1 then
     writeln('no exsiste')
  else
    if aux>0 then
       writeln(aux:0:0)
    else
      writeln('no tiene subsisidio');
  readln;
end.

