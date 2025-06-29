program parcial;

const TOP = 100;

Type
    TV = array[1..TOP] of byte;
    TVr = array[1..TOP] of real;
    TVw = array[1..TOP] of word;

{Function Buscar(Vpas:TV; n,pas:byte):byte; //TOTALMENTE Inncesaria la busqueda si viene ordenado
var
   i:byte;
begin
     i:=1;
     while (i < n) and (pas > Vpas[i]) do   //Ya que queda ordenado por pasillo
           i:=i+1;
     if pas = Vpas[i] then
        Buscar:=i
     Else
         buscar:=0;
end;   }

Function Calcular(dia:word; tipo:char; precio:real):real;
var
   aux:real;
begin
     //writeln('dia es: ',dia);
     //writeln('tipo es: ',tipo);
     aux:=0;
     case dia of
     30..59:aux:=10;
     60..119:aux:=15;
     120: aux:=30;
     end;

     case tipo of
     'P':aux:= aux + 10;
     'V':aux:=aux + 20;
     end;

     precio:=precio*dia;
     if aux <> 0 then
        calcular:=precio*(1- aux/100)
     else
         calcular:=precio;
     //writeln('Precio es: ',precio:8:2);
     //writeln('aux es: ',aux:8:2);
     //writeln('Calcular es: ',calcular:8:2);
end;

procedure Inicializar(Vpas:TV);
var
   i:byte;
begin
     for i:=1 to TOP do
         Vpas[i]:=0;
end;

Procedure Leer(Var Vvip:TVr; Var Vacum:TVw; Var Vimp:TVr; Var aux:byte; Vpas:TV);
var
   arch:text; precio:real; tipo:char; Vcli:TV;
   dia,i:byte; carpa:word;
begin
     assign(arch,'Alquileres.txt');reset(arch); aux:=0;
     readln(arch,precio);
     Inicializar(Vpas);
     while not eof(arch) do
           begin
                readln(arch,carpa,dia,tipo,tipo);


                aux:=carpa div 100;
                if Vpas[aux] = 0 then   //Si lo hago de esta forma puede que almacene pasillos vacios, nose si esta bien o mal
                   begin
                        Vpas[aux]:=aux;
                        Vacum[aux]:=dia; Vimp[aux]:=calcular(dia,tipo,precio);
                        if tipo ='V' then
                           Vvip[aux]:=1; Vcli[aux]:=1;
                   end
                else
                    begin
                         Vacum[aux]:=Vacum[aux] + dia;
                         Vimp[aux]:=Vimp[aux] + calcular(dia,tipo,precio);
                         if tipo = 'V' then
                            Vvip[aux]:= Vvip[aux] +1;

                            Vcli[aux]:=Vcli[aux]+1;
                    end;
           end;
     for i:=1 to aux do
         if Vcli[i] <> 0 then //Ya que quizas de un pasillo no hubo clientes
         Vvip[i]:=(Vvip[i]/Vcli[i])*100;

     for i:=1 to aux do
         begin
              write(Vpas[i],' ',Vacum[i],' ',Vimp[i]:8:2,' ',Vvip[i]:8:2);
              writeln();
         end;

end;

Function InciA(Vacum:Tvw; Vimp:TVr; Vpas:TV; n:byte):Byte;
var
   i,aux1:byte; min:word; min2:real;
begin
     min:=65000; min2:=1000000;
     for i:=1 to n do
         begin
              if (Vacum[i] < min) then
                 begin
                      min:=Vacum[i]; aux1:=i;
                      min2:=Vimp[i];
                 end
              else if Vacum[i] = min then
                      begin
                           if Vimp[i] < min2 then
                              begin
                                   min2:=Vimp[i];
                                   aux1:=i;
                              end;
                      end;
         end;
     inciA:=aux1;
end;

Procedure InciB(Vvip:TVr; Vimp:TVr; Vpas:TV; n:byte);
var
   i,cont:byte; x:real;  acum:real;
begin
     writeln('Ingrese x');readln(x); acum:=0;   cont:=0;
     for i:=1 to n do
         begin
              if Vvip[i] > x then
              begin
                   acum:=acum + Vimp[i];
                   cont:=cont+1;
              end;
         end;
     if cont<> 0 then
     writeln('La recaudacion promedio por pasillo para clientes Vip fue de: ',(acum/cont):8:2)
     else
         writeln('La recaudacion promedio por pasillo para clientes Vip fue 0')
end;

Function InciC(Vvip:TVr; Vpas:TV; n:byte):byte;
var
   i,aux:byte;
begin
     aux:=0;
     for i:=1 to n do
         if Vvip[i] > 30 then
                aux:=i;
     if aux <> 0 then
        InciC:=aux
     else
         InciC:=0;
end;


var
   Vpas:TV; Vacum:TVw; Vimp,Vvip:TVr;
   aux,n:byte;

begin
     Leer(Vvip,Vacum,Vimp,n,Vpas);
     writeln('El pasillo con menor acumulado de dias es: ',InciA(Vacum,Vimp,Vpas,n));
     InciB(Vvip,Vimp,Vpas,n);
     aux:=InciC(Vvip,Vpas,n);
     if aux <> 0 then
        writeln('El primer pasillo que tiene mas de 30% de clientes VIP es: ',aux)
     else
         writeln('Ningun pasillo cumple la condicion');
     readln;
end.
