program ejerc15;

const TOP = 100;

type
    st20 = string[5]; //Me arrepenti de poner 20,  debia ser st10
    TVcli = array[1..TOP] of st20;   //Pude haber usado el mismo tipo aqui
    TVpat = array[1..TOP] of st20;
    Tvcereal = array[1..TOP] of byte;
    TVton = array[1..TOP] of word;


function buscar(V:TVpat; x:st20; n:byte):byte;
var
   i:byte;
begin
     i:=1;
     while (i < n) and (x <> V[i]) do
           i:=i+1;
     if x = v[i] then
        buscar:=i
     else
       buscar:=0;
end;

procedure Leer(var Vcli:Tvcli; var Vpat:TVpat; var Vcereal:TVcereal; var Vton:TVton;  var n:byte);
var
   arch:text; tipo:byte;   car:char;
   cli,pat:st20; ton:word;
begin
     assign(arch,'datos.txt');reset(arch);
     n:=0;
     while not eof(arch) do
           begin
                readln(arch,cli,car,pat,tipo,ton);
                n:= n+1;
                Vcli[n]:= cli; Vpat[n]:=pat;
                Vcereal[n]:=tipo; Vton[n]:=ton;
           end;
     close(Arch);
end;

procedure Porcentaje(Vcereal:TVcereal; Vton:TVton; n:byte);
var
   i:byte; acumTon:byte; acumtri:byte; acumGi:byte; acumSo:byte; acumMa:byte;
begin
     acumTon:=0; acumtri:=0; acumGi:=0; acumSo:=0; acumMa:=0;

     for i:=1 to n do
         begin
              acumTon:=acumTon + Vton[i];
              case Vcereal[i] of
                   1:acumTri:= acumTri + Vton[i];
                   2:acumGi:= acumGi + Vton[i];
                   3:acumSo:= acumSo + Vton[i];
                   4:acumMa:= acumMa + Vton[i];
              end;
         end;
     writeln(' trigo: ',(acumtri/acumton)*100:8:2,
             ' girasol: ',(acumGi/acumTon)*100:8:2,
             ' soja: ',(acumSo/acumTon)*100:8:2,
             ' Maiz: ',(acumMa/acumTon)*100:8:2);
end;

Procedure InciB(Vcli:TVcli; Vpat:TVpat; Vcereal:TVcereal; Vton:TVton; n:byte);
var
   pat:st20;
   pos:byte;
begin
     writeln('Ingrese la patente');readln(pat);
     pos:= Buscar(Vpat,pat,n);
     if pos = 0 then
        writeln('La patente no existe')
     else
         begin
              write('La patente transporta: ');
              case Vcereal[pos] of
                   1:Writeln(' Trigo'); 2 :writeln(' girasol');
                   3:writeln(' Soja');  4: writeln(' maiz');
              end;
              writeln('Un total de toneladas de: ',Vton[pos]);
              writeln('Pertenece al cliente: ',Vcli[pos]);
         end;
end;

Procedure InsertaOrd(var Vc:TVcli; cli:st20;var nc:byte); FORWARD;

Procedure InciC(var Vc:tvcli; Vcli:Tvcli; Vton: TVton; n:byte; var nc:Byte);
var
   i:byte; x:word;
begin
     writeln('Ingrese x'); readln(x); nc:=0;
     for i:=1 to n do
         begin
              if Vton[i] > x then
                 begin
                      nc:= nc+1;
                      InsertaOrd(Vc,Vcli[i],nc);
                 end;
         end;

     //Adicional para comprobar, muestro arreglo
     for i:=1 to nc do
         write(Vc[i],' ');
end;

Procedure InsertaOrd(var Vc:TVcli; cli:st20; var nc:byte);
var
   i:byte;
begin
     i:=nc;
     while (i>0) and (cli < Vc[i]) do
           begin
                writeln('Entro while');
                Vc[i+1]:=Vc[i];
                i:=i-1;
           end;
     Vc[i+1]:=cli;
     nc:= nc+1;
end;


var
   Vc,Vcli:TVcli; Vpat:TVpat; Vcereal:TVcereal; Vton:TVton;
   n,nc:byte;
begin
     Leer(Vcli,Vpat,Vcereal,Vton,n);
     Porcentaje(Vcereal,Vton,n);
     InciB(Vcli,Vpat,Vcereal,Vton,n);
     InciC(Vc,Vcli,Vton,n,nc);
     readln;
end.
