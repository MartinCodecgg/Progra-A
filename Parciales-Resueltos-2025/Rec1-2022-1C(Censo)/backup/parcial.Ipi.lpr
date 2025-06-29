program parcial;

Const
     TOP = 100;
Type
    st2 = string[2]; St8=string[8]; st30 = string[30];
    TVst2 = array[1..TOP] of st2;
    TVc = array[1..TOP] of char;
    TV = array[1..TOP] of Byte;
    TVr = array[1..TOP] of real;
    TVst30 = array[1..TOP] of st30;

Function Buscar(Vcod:TVst2; n:byte; prov:st8):byte;
var
   i:byte;

begin
     i:=1;
     while (i<n) and (prov <> Vcod[i]) do
           i:= i+1;
     if prov = Vcod[i] then
        Buscar:=i
     else
       Buscar:=0;
end;

Procedure Inicializar(Var Ving:TVr; Var Vhab,Vvib:TV; n:byte);
var
   i:byte;
begin
     for i:=1 to n do
         begin
              Ving[i]:=0; Vhab[i]:=0; Vvib[i]:=0;
         end;
end;

Procedure LeerProvincias(Var Vcod:TVst2; Var Vreg:TVc; Var V2010:TV; Var n:byte; var Vnom:TVst30);
var
   arch:text; cod:st2; reg:char; nom:st30; cant2010:integer;
begin
     assign(arch,'Provincias.txt');reset(arch);
     n:=0;
     while not eof(arch) do
           begin
                writeln('hola');
                readln;
                readln(arch,cod,reg,nom,reg,cant2010);
                writeln (cod, '  ', nom, '  ', reg,cant2010);readln;
                n:=n+1;
                Vcod[n]:=cod; Vreg[n]:=reg;
                V2010[n]:=cant2010; Vnom[n]:=nom;
           end;
     close(arch);
end;

Procedure LeerCenso(Var Ving:TVr; Var Vhab,Vvib:TV; n:byte; Vcod:TVst2);
var
   arch:text; compro:st8; digit:char;   ing:real;
   hab,pos:byte;
begin
     Assign(arch,'campo.txt');reset(arch);
     Inicializar(Ving,Vhab,Vvib,n);
     While not eof(arch) do
           begin
                readln(arch,compro,digit,digit,hab,ing);
                if digit = 'S' then
                   begin
                        pos:=Buscar(Vcod,n,compro[7]+compro[8]);
                        Ving[pos]:=Ving[pos]+ing;
                        Vhab[pos]:=Vhab[pos] + hab;
                        Vvib[pos]:=Vvib[pos] + 1;
                   end;
           end;
     close(arch);
end;

Procedure InciA(Vreg:TVc; Vhab:TV; n:byte);
var
   i:byte; acumC,acumS,acumN:word;
begin
     acumC:=0; acumS:=0; acumN:=0;
     for i:=1 to n do
         begin
              if Vreg[i] = 'C' then
                 acumC:=acumC + Vhab[i]
              else if Vreg[i]= 'S' then
                 acumS:=acumS+Vhab[i]
              else
                  acumN:=acumN+Vhab[i];
         end;
     writeln('Cantidad de censados por region:');
     writeln('Centro: ',acumC);
     writeln('Sur: ',acumS);
     writeln('Norte: ',acumN);
end;

Function InciB(Vnom:TVst30; Ving:TVr; Vvib:TV; n:byte):st30;
var
   i,posMax:byte;
   max:real;
begin
     max:=0;
     for i:=1 to n do
         begin
              if (Ving[i]/Vvib[i]) > Max then
                 begin
                      max:=Ving[i]; posMax:=i;
                 end;
         end;
     InciB:=Vnom[posMax];
end;

Procedure InciC(Vcod:TVst2; Ving:TVr; V2010,Vhab:TV; n:byte);
var
   cod:st2;    pos:byte;
begin
     writeln('Ingrese el codigo de provincia');readln(cod);
     pos:=Buscar(Vcod,n,cod);
     if pos = 0 then
        writeln('El codigo de prov. ingresado no existe')
     else if V2010[pos] < Vhab[pos] then
        writeln('La provincia no tiene subsidio')
     else
         writeln('El importe total de subsidios de la provincia es: ',Ving[pos] * 0.1);
end;

Var
   Vcod:TVst2; Vreg:TVc; V2010,Vhab,Vvib:TV;
   n:byte; Vnom:TVst30;     Ving:Tvr;
begin
   LeerProvincias(Vcod,Vreg,V2010,n,Vnom);
   LeerCenso(Ving,Vhab,Vvib,n,Vcod);
   InciA(Vreg,Vhab,n);
   Writeln('La provincia con mayor ingreso promedio por vivienda es: ',InciB(Vnom,Ving,Vvib,n));
   InciC(Vcod,Ving,V2010,Vhab,n);
end.                                //1.20 hs
