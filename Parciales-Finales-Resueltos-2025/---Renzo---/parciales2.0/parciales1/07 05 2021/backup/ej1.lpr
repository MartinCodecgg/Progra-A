program ej1;
const
  max=100;
type
  tvs=array[1..max] of string;
  tvb=array[1..max] of byte;
procedure armar(var vn:tvs;var va,vt,vf:tvb;var n:byte);
var
  arch:text;
  pal:string;
  aux:char;
  aux2:byte;
begin
      assign(Arch,'archivo.txt');
      reset(Arch);
      while not eof(arch) do
       begin
            pal:='';
            n:=n+1;
            read(arch,aux);
            while aux<>'.' do
              begin
                   if aux in['A'..'Z'] THEN
                    pal:=pal+aux;
                   read(Arch,aux);
              end;
            vn[n]:=pal;
            read(aux2,va[n],vt[n],vf[n]);
            readln(arch);
       end;
      close(Arch);
end;
procedure mostrar(vn:tvs;va,vt,vf:tvb;n:byte);
var
  i,ac:byte;
  ac2:real;
begin
      for i:=1 to n do
        begin
             ac:=va[n]+vt[n]+vf[n];
             if vf[n]=0 then
               ac2:=0
             else
               ac2:=ac/vf[n];
             writeln(vn[n],' accesos totales ',ac,' promedio de accesos a los foros ',ac2:0:0);
        end;
end;
function promedio(va,vt,vf:tvb;n:byte;e1,e2:real):real;
var
  ac1,i,acf,j:byte;
  ac:real;
  begin
        j:=0;
        acf:=0;
        for i:=1 to n do
          begin
                ac1:=va[n]+vt[n]+vf[n];
                if (e1>=ac1) and (ac1<=e2) then
                      begin
                           acf:=acf+vf[n];
                           j:=j+1;
                      end;
          end;
        if j=0 then
          ac:=0
        else
           ac:=acf/j;
        promedio:=ac;
  end;
function nom(vn:tvs;va,vf:tvb;n:byte):string;
var
  maxf,i:byte;
  maxn:string;
begin
      maxf:=-1;
      for i:=1 to n do
        if (va[i]=0) and (vf[i]>maxf) then
          begin
               maxf:=vf[i];
               maxn:=vn[i];
          end;
      nom:=maxn;
end;
var
  vn:tvs;
  va,vf,vt:tvb;
  n:byte;
  e1,e2:real;

begin
  n:=0;
  writeln('ingrese los limites e1 y e2');
  readln(e1,e2);
  armar(vn,va,vt,vf,n);
  writeln('el promedio general de acesos al foro es de ',promedio(va,vt,vf,n,e1,e2):0:0);
  writeln('el estudiante que tuvo mas accesos a los foros sin accedes a apuntes es ',nom(vn,va,vf,n));
  readln;
end.

