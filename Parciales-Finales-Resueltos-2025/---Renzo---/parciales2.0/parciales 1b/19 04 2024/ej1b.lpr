program ej1b;
var
  n1:string[8];
  parcela,has,hasmax,unico,i:byte;
  tons,tonst,tonsa,tonsc,q:integer;
  tipo:char;
  rinde,x:real;
  vala,valt,valc:boolean;

begin
      unico:=0;
      q:=0;
      writeln('ingrese x');
      readln(X);
      writeln('ingrese su dni');
      readln(n1);
      while n1<>'999' do
      begin
            tonst:=0; tonsa:=0; tonsc:=0; hasmax:=0;
            vala:=false; valc:=false; valt:=false;
            writeln('ingese la cantidad de parcelas');
            readln(parcela);
            for i:=1 to parcela do
            begin
                 writeln('de la ',i, ' parcela cuantas hectareas sembro');
                 readln(has);
                 if has>0 then
                 begin
                        hasmax:=hasmax+has;
                        writeln('ingrese el tipo de cereal (C-cereal,T-trigo,A-avena)');
                        readln(tipo);
                        tipo:=upcase(tipo);
                        if (tipo<>'A') and (tipo<>'T') and (tipo<>'C') then
                           repeat
                                 writeln('error repita');
                                 readln(Tipo);
                                 tipo:=upcase(tipo);
                           until (tipo='A') or (tipo='T') or (tipo='C');
                        writeln('ingrese la cantidad de toneladas');
                        readln(tons);
                        case tipo of
                             'A':begin
                                       tonsa:=tonsa+tons;
                                       vala:=true;
                                 end;
                             'C':begin
                                       tonsc:=tonsc+tons;
                                       valc:=true;
                                 end;
                             'T':begin
                                       tonst:=tonst+tons;
                                       valt:=true;
                                 end;
                        end;
                 end;
            end;
            if (Vala) and (valc) and (valt) then
                            begin
                                   if q>=0 then
                                      begin
                                             tons:=tonsa+tonsc+tonst;
                                             if tons>0 then
                                                begin
                                                       rinde:=hasmax/tons;
                                                       if rinde<x then
                                                           q:=-1
                                                       else
                                                           q:=q+1;
                                                end;
                                      end;
                            end
                        else
                             if (Vala) and (valc=false) and (valt=false) then
                                unico:=unico+1
                             else
                                 if (Vala=False) and (valc) and (valt=false) then
                                    unico:=unico+1
                                 else
                                     if (Vala=false) and (valc=false) and (valt) then
                                        unico:=unico+1;
                        writeln('ingrese su dni');
                        readln(n1);
      end;
      writeln('la cantidad de productores que cosecharon un solo tipo de cereral :',unico);
      if q>0 then
         writeln('los productres que cosecharon los 3 tipos todos superaron el valor x')
      else
          if q=0 then
             writeln('ninguno de los productores cosecho los 3 tipos de cereal')
          else
              writeln('los productres que cosecharon los 3 tipos no todos superaron el valor x');
      readln;
end.

