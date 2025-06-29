program ejerc5;

const
     TOP = 100;  //Llamar siempre a esta constante top porque MAX lo uso para calculaar los maximos
type
    Tv = array[1..TOP] of integer;

procedure almacenar(var vec:Tv;var nv:byte);
var
   arch:text;
   num:integer;
begin
     assign(arch,'datos.txt');
     reset(arch);
     nv:=0;
     while not eof(arch) do
           begin
                read(arch,num);
                nv:=nv + 1;
                vec[nv]:=num;
           end;
     close(Arch);
end;

function hallarMaximo(vec:Tv; nv:byte):word;
var
   i:byte;
   max:word;
begin
     max:=0;
     for i:=1 to nv do
         begin
              if vec[i] > max then
                 max:=vec[i];
         end;
     hallarMaximo:=max;
end;

procedure generar2doArreglo(vec:Tv;nv:byte;var vec2:Tv;var nvb:byte;max:word);
var
   i:byte;
begin
     nvb:=0;
     for i:=1 to nv do
         if (vec[i] <> 0) and ((max mod vec[i]) = 0) then
            begin
                 nvb:=nvb + 1;
                 vec[nvb]:= vec[i];
            end;
end;

function promedio(vec:Tv; nv:byte;max:word):real;
var
   i,cont:byte;
   acum:word;
begin
     cont:=0;
     acum:=0;
     for i:=1 to nv do
         if (vec[i] <> 0) and ((max mod vec[i]) = 0) then
            begin
                 cont:= cont + 1;
                 acum:= acum + vec[i];
            end;
     promedio:= acum/cont;
end;

procedure mostrarArreglos(vec:Tv; nv:byte; vec2:Tv; nvb:byte);
var
   i:byte;
begin
     for i:=1 to nv do
         write(vec[i],' ');
     writeln();
     for i:=1 to nvb do
         write(vec2[i],' ');
end;


var
   vec,vec2:Tv;
   nv,nvb:byte;  //Llamar al vector principal nv siempre
   max:word;
begin
     almacenar(vec,nv);
     max:= hallarMaximo(vec,nv);    //Procurar no crear variables solo para pasar un parametro, en este caso tiene sentido porque uso el maximo 2 veces
     writeln('El maximo es: ',max);
     generar2doArreglo(vec,nv,vec2,nvb,max);
     writeln('El promedio de los numeros divisores del maximo es: ',promedio(vec,nv,max):8:2);
     mostrarArreglos(vec,nv,vec2,nvb);
     readln;
end.
