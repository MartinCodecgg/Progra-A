program parcial;

const TOP = 100;

Type
    st10 = string[10]; st6 = string[6];
    TV = array[1..TOP] of byte;
    TVst10 = array[1..TOP]of st10;
    TVw = array[1..TOP] of word;

Function Buscar(Vint:TVst10; n:byte; inter:st10):byte;
var
   i:byte;
begin
     i:=1;
     while (i < n) and (Vint[i] <> inter) do
           i:=i+1;
     If Vint[i] = inter then
          Buscar:=i
     else
       Buscar:=0;
end;

Procedure Inicializar (Var Vcant,Vnodis:TV; Var Vdur:TVw; n:byte);
var
   i:byte;
begin
     for i:=1 to n do
         begin
              Vcant[i]:=0; Vnodis[i]:=0; Vdur[i]:=0;
         end;
end;

Procedure Mostrar(Vb: TVst10; n2:byte);
var
   i:byte;
begin
     for i:=1 to n2 do
         writeln(Vb[i]);
end;

Procedure LeerInter(Var Vint:TVst10; Var Vgen:TV; Var n:byte);
var
   arch:text;
   firmo:char;
begin
     Assign(arch,'interpretes.txt'); reset(arch); n:=0;

     while not eof(arch) do
           begin
                readln(arch,Vint[n+1],Vgen[n+1],firmo,firmo);
                if firmo = 'S' then
                     begin
                          n:=n+1;
                     end;
           end;
     close(arch);
end;

Procedure LeerTema(Vint:TVst10; n:byte; var Vcant,Vnodis:TV; Var Vdur:TVw);
var
   n2,i,pos:byte; inter:st10;
   Id:st6; dur:word; dis:char;
begin
     writeln('Ingrese cant de interpretes');readln(n2);
     Inicializar(Vcant,Vnodis,Vdur,n);
     for i:=1 to n2 do
         begin
              writeln('Ingrese Interprete'); readln(inter);
              pos:=Buscar(Vint,n,inter);
              if pos <> 0 then
                   begin
                         writeln('Ingrese Tema'); readln(id);

                         while id <> 'ZZZ' do
                            begin
                                 writeln('Ingrese duracion'); readln(dur);
                                 writeln('Ingrese disponibilidad (S/N)'); readln(dis); dis:=upcase(dis);
                                 writeln('Tema es: ',id); writeln('DUR es: ',dur); writeln('dis es: ',dis);
                                 if dis = 'S' then
                                    begin
                                         Vcant[pos]:=Vcant[pos] + 1;
                                         Vdur[pos]:=Vdur[pos] +dur;
                                    end
                                 else
                                       Vnodis[pos]:=Vnodis[pos] + 1;
                            end;
                   end;
         end;
end;

Function InciA(Vint:TVst10; Vgen,Vcant,Vnodis:TV; n:byte):st10;
var
   i,max,posMax:byte; cond,cond2:boolean;
begin
     cond:=false; max:=0; cond2:=false;

     for i:=1 to n do
         begin
              if (Vgen[i] in [2,3]) and (Vnodis[i] = 0) then
                 begin
                      if Vcant[i] > max then
                         begin
                              if not cond2 and cond then
                                 cond2:=true;

                              if not cond and (max <> 0) then
                                 cond:=true;

                              max:=Vcant[i];
                              posMax:=i;
                         end;

                 end;
         end;

     if cond and cond2 then
        InciA:=Vint[posMax]
     else if cond then
          InciA:='Si existe'
     else
       InciA:='No existe';
end;

Procedure InciB(Vint:TVst10; Vdur:TVw; n:byte; Var Vb:TVst10; var n2:byte);
var
   i:byte; media:real;
begin
     media:=0;
     n2:=0;
     for i:=1 to n do
         media:=media + Vdur[i];
     media:=media/n;
     for i:=1 to n do
         begin
              if Vdur[i] > media then
                 begin
                      n2:=n2+1;
                      Vb[n2]:=Vint[i];
                 end;
         end;
    Mostrar(Vb,n2);
end;

Procedure InciC(Vint:TVst10; Var Vdur:TVw; var Vcant:TV; n:byte);
var
   pos:byte; Int:st10; T:st6; D:word;
begin
     writeln('Ingrese interprete');
     readln(Int);
     writeln('Ingrese Tema');
     readln(T);
     writeln('Ingrese Duracion');
     readln(D);
     pos:= Buscar(Vint,n,int);
     if pos <> 0 then
        begin
             Vcant[pos]:= Vcant[pos] + 1;
             Vdur[pos]:=Vdur[pos] + D;
        end;
end;

var
   Vint,Vb:TVst10; Vgen,Vcant,Vnodis:TV;
   Vdur:TVw; n,n2:byte;

begin
     LeerInter(Vint,Vgen,n);
     LeerTema(Vint,n,Vcant,Vnodis,Vdur);
     writeln('Inciso A :',InciA(Vint,Vgen,Vcant,Vnodis,n));
     writeln('Inciso B');
     InciB(Vint,Vdur,n,Vb,n2);
     writeln('Inciso C');
     InciC(Vint,Vdur,Vcant,n);
     readln;
end.
