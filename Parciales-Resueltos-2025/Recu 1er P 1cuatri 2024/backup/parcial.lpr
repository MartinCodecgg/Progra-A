program parcial;

Const TOP = 100;

Type
    st6 = string[6]; st10 = string[10];
    TVst10 = array[1..TOP] of st10;
    TVst6 = array[1..TOP] of st6;
    TVgen = array[1..TOP] of byte;
    TVs = array[1..TOP] of word;


Function BuscarInter(inter:st10; Vidi:TVst10; n:byte):byte; //b
var
   i:byte;
begin
     i:=1;
     while (i < n) and (inter <> Vidi[i]) do
           i:= i+1;
     if Vidi[i] = inter then
           BuscarInter:= i
     Else
         BuscarInter:=0;
end;

Function contar(inter:st10; Vidi2:TVst10; n2:byte):byte;
var
   i,cont:byte;
begin
     cont:=0;
     for i:=1 to n2 do
         if inter = Vidi2[i] then    //b
            cont:= cont+1;
     contar:=cont;
end;

Procedure LeerInterprete(Var Vidi:TVst10; var Vgen:TVgen; var n:byte);
var
   arch:text; inter:st10; gen:byte; firmo:char;
begin
     assign(arch,'Interpretes.txt');reset(arch);
     n:=0;
     while not eof(arch) do
           begin
                readln(arch,inter,gen,firmo,firmo); firmo:=upcase(firmo);
                if firmo = 'S' then
                   begin
                        n:= n+1;
                        Vidi[n]:=inter; Vgen[n]:=gen;
                   end;
           end;
     close(arch);
end;

Procedure LeerTema(Var Vt:TVst6; Var Vs:TVs; Var n2:byte; Var Vidi2:TVst10; var Nodis:byte);      //b
var
   dur:word; dis:char; inter:st10; id:st6;
   k,i:byte;                            //No es necesaria la busqueda ya que los interpretes no se pueden repetir
   arch:text;
begin
     assign(arch,'temas.txt');reset(arch); //Adapto la resolucion para leer desde archivo porque alta paja el teclado
     readln(arch,k); n2:=0; Nodis:=0;

     for i:=1 to K do
         begin
              readln(arch,inter);
              readln(arch,Id,dur,dis,dis); dis:=upcase(dis);
              while Id <> 'zzz' do
                    begin
                         if dis <> 'N' then
                            begin
                                 n2:= n2+1;
                                 Vt[n2]:=Id; vs[n2]:=dur;
                                 Vidi2[n2]:=inter;
                            end
                         else
                             Nodis:=Nodis + 1;

                             read(arch,Id);
                             if id <> 'zzz' then
                             readln(arch,dur,dis,dis) //dis:=upcase(dis);
                             else
                                 readln(arch);
                    end;
          end;
end;

Function InciA(Vidi,Vidi2:TVst10; Vgen:TVgen; n,n2:byte):st10;
var
   i:byte; cant:byte;
   max:byte; interMax:st10;
begin
     max:=0;

     for i:=1 to n do
         begin
              if Vgen[i] in [2,3] then
                 begin
                      cant:=contar(Vidi[i],Vidi2,n2);
                      if cant > Max then
                         begin
                              Max:=cant;
                              interMax:=Vidi[i];
                         end;
                 end;
         end;
     if Max = 0 then
        InciA:='0'
     else
         InciA:=InterMax;
end;

Procedure Mostrar(Vb:TVst10; nb:byte);
var
   i:byte;
begin
     for i:=1 to nb do
         writeln(Vb[i],' ');
end;

Procedure InciB(VIdi2:Tvst10; var Vb:TVst10; n2:byte; Vidi:TVst10; nb,n:byte; Vs:TVs);
var
   i,j:byte;      total:word;
   media:real;
begin
     media:=0; nb:=0;
     for i:=1 to n2 do
         media:=Vs[i] + media;
     media:=media/n2;

     for i:=1 to n do
         begin
              total:=0;
              for j:=1 to n2 do
                  begin
                       if Vidi[i] = Vidi2[j] then
                          total:= total + Vs[j];
                  end;
              if total > media then
                 begin
                      nb:= nb+1;
                      Vb[nb]:= Vidi[i];
                 end;
         end;
     Mostrar(Vb,nb);
end;

procedure InciC(var Vidi,Vidi2:TVst10; var Vt:TVst6; var Vs:TVs; Var n,n2:byte);  //Recordar, si modifico un vector debo volver a usar var
var
    L:st10; T:st6; D:word;     pos:byte;
begin
     writeln('Ingrese los datos');readln(L,T,D);
     pos:= BuscarInter(L,Vidi,n);
     if pos <> 0 then
        begin
             n:=n+1; n2:=n2+1;
             Vidi[n]:=L; Vidi2[n2]:=L;
             Vt[n2]:=T; Vs[n2]:=D;
        end;
end;

var
   Vidi,Vidi2,Vb:TVst10; Vt:TVst6; Vgen:TVgen; aux:st10; Vs:TVs; n,n2,nb,Nodis:byte;
begin
     LeerInterprete(Vidi,Vgen,n);
     LeerTema(Vt,Vs,n2,Vidi2,Nodis);
     aux:= InciA(Vidi,Vidi2,Vgen,n,n2);
     writeln('Inciso A');
     if aux = '0' then
        writeln('Existe')
     else
         Writeln('El artista que tiene mas canciones es: ',aux);
     writeln();
     writeln('Inciso B');
     InciB(Vidi2,Vb,n2,Vidi,nb,n,vs);
     writeln('Inciso C');
     InciC(Vidi,Vidi2,Vt,Vs,n,n2);
     readln;
end.             //1,38 hs, revisado luego 1,46 hs
