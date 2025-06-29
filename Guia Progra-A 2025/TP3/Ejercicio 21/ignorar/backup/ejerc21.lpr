{
Ej 21) Leer un conjunto de números enteros, la presencia de ceros intermedios indica fin de un
subconjunto y comienzo del siguiente, dos ceros consecutivos es fin de datos. Se pide calcular e informar
el máximo en cada subconjunto y el orden del subconjunto más numeroso.
Ejemplo: 3,5,2,0,6,7,4,7,0,2,1,0,0
Respuesta: subconjunto Máximo
 1 5
 2 7
 3 2
El subconjunto con más elementos es: 2
}

Program ejerc21;

var
   pri,seg,max,cont,masNumeroso,ordenConjunto,ordenSubMasNumeroso:byte;
   arch:text;

begin
     assign(arch,'datos.txt');
     reset(arch);
     max:=0;
     masNumeroso:=0;
     ordenConjunto:=0;
     cont:=0;
     //pri:=1;
     //seg:=1;

     read(arch,seg);

     while (pri<>0) and (seg<>0) do
           begin
                read(arch,seg);
           if (seg<>0) or (pri<>0) then
                   begin
                        if pri=0 then
                           pri:=1;

                        if seg = 0 then
                           begin
                                ordenConjunto:=ordenConjunto+1;
                                writeln(max);
                                if (cont > masNumeroso) then
                                   begin
                                        masNumeroso:=cont;
                                        ordenSubMasNumeroso:=ordenConjunto;
                                   end;
                                max:=0;
                                cont:=0;
                           end
                        else
                            begin
                                 cont:=cont+1;
                                 if seg > max then
                                    max:=seg;
                            end;

                        if (seg=0) and (pri<>0) then
                           begin
                                pri:=seg;
                                seg:=1;
                           end;
                   end;
           end;
     writeln('El conjunto con mas numeros fue el: ',ordenSubMasNumeroso,' con un total de ',masNumeroso);
     readln;
end.
