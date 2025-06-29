program ejparcial;
const
    max=10;
type
    st16=String[16];
    tvs=Array[1..max] of st16;
    tvb=Array[1..max] of byte;
    tvr=Array[1..max] of real;
 function busqueda(nom:St16;n:byte;nombre:tvs):byte;
 var
     i:byte;
 begin
       i:=1;
       while (i<=n) and (nom<>nombre[i]) do
         i:=i+1;
       busqueda:=i;
 end;

procedure armar(var nombre:tvs;var tipo,vuelta:tvb;var tiempo:tvr;var n:byte);
var
    arch:Text;
    nom:st16;
    i,tip:byte;
    tim:real;
begin
      assign(arch,'archivo.txt');
      reset(arch);
      while not eof(arch) do
         begin
               readln(Arch,nom,tip,tim);
               i:=busqueda(nom,n,nombre);
               if i>n then
                  begin
                         n:=n+1;
                         nombre[n]:=nom;
                         vuelta[n]:=1;
                         tiempo[n]:=tim;
                         tipo[n]:=tip;
                  end
               else
                  begin
                        vuelta[i]:=vuelta[i]+1;
                        tiempo[i]:=tim+tiempo[i];
                  end;
         end;
      close(Arch);
      for i:=1 to n do
         tiempo[i]:=tiempo[i]/vuelta[i];
end;

procedure puntoa(tipo,vuelta:tvb;n:byte);
var
    i:byte;
    auto:tvb;
begin
      auto[1]:=0;   auto[2]:=0;      auto[3]:=0;       auto[4]:=0;
      for i:=1 to n do
      begin
            case tipo[i] of
            1:auto[1]:=auto[1]+vuelta[i];
            2:auto[2]:=auto[2]+vuelta[i];
            3:auto[3]:=auto[3]+vuelta[i];
            4:auto[4]:=auto[4]+vuelta[i];
            end;
      end;
      writeln('mercedez ',auto[1],' mclaren ',auto[2],' ferrari ',auto[3],' wiliams ',auto[4]);
end;
function puntob(nombre:Tvs;tiempo:tvr;vuelta:tvb;n:byte):st16;
var
    i:byte;
    maxs:st16;
    maxv:byte;
    maxt:real;
begin
      maxv:=0;
      maxt:=9999;
      for i:=1 to n do
               if (tiempo[i]<maxt) or ((tiempo[i]=maxt) and (vuelta[i]>maxv)) then
                  begin
                         maxt:=tiempo[i];
                         maxs:=nombre[i];
                         maxv:=vuelta[i];
                  end;
      if maxt<>-1 then
         puntob:=maxs
      else
        puntob:='';
end;
function val(tipo:tvb;vuelta:tvb;tiempo:tvr;e,n:byte;t:real):boolean;
var
    i:byte;
    val1:boolean;
begin
      i:=1;
      val1:=true;
      while (i<=n) and (val1) do
          if (tipo[i]=e) and (tiempo[i]>t) then
              val1:=false
          else
              i:=i+1;
          val:=i>n;
end;
var
    nombre:tvs;
    tipo,vuelta:tvb;
    tiempo:Tvr;
    n,e:byte;
    t:real;
    nmax:st16;

begin
      n:=0;
      repeat
      writeln('ingrese e');
      readln(e);
      until e in[1..4];
      writeln('ingrese t');
      readln(t);
      armar(nombre,tipo,vuelta,tiempo,n);
      puntoa(tipo,vuelta,n);
      nmax:=puntob(nombre,tiempo,vuelta,n);
      if nmax='' then
         writeln('ninguno alcanzo el 1 lugar ')
      else
         writeln(nmax);
      if (val(tipo,vuelta,tiempo,e,n,t)) then
          writeln('si todos lo consiguieron')
      else
           writeln('no todos lo consiguieron');
      readln;
end.

