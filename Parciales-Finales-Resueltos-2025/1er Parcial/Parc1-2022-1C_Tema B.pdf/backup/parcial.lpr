program parcial;

const TOP = 100;

Type
    ST3 = string[3];ST8 = string[7];
    TV = array[1..TOP] of byte;
    TVst3 = array[1..TOP] of st3;
    TVst8 = array[1..TOP] of st8;
    Tvr = array[1..TOP] of real;



Procedure Inicializar(var Vaux:TV; nz:byte);
var
  i:byte;
begin
     for i:=1 to nz do
         Vaux[nz]:=0;
end;

Function BuscarZona(Zona:st3; Vz2:TvSt3; nz:Byte):Byte;
var
   i:byte;
begin
     i:=1;
     while (i < nz) and (zona <> Vz2[i]) do
           i:= i+1;

     if Vz2[i] = Zona then
        BuscarZona:= i
     else
         BuscarZona:=0;
end;

Procedure LeerZonas(Var Vz2: TVst3; var Vf:TVr; var nz:byte);
var
   arch:text; zona:st3; factor:real;
begin
     assign(arch,'zonas.txt');reset(arch); nz:=0;

     while not eof(arch) do
           begin
                read(arch,zona); readln(arch,factor);
                nz:= nz+1;
                Vz2[nz]:= Zona; Vf[nz]:= factor;
           end;
     close(arch);
end;

Function BuscarFactor(zona:st3; Vz2:Tvst3; Vf:TVr; nz:byte):real;
var
   i:byte;
begin
     i:=1;
     while (i < nz) and (zona <> Vz2[i]) do
           i:= i+1;

     buscarFactor:= Vf[i];
end;

Function Multa(tipo:byte; Zona:st3; Vz2:TVst3; Vf:TVr; nz:byte):real;
var
   aux:word;
begin
     case tipo of        //Sintaxis correcta
     1:aux := 1000;
     2:aux := 2000;
     3:aux := 5000;
     end;
     Multa:= aux * BuscarFactor(Zona,Vz2,Vf,nz);
end;

procedure LeerRadar(Var Vt,Vv:TV; var Vz:TVst3; var Vp:TVst8; vz2: TVst3; Vf:TVr; Var n:byte; nz:byte; var Vm:TVr);
var
   arch:text; car:char; zona:st3; pat:st8;
   tipo,vel:byte; condM:boolean;            // i:byte; acum:word;
begin
     assign(arch,'Radar.txt');reset(arch);
     while not eof(arch) do
           begin
                read(arch,tipo,vel,car,zona,car,pat); condM:=false;

                if ((tipo=1) and (vel > 100)) OR     //Sintaxis correcta
                   ((tipo=2) and (vel > 110)) OR
                   ((tipo=3) and (vel > 90)) then
                   begin
                        n:= n+1;
                        Vt[n]:=tipo; Vv[n]:=vel; Vz[n]:=zona;
                        Vp[n]:=pat;
                        Vm[n]:= Multa(Tipo,Zona,Vz2,Vf,nz);
                   end;


                {
                case tipo of
                1: if(vel > 100) then condM:=true;
                2: if(vel > 110) then condM:=true;
                3: if(vel > 90) then condM:=true;
                end;

                if condM then
                   begin
                        n:= n+1;
                        Vt[n]:=tipo; Vv[n]:=vel; Vz[n]:=zona;
                        Vp[n]:=pat;
                        Vm[n]:= Multa(Tipo,Zona,Vz2,Vf,nz);
                   end;
           end;}

           end;
     close(arch);

     { Analisis de los datos almacenados (ignorar)
     acum:=0;
     for i:=1 to n do
         begin
              write(Vp[i],' ',Vv[i]);
              writeln();
              acum:= acum + Vv[i];
         end;
     Writeln(n,' ',acum);
     }
end;

procedure Promedio;
var
   arch:text; tipo,vel,cont:byte;
   acum:word;
begin
     assign(arch,'Radar.txt');reset(Arch); acum:=0; cont:=0;
     while not eof(arch) do
           begin
                readln(arch,tipo,vel);

                if ((tipo=1) and (vel<= 100)) OR     //Sintaxis correcta
                   ((tipo=2) and (vel<=110)) OR
                   ((tipo=3) and (vel<=90)) then
                   begin
                        acum:= acum+Vel;
                        cont:=cont + 1;
                   end;

                {
                case tipo of
                1: if vel <= 100 then      //Incorrecto
                   begin                   //Solo usar un case cuando tengo calculos o sentencias diferentes para cada valor
                        acum:= acum+Vel;
                        cont:=cont + 1;
                   end;
                2: if vel <=110 then
                   begin
                        acum:= acum+vel;
                        cont:=cont+1;
                   end;
                3: if vel <= 90 then
                   begin
                        acum:= acum+vel;
                        cont:= cont+1;
                   end;
                end;}

          end;
     //writeln('acum es: ',acum);
     writeln('El promedio de velocidad de los que no infligieron ninguna infraccion es: ',(acum/cont):8:2);
     close(arch);
end;

Procedure PatenteMax(Vv:TV; Vz,Vz2:TVst3; Vp:TVst8; n,nz:byte);
var
   pos,i:byte;   Vaux:TV;  Vpaux:Tvst8;
Begin
     Inicializar(Vaux,nz);
     For i:=1 to N do
         begin
              pos:=BuscarZona(Vz[i],Vz2,nz);
              if Vv[i] >= Vaux[pos] then
              begin
                 Vaux[pos]:=Vv[i];
                 Vpaux[pos]:=Vp[i];
              end;
         end;
     for i:=1 to nz do
         begin
              writeln('La patente con la maxima velocidad para la zona: ',Vz2[i],' Es:',Vpaux[i]);
         end;
end;

function Importe(Vz,Vz2: TVst3; n,nz:byte; Zona:st3; Vm:TVr):real;
var
   i,pos:byte;
   acum:real; //Si Vm acumula real entonces acum debe ser acumular real;
begin
          pos:= BuscarZona(zona,vz2,nz); acum:=0;
          if pos = 0 then
             writeln('La zona no existe')
          else
              begin
                   for i:=1 to n do
                       if Vz[i] = Vz2[pos] then
                          acum:= acum + Vm[i];
              end;
          Importe:= acum;
end;


Var
   Vt,Vv:TV; Vz:TVst3; Vp:TVst8; n,nz:byte;
   Vz2: TVst3; Vf,Vm:TVr; Zona:st8;
begin
     LeerZonas(Vz2,Vf,nz);
     LeerRadar(Vt,Vv,VZ,VP,Vz2,Vf,n,nz,Vm);
     Promedio;
     PatenteMax(Vv,Vz,Vz2,Vp,n,nz);
     writeln('Ingrese zona '); readln(Zona);
     writeln('El importe total de la zona es: ',Importe(Vz,Vz2,n,nz,Zona,Vm):8:2);
     readln;
end.
