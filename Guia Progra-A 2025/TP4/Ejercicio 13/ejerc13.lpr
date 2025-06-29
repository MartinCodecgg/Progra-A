program ejerc13;

procedure calcularHora(var hora,min,seg:byte;segT:word);
var
   aux,pasar:byte;
   begin
        aux:=(seg + segT) div 60;   //Calculo los minutos a pasar
        if aux > 0 then
           begin
                seg:=(seg + segT) mod 60;    //El resto son los segundos finales
                pasar:=aux;                  //Pasar son los minutos a pasar
                aux:= (min + pasar) div 60;  //horas a pasar
                if aux > 0 then
                   begin
                        min:=(min + pasar) mod 60;        //minutos finales
                        pasar:=aux;                       //horas a pasar
                        hora:=(hora + pasar) mod 24   //Horas finales; Fijarse que no es necesario usar un if aqui ya que 1 mod 24 es 1 y 25 mod 24 es 1 tmb, funciona siempre
                   end
                else min:=min + pasar;       //Minutos finales en caso de que no tenga que pasar horas
           end;
   end;

var
   hora,min,seg:byte;
   segT:word;
begin
     writeln('Ingrese hora, minutos y segundos');
     readln(hora,min,seg);
     writeln('Ingrese los segundos transcurridos');
     readln(segT);
     calcularHora(hora,min,seg,segT);
     Writeln('Transcurridos los segundos, la hora final es: ',hora,' ',min,' ',seg);
     readln;
end.

{Ej 13) Desarrollar un procedimiento que dada una Hora Inicial (horas, minutos, segundos) y unos
segundos transcurridos, devuelva la Hora Final (en horas, minutos y segundos). }
