program parcial;

Const TOP = 100; NESC=4;

Type
    st16 = string[16]; st8 = string[8];
    TVst16 = array[1..TOP] of st16;
    TV = array[1..TOP] of byte;
    TVr = array[1..TOP] of real;
    TVesc = array[1..NESC] of st8;
    TVaux = array[1..NESC] of byte;

Const
     Vesc2:TVesc = ('Mercedez','McLaren','Ferrari','Williams');

Function Buscar(Vnom:TVst16; n:byte; nom:st16):byte;
var
   i:byte;
begin
     i:=1;
     while (i<n) and (nom <> Vnom[i]) do
           i:=i+1;
     if nom = Vnom[i] then
        Buscar:=i
     else
         Buscar:=0;
end;

Procedure Leer(Var Vnom:TVst16; Var Vesc,Vcont:TV; Var Vprom:TVr; Var n:byte);
var
   arch:text; nom:st16; time:word;
   i,pos,esc:byte;
begin
     Assign(arch,'datos.txt');reset(arch); n:=0;
     while not eof(arch) do
           begin
                readln(arch,nom,esc,time);
                pos:=buscar(Vnom,n,nom);
                if pos = 0 then
                   begin
                        n:=n+1;
                        Vnom[n]:=nom; Vesc[n]:=esc;
                        Vcont[n]:=1; Vprom[n]:=time;
                   end
                else
                    begin
                         Vcont[pos]:=Vcont[pos] +1;
                         Vprom[n]:=Vprom[pos] + time;
                    end;
           end;
     for i:=1 to n do
         Vprom[i]:=Vprom[i]/Vcont[i];

     close(arch);
end;

Procedure InciA(Vcont,Vesc:TV; n:byte);
var
   i:byte; Vaux:TVaux;
begin
     for i:=1 to NESC do
         Vaux[i]:=0;

     for i:=1 to n do
         begin
              Vaux[Vesc[i]]:=Vaux[Vesc[i]] + Vcont[Vesc[i]];
         end;

     for i:=1 to NESC do
         writeln('Escuderia ',Vesc2[i],', Tuvo un total de vueltas de: ',Vaux[i]);
end;

Function InciB(Vnom:TVst16; Vprom:TVr; Vcont:TV; N:byte):byte;
var
   i,posMax:byte;
   max:real;
begin
     max:=0;
     For i:=1 to n do
         begin
              if Vprom[i] > max then
                 Begin
                      max:=Vprom[i];
                      posMax:=i;
                 end
              else if Vprom[i] = max then
                      if Vcont[i] > Vcont[posMax] then
                         posMax:=i;
         end;
     InciB:=posMax;
end;

Procedure InciC(Vesc:TV; Vprom:TVr; n:byte);
var
   i,cod:byte; tiempo:real;
begin
     i:=1;
     writeln('Ingrese un codigo de escuderia y un tiempo');
     readln(cod,tiempo);
     while (i<n) and ((Vesc[i] <> cod) or (Vprom[i] <= tiempo)) do    //Recordar que si uso and y/o OR debo separar con parentesis las condiciones
           i:=i+1;
     if (Vesc[i] <> cod) OR (Vprom[i] <= tiempo) then
        writeln('Todos los competidores realizaron un tiempo promedio menor o igual al ingresado')
     else
         writeln('No todos los competidores realizaron un tiempo promedio menor o igual al ingresado')

end;

var
   Vesc,Vcont:TV; Vnom:TVst16; Vprom:TVr;
   n:byte;

begin
     Leer(Vnom,Vesc,Vcont,Vprom,n);
     InciA(Vcont,Vesc,n);
     writeln('El nombre que alcanzo el primer en la competencia es: ',InciB(Vnom,Vprom,Vcont,n));
     InciC(Vesc,Vprom,n);         //53,33 min con un error grave
end.
