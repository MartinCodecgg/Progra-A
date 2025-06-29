program eja;
var
    nombre:string[7];
    nombre2:string[3];
    i,suma,n,num1,num2,puntaje:byte;
    x,p,q:real;
    arch:text;
    val:boolean;
begin
      p:=0;
      q:=0;
      writeln('ingrese x');
      readln(x);
      assign(Arch,'juego.txt');
      reset(arch);
      readln(Arch,n);
      readln(arch,nombre2,nombre);
      while nombre2<>'XXX' do
      begin
            val:=false;
            puntaje:=0;
            for i:=1 to n do
            begin
                  suma:=0;
                  readln(Arch,num1,num2);
                  if num1=num2 then
                      suma:=3*(num1+num2)
                  else
                      if (num1=num2+1) or (num1=num2-1) then
                          suma:=2*(num1+num2)
                      else
                          suma:=num1+num2;
                  if (num1=6) or (num2=6) then
                      val:=true;
                  puntaje:=puntaje+suma;
                  writeln('tiro ',i,' obtuvo ',suma,' puntos');
            end;
            if puntaje<x then
            begin
                 p:=p+1;
                 if val then
                    q:=q+1;
            end;
            writeln(nombre ,' obtuvo ',puntaje,' puntos en total');
            readln(arch,nombre2,nombre);
      end;
      close(Arch);
      writeln;
      if p=0 then
         writeln('todos superaron a x por ende 0')
      else
         write('el procentaje de jugadores que no superaron a x pero sacaron por lo menos una veza a 6 es el ',q*100/n:0:0,'%');
      readln;
end.

