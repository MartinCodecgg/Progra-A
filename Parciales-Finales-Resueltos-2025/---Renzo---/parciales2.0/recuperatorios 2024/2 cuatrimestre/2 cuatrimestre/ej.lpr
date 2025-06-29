program ej;
const
  m=100;
type
  tvb=array [1..m] of byte;
  tvr=array [1..m] of real;
  tvc=array [1..m] of char;
procedure armar2(var por:tvr;cont:tvb;n:byte);
var
  i:byte;
begin
end;

procedure armar(dia:tvb;var por,importe:tvr;var n:byte);
var
  arch:text;
  i,d:byte;
  cont:tvb;
  carc,car:integer;
  p:real;
  v,pal:char;
  valor:word;
begin
    carc:=-1;
    assign(Arch,'archivo.txt');
    reset(Arch);
    readln(Arch,valor);
    while not eof(Arch) Do
        begin
             p:=1;
             readln(Arch,car,d,v,pal);
             pal:=upcase(pal);
             car:=car div 100;
             while not (car in[0..9]) do
                 case car of
                 10..99:car:=car-10;
                 100..999:car:=car-100;
                 end;
             if carc<car then
                begin
                     n:=n+1;
                     carc:=car;
                     dia[n]:=d;
                     cont[n]:=1;
                     por[n]:=0;
                     importe[n]:=0;
                end
             else
               begin
                dia[n]:=dia[n]+d;
                cont[n]:=cont[n]+1;
               end;
             case d of
                 28..31:p:=p-0.1;
                 57..119:p:=p-0.15;
                 else
                    if d>=120 then
                       p:=p-0.3;
             end;
             case pal of
                 'P':p:=p-0.1;
                 'V':begin
                           p:=p-0.2;
                           por[n]:=por[n]+1;
                      end;
             end;
                 importe[n]:=importe[n]+d*p*valor;
             end;
             close(Arch);
             for i:=1 to n do
             por[i]:=por[i]*m/cont[i];
        end;
function mindia(dia:tvb;importe:tvr;n:byte):integer;
var
  i,mid:byte;
  c:integer;
  min:real;
begin
    mid:=dia[1];
    min:=importe[1];
    for i:=2 to n do
        if (mid>dia[i]) or ((mid=dia[i]) and (min>=importe[i])) then
           begin
                c:=i-1;
                mid:=dia[i];
                min:=importe[i];
           end;
    mindia:=c;
end;
function prom(por,importe:tvr;dia:tvb;n:byte;x:real):real;
var
  cont,i:byte;
  ac:real;
begin
    cont:=0;
    ac:=0;
    for i:=1 to n do
      if por[i]>x then
         begin
              ac:=ac+importe[i];
              cont:=cont+1;
         end;
    if cont=0 then
       prom:=0
    else
      prom:=ac/cont;
end;
function pasillo1(por:tvr;n:byte):integer;
var
  i,j:byte;
begin
    i:=1;
    j:=30;
    while (i<=n) and (por[i]>j) do
        i:=i+1;
    if i>n then
       pasillo1:=-1
    else
      pasillo1:=i;
end;
var
  dia:tvb;
  por,importe:tvr;
  x,aux:real;
  n:byte;
  j:integer;
begin
    n:=0;
    writeln('ingrese x');
    readln(x);
    armar(dia,por,importe,n);
    aux:=prom(por,importe,dia,n,x);
    writeln('pasillo con menor dias acumulado  ',mindia(dia,importe,n));
    writeln('promedio de recaudacion por pasillos ',aux:0:2);
    j:=pasillo1(por,n);
    if j=-1 then
       writeln('no exsiste')
    else
      writeln('pasillo que tiene mas de 30% de vips es el pasillo : ',j);
    readln;
end.

