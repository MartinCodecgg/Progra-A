program ejparcial;
const
    max=10;
type
    st3=string[3];
    st12=string[12];
    tvs=array[1..max] of string;
    tv3=array[1..max] of string[3];
    tvi=array[1..max] of integer;
procedure armar(var usuario:tvs;var ip:tv3;var tiempo:tvi;var n:byte);
var
    arch:Text;
    car,i,car2:char;
    pal:string;
    v:st12;
begin
      assign(Arch,'bank.txt');
      reset(arch);
      while not eof(Arch) do
          begin
                n:=n+1;
                pal:='';
                read(Arch,car);
                while car<>' ' do
                   begin
                         case car of
                         '1'..'9':begin
                                        for i:='1' to car do
                                           begin
                                                 read(Arch,car2);
                                                 pal:=pal+car2;
                                           end;
                                   end;
                         end;
                         read(Arch,car);
                   end;
                usuario[n]:=pal;
                read(Arch,ip[n],v,tiempo[n]);
                readln(Arch);
          end;
      close(arch);
end;
function puntoa(usuario:tvs;us:string;tiempo:tvi;n:byte):integer;
var
    i:byte;
begin
      i:=1;
      while (i<=n) and (us<>usuario[i]) do
         i:=i+1;                                        //punto a
      if i>n then
         puntoa:=-1
      else
        puntoa:=tiempo[i];
end;
function puntob(tiempo:tvi;ip:tv3;n:byte):real;
var
    i,j:byte;
    ac:Real;
begin
      j:=0;
      ac:=0;
      for i:=1 to n do
         case ip[i] of
             '192':;
             '276':;
             '381':;
             else                                         //punto b
                 begin
                       j:=j+1;
                       ac:=ac+tiempo[j];
                 end;
         end;
      if j=0 then
         puntob:=0
      else
        puntob:=ac/j;
end;
function puntoc(usuario:Tvs;ip:tv3;tiempo:tvi;n:byte):string;
var
    i:byte;
    pal:string;
    tim:integer;
begin
      tim:=0;
      pal:='';
      for i:=1 to n do
         if ip[i]='192' then                                   //punto c
            if tiempo[i]>tim then
               begin
                     tim:=tiempo[i];
                     pal:=usuario[i];
               end;
      puntoc:=pal;
end;
procedure puntos(usuario:tvs;ip:tv3;tiempo:Tvi;n:byte);      //puntos a b y c
var
    i,j:byte;
    pal:string;
    tim:integer;
    ac:real;
begin
      j:=0;
      ac:=0;
      writeln('ingrese el numero del usuario');
      readln(pal);
      tim:=puntoa(usuario,pal,tiempo,n);
      if tim=-1 then
         writeln('el usuario no exsiste')
      else
        writeln('tiempo de demora de ',pal,' :',tim);
      tim:=0;
      for i:=1 to n do
         case ip[i] of
             '192': if tiempo[i]>tim then
                         begin
                               tim:=tiempo[i];
                               pal:=usuario[i];
                         end;
             '276':;
             '381':;
             else
                 begin
                       j:=j+1;
                       ac:=ac+tiempo[i];
                 end;
         end;
      if j=0 then
         writeln('el tiempo promedio de usuario es 0')
      else
        writeln('el tiempo promedio de usuario es ',ac/j:0:0);
      writeln('el usuario con red interna de banco con mayor tiempo de conexion ',pal,' con ',tim);
end;

var
    usuario:tvs;
    tiempo:tvi;
    ip:tv3;
    n:byte;

begin
      n:=0;
      armar(usuario,ip,tiempo,n);
      puntos(usuario,ip,tiempo,n); //voy a preguntar si es mejor hacer procedimiento o hacer 2 funciones
      readln;

end.

