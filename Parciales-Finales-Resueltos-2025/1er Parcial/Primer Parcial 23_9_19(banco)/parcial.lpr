program parcial;

Const TOP = 100;

Type
    st12 = string[15]; st3=string[3];
    TVst12 = array[1..TOP] of st12;
    TVst3 = array[1..TOP] of st3;
    TVw = array[1..TOP] of word;

Function Buscar(Vnom:TVst12; usuario:st12):byte;
var
   i:byte;
begin
     i:=1;
     while Vnom[i] <> usuario do
           begin
                i:=i+1;
                writeln('Ciclo while');
           end;
     buscar:=i;
end;

Procedure Leer(Var Vnom:TVst12; Var Vip:TVst3; var Vtime:TVw; var n:byte);
var
   arch:text; car:char; ip:st12;
   i:byte;                                tiempo:word;
begin
     assign(arch,'datos.txt');reset(arch); n:=0;
     while not eof(arch) do
           begin
                n:=n+1; Vnom[n]:='';  read(arch,car);
                while car <> ' ' do
                      begin
                           while ((car in ['a'..'z']) or (car in ['A'..'Z'])) and (car <> ' ') do
                                 read(arch,car);

                           if car in ['0'..'9'] then
                              for i:=1 to (ord(car)-ord('0')) do
                                  begin
                                       read(arch,car);
                                       Vnom[n]:=Vnom[n] + car;
                                  end;
                      end;
                read(arch,ip);
                writeln('La ip es:',ip);
                Vip[n]:=IP[1] + IP[2] + IP[3];

                readln(arch,tiempo);
                Vtime[n]:=tiempo;
                writeln('Y Vtime es :',tiempo);
           end;
     close(arch);

     writeln('n es: ',n);
     For i:=1 to n do
         writeln(Vnom[i],' ',Vtime[i],' ',Vip[i]);
end;

Procedure InciA(Vnom:TVst12; Vtime:TVw);
var
   usuario:st12;
begin
     writeln('Ingrese Usuario');readln(usuario);
     writeln('El tiempo de acceso del usuario es: ',Vtime[Buscar(Vnom,usuario)]);
end;

Function InciB(Vtime:TVw; Vip:TVst3; n:byte):real;
var
   acum:word; i,cont:byte;
begin
     cont:=0; acum:=0;
     for i:=1 to n do
         if (Vip[i] <> '192') and (Vip[i] <> '276') and (Vip[i] <> '381') then
            begin
                 cont:=cont+1;
                 acum:=acum + Vtime[i];
            end;
     if cont<> 0 then
        InciB:=acum/cont
     else
       InciB:=0;
end;

Function InciC(Vtime:TVw; Vip:TVst3; n:byte):byte;
var
   max:word; i,posMax:byte;
begin
     max:=0;
     for i:=1 to n do
         if Vip[i] = '192' then
            if Vtime[i] > max then
               begin
                    max:=Vtime[i];
                    posMax:=i;
               end;
     InciC:=posMax;
end;


var
   Vnom:TVst12; Vip:TVst3; Vtime:TVw;
   n:byte;

begin
     Leer(Vnom,Vip,Vtime,n);
     InciA(Vnom,Vtime);
     writeln('El tiempo promedio de accesos internacionales fue de: ',InciB(Vtime,Vip,n):8:2);
     Writeln('El usuario en la red interna del banco con mayor tiempo de conexion es:',Vnom[InciC(Vtime,Vip,n)]);
     readln;
end.
