program parcial;

const TOP = 9;      //Lo mejor es hacer desde el 0 al 9 y en todos los for y while hacer de i:=0 a n

Type
    TVr = array[0..TOP] of real;
    TVw = array[0..TOP] of word;

Function Calcular(dia:word; tipo:char; precio:real):real;
var
   aux:real;
begin
     aux:=0;
     case dia of
     30..59:aux:=10;
     60..119:aux:=15;
     120:aux:=30;
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
end;

procedure Inicializar(var Vacum:TVw; var Vimp,Vvip:TVr);
var
   i:byte;
begin
     for i:=0 to TOP do
         Vacum[i]:=0; Vimp[i]:=0; Vvip[i]:=0;
end;

Procedure Leer(Var Vvip:TVr; Var Vacum:TVw; Var Vimp:TVr; Var n:byte);
var
   arch:text; precio:real; tipo:char;
   dia,i,contCli:byte; pas:shortint; carpa:word;
begin
     assign(arch,'Alquileres.txt');reset(arch);
     readln(arch,precio);
     Inicializar(Vacum,Vimp,Vvip);
     contCli:=0;
     pas:=-1;   //Pas debe ser negativo para diferenciar bien ya que se le asigna n al final, y n puede ser 0
     while not eof(arch) do
           begin
                readln(arch,carpa,dia,tipo,tipo);
                n:=carpa div 100;
                contCli:=contCli+1;
                Vacum[n]:=Vacum[n] + dia;
                Vimp[n]:=Vimp[n] + calcular(dia,tipo,precio);
                if tipo = 'V' then
                   Vvip[n]:= Vvip[n] +1;

                if (n<>pas) and (pas<>-1) then
                begin
                     Vvip[pas]:=Vvip[pas]/(contCli -1)*100;
                     contCli:=1;
                end;
                pas:=n;
           end;
           Vvip[pas]:=Vvip[pas]/(contCli)*100;

        {
     for i:=0 to n do
         begin
              write(i,' ',Vacum[i],' ',Vimp[i]:8:2,' ',Vvip [i]:8:2);
              writeln();
         end;
             }
end;

Function InciA(Vacum:Tvw; Vimp:TVr; n:byte):Byte;
var
   i,aux1:byte; min:word; min2:real;
begin
     min:=65000; min2:=1000000;
     for i:=0 to n do
         begin
         if Vacum[i] <> 0 then
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
                              end
                           else if Vimp[i] = min2 then
                                   aux1:=i;
                      end
         end;
     inciA:=aux1;
end;

Procedure InciB(Vvip:TVr; Vimp:TVr; n:byte);
var
   i,cont:byte; x:real;  acum:real;
begin
     writeln('Ingrese x');readln(x); acum:=0;   cont:=0;
     for i:=0 to n do
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

Function InciC(Vvip:TVr; n:byte):shortint;
var
   i:byte;
begin
     i:=0;
     while (i<n) and (Vvip[i]< 30) do
           i:=i+1;

     if Vvip[i] > 30 then
        InciC:=i
     else
         InciC:=-1;
end;


var
   Vacum:TVw; Vimp,Vvip:TVr;
   n:byte;  aux:shortint;    //Tener en cuenta si 0 seria un posible valor, en este si lo es, debo devolver -1 si no encontre nada

begin
     Leer(Vvip,Vacum,Vimp,n);
     writeln('El pasillo con menor acumulado de dias es: ',InciA(Vacum,Vimp,n));
     InciB(Vvip,Vimp,n);
     writeln('n es',n);
     aux:=InciC(Vvip,n);
     if aux <> -1 then
        writeln('El primer pasillo que tiene mas de 30% de clientes VIP es: ',aux)
     else
         writeln('Ningun pasillo cumple la condicion');
     readln;
end.
