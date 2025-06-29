program ej1;
const
  max=100;
  moto=1000;
  auto=2000;
  camion=8000;
type
    st3=string[3];
    st7=string[7];
    tv=array[1..max] of byte;
    tvr=array[1..max] of real;
    tvs=array[1..max] of st3;
    tv7=array[1..max] of st7;
procedure leer1(var zona:tvs;var k:tvr;var m:byte);
var
   arch:text;
begin
    assign(Arch,'zonas.txt');
    reset(arch);
    while not eof(arch) do
    begin
          m:=m+1;
          readln(Arch,zona[m],k[m]);
      end;
    close(arch);
end;
function busqueda(zona:tvs;zon:st3;m:byte):byte;
var
   i:byte;
begin
     i:=1;
     while (i<=m) and (zon<>zona[i]) do
        i:=i+1;
     busqueda:=i;
end;
procedure especializar(var infraccion:tv;var maxzona:tvr;m:byte);
var
   i:byte;
begin
     for i:=1 to m do
     begin
          infraccion[i]:=0;
          maxzona[i]:=0;
     end;
end;

procedure almacenar(var tipo,infracciones:tv;var velocidad:tvr;k:tvr;var patente:tv7;var n:byte;m,tip,i:byte;v:real;pat:st7);
begin
     infracciones[i]:=infracciones[i]+1;
     n:=n+1;
     tipo[n]:=tip;
     velocidad[n]:=v;
     patente[n]:=pat;
end;

procedure leer(var tipo,infracciones:tv;var velocidad,total:tvr;k:tvr;var zonaz,patente:tv7;zonas:tvs;var n:byte;m:byte);
var
   arch:text;
   i,tip,cont:byte;
   maxzona:tvr;
   v:real;
   zon:st3;
   a:string[1];
   pat:st7;
begin
     cont:=0;
     especializar(infracciones, maxzona, m);
     assign(Arch,'radar.txt');
     reset(arch);
     while not eof(arch) do
     begin
          readln(arch,tip,v,a,zon,a,pat);
          case tip of
             1:if v>100 then
                begin
                        i:=busqueda(zonas,zon,m);
                        almacenar(tipo,infracciones,velocidad,k,patente,n,m,tip,i,v,pat);
                        total[n]:=moto*k[n];
                        if total[n]>maxzona[i] then
                           begin
                                 maxzona[i]:=total[n];
                                 zonaz[i]:=patente[N];
                           end;
                  end;
             2:if v>110 then
                begin
                        i:=busqueda(zonas,zon,m);
                        almacenar(tipo,infracciones,velocidad,k,patente,n,m,tip,i,v,pat);
                        total[n]:=auto*k[n];
                        if total[n]>maxzona[i] then
                           begin
                                 maxzona[i]:=total[n];
                                 zonaz[i]:=patente[N];
                           end;
                  end;
             3:if v>90 then
                begin
                        i:=busqueda(zonas,zon,m);
                        almacenar(tipo,infracciones,velocidad,k,patente,n,m,tip,i,v,pat);
                        total[n]:=camion*k[n];
                        if total[n]>maxzona[i] then
                           begin
                                 maxzona[i]:=total[n];
                                 zonaz[i]:=patente[N];
                           end;
                  end;
            else
              cont:=cont+1;
         end;
     end;
          close(arch);
          writeln('los autos que no cometerion infraccion fueron ',cont);
end;
procedure mostrar(zonas:tvs;zonaz:tv7;m:byte);
var
   i:byte;
begin
     for i:=1 to m do
     writeln('la zona ',zonas[i],' su mayor infraccion fue de ',zonaz[i]);
end;
procedure puntoc(zona:tvs;infracciones:tv;m:byte);
var
    z:st3;
    i:byte;
begin
     writeln('ingrese la zona');
     readln(z);
     i:=busqueda(zona,z,m);
     if i>M then
        writeln('esa zona no exsiste')
     else
       writeln('la cantidad de infracciones en ',zona[i],' son ',infracciones[i]);
end;
var
    tipo,infracciones:tv;
    zona:tvs;
    velocidad,k,total:tvr;
    zonaz,patente:tv7;
    n,m:byte;

begin
     n:=0;
     m:=0;
     leer1(zona,k,m);
     leer(tipo,infracciones,velocidad,total,k,zonaz,patente,zona,n,m);
     mostrar(zona,zonaz,m);
     puntoc(zona,infracciones,m);
     readln;
end.

