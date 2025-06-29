program eja;
var
    arch:Text;
    v:string[1];
    pat,patmax:string[7];
    valv,valf,valb,max,total:integer;
    ficha,sum,viajes,n,usob,viajesmax:byte;
    val,valmax:boolean;
    porcentaje:real;
    uso:char;

begin
      usob:=0;
      max:=-1;
      viajesmax:=0;
      assign(Arch,'viajes.txt');
      reset(Arch);
      readln(Arch,n,valv,valf,valb);
      while not eof(Arch) do
      begin
            total:=0;
            val:=false;
            viajes:=0;
            sum:=0;
            readln(arch,pat);
            read(arch,ficha);
            while ficha>0 do
            begin
                  sum:=sum+ficha;
                  readln(arch,v,uso);
                  if uso='S' then
                  begin
                       val:=true;
                       usob:=usob+1;
                       total:=total+valb;
                  end;
                  viajes:=viajes+1;
                  read(arch,ficha);
            end;
           total:=total+valv*viajes+valf*sum;
           viajesmax:=viajesmax+viajes;
           if total>max then
              begin
                    patmax:=pat;
                    max:=total;
                    valmax:=val;
              end;
           writeln(viajes,' ', sum);
               porcentaje:=sum/viajes;
               writeln(pat,' promedio ',porcentaje:0:0);
               readln(arch);
      end;
      close(Arch);
      porcentaje:=usob*100/viajesmax;
      writeln;
      write(patmax,' recaudo mas con ',max);
      if valmax then
          writeln(' uso baul')
      else
          writeln(' no uso baul');
      writeln('porcentaje de los viajes que usaron baul de todos los viajes ',porcentaje:0:0,'%');
      readln;
end.

