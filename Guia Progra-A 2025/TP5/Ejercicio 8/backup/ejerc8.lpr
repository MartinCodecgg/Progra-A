program ejerc8;

const
     TOP = 9;

type
    TV = array[1..TOP]of byte;

const
     Vejemplo:TV = (1,1,1,2,3,4,5,5,5);

procedure generarW(vec:TV; var vecW:TV; nv:byte; var nw:byte);
var
   i,pri,seg,frec:byte;
begin
        nw:=0;
        pri:=vec[1];
        frec:=1;
        writeln(nv);
        for i:=2 to nv do
            begin
                 seg:=vec[i];
                 if seg = pri then
                    frec:=frec + 1
                 else
                     begin
                          nw:=nw+1;
                          vecW[nw]:= frec;
                          frec:=1;
                          pri:=seg;
                     end;
            end;
        nw:=nw+1;
        vecW[nw]:= frec;   //Tener en cuenta en casos donde usamos un for o while y actualizan los datos luego que el siguiente numero no sea igual al anterior
                           //En este caso cuando sucede esto sale el for por ello debemos hacer la asignacion del ultimo elemento fuera del ciclo
                               //Tener en cuenta ***
end;

procedure mostrar(vecW:TV;nw:byte);
var
   i:byte;
begin
     for i:=1 to nw do
     write(vecw[i],' ');
end;


var
   vec,vecW:TV;
   nv,nw:byte;
begin
     vec:=Vejemplo;
     nv:=TOP;
     generarW(vec,vecW,nv,nw);
     mostrar(vecW,nw);
     readln;
end.

