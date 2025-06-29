program ejerc4;

const
     MAX = 100;
type
    Tv = array[1..MAX] of integer;

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

procedure compactar(vec:Tv; nv:byte; var vec2:Tv; var nvb:byte);
var
   i:byte;
begin
     nvb:=0;
     for i:=1 to nv do
         begin
              if vec[i] <> 0 then
                 begin
                      nvb:=nvb+1;
                      vec2[nvb]:=vec[i];
                 end;
         end;

     for i:=1 to nvb do
         write(vec2[i],' ') //Recordar v[i] y no vec[n]
end;

var
   vec,vec2:Tv;
   nv,nvb:byte;  //Llamar al vector principal nv siempre
begin
     almacenar(vec,nv);

     compactar(vec,nv,vec2,nvb);

     readln;
end.

