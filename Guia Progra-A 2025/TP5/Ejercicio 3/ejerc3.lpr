program ejerc3;

const
     MAX = 9;

type
    Tv = array[1..MAX]of byte;

const
     Vejemplo:Tv = (1,2,3,4,2,6,7,8,2);

procedure cambiarOcurrencias(var vec:Tv;nv,k:byte);
var
   i:byte;
begin
     for i:=1 to nv do
         begin
              if vec[i] = k then
                 vec[i]:=0;
         end;

     for i:=1 to nv do
         write(vec[i],' ');
end;

var
   vec:Tv;
   nv,k:byte;
begin
     writeln('Ingrese K');
     readLn(K);
     vec:=Vejemplo;
     nv:=MAX;
     CambiarOcurrencias(vec,nv,k);
     readln;
end.

