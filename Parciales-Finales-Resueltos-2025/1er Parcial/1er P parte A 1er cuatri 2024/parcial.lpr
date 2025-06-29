program parcial;

Type
    st10 = string[10];

var
   N,n1,n2,i,x,contJugadores,cont6:byte; cond6:boolean;
   arch:text; nombre:st10; total:word;

function calcularP(n1,n2:byte):byte;
begin
     if n1 = n2 then
        calcularP:=(n1 + n2)*3
     else if (n1 = n2-1) or (n1 = n2+1) then
          calcularP:= (n1+n2)*2
     else calcularP:= n1+n2;      //En enunciado dice que si son iguales o consecutivos se multiplica, si no lo hace debo sumar directamente
end;

begin
     assign(arch,'Juego.txt'); reset(arch); contJugadores:=0;
     cont6:=0; writeln('Ingrese X'); readln(x);
     readln(arch,n); readln(arch,nombre);

     while nombre <> 'xxx' do
           begin
                total:=0;
                cond6:=false;

                for i:=1 to N do
                    begin
                         read(arch,n1); readln(arch,n2);
                         if (n1 = 6) or (n2 = 6) then
                            cond6:=true;
                         total:=calcularP(n1,n2) + total;
                    end;
                writeln('El jugador: ',nombre,' Obtuvo un puntaje de ',total);
                if total < x then
                   begin
                        contJugadores:=Contjugadores +1;
                        if cond6 then
                           cont6:= cont6+1;
                   end;
                readln(arch,nombre)
           end;
               if contJugadores <> 0 then
                writeln('El porcentaje de los jugadores que sacaron 6 en alguno o ambos dados con un puntaje menor a ',x,' es: ',(cont6/contjugadores)*100:8:2);
                close(arch);
                readln();
end.
