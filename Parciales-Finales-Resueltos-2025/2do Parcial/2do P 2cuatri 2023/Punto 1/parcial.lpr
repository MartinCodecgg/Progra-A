program parcial;   Uses Sysutils; //Esto para poder usar la funcion trim que quita los espacios a un string, usada en la lectura

Const
     TOP = 100; DolarOfficial = 360; silos = 10;

Type
    ST10 = String[10];
    TMT = array[1..TOP,1..silos] of real;
    TregS = record
          tipo:ST10; precio:real;
    end;
    TVregS = array[1..TOP] of TregS;

    TregB = record
            silo:byte; total:real;
    end;
    TVregB = array[1..TOP] of TregB;



Procedure Listar(Vb:TVregB ; nb:byte);
var
   i:byte;
begin
     for i:=1 to nb do
         writeln(Vb[i].silo,'  ',Vb[i].total:8:2);
end;

Procedure LeerCereal(Var Vsilo:TVregS; var n:byte);
var
   arch:text; tipo:ST10;
begin
     assign(arch,'Cereales.txt'); reset(arch); n:=0;
     while not eof(arch) do
           begin
                n:=n+1;
                readln(arch,tipo,Vsilo[n].precio);
                Vsilo[n].tipo:=trim(tipo);
           end;
     close(arch);

end;

Procedure Inicializar(Var mt:TMT; n:byte);
var
   i,j:byte;
begin
     for i:=1 to n do
         for j:=1 to 10 do
             mt[i,j]:=0;
end;

Function Buscar(Vsilo:TVregS; tipo:st10):byte;
var
   i:byte;
begin
     i:=1;
     while Vsilo[i].tipo <> tipo do
           i:=i+1;
     buscar:=i;
end;

Procedure LeerExpo(Var mt:TMT; Vsilo:TVregS; n:byte);
var
   arch:text; cod,pos,i,j:byte; tipo:st10;
   ton:real; car:char;
begin
     assign(arch,'exportaciones.txt'); reset(arch);
     Inicializar(mt,n);
     while not eof(arch) do
           begin
                readln(arch,cod,car,tipo,ton);
                pos:=buscar(Vsilo,trim(tipo));
                mt[pos,cod]:=mt[pos,cod] + ton;
           end;
     close(arch);

     for i:=1 to n do
         begin
              for j:=1 to 10 do
                  write(mt[i,j]:8:2);
         writeln;
         end;
end;

Function InciA(mt:TMT; Vsilo:TVregS; tipo:st10):byte;
var
   j,cont,pos:byte;
begin
     cont:=0;
     pos:=buscar(Vsilo,tipo);
     for j:=1 to 10 do
         if mt[pos,j] <> 0 then
            cont:=cont+1;
     InciA:=cont;
end;

Procedure InciB(mt:TMT; Vsilo:TVregS; n:byte; var Vb:TVregB; Var nb:byte; Z:real);
var
   j,i:byte; acumPrecio,acum1,aux:real;
begin
     for j:=1 to silos do
         begin
              acumPrecio:=0; acum1:=0;
              for i:=1 to n do
                  begin
                       acumPrecio:=acumPrecio+mt[i,j]*Vsilo[i].precio;
                       acum1:=acum1+mt[i,j];
                  end;

              if acum1 > Z then      //La condicion pide sobre el total de toneladas, y pide guardar el total en pesos
                 begin                 //Dado que nos piden recorrer solo una vez no queda otra que usar dos variables acumuladoras
                      nb:=nb+1;
                      Vb[nb].silo:=j;
                      aux:=acumPrecio * DolarOfficial;
                      if aux > 1000000000 then
                         aux:=aux*1.25
                      else
                          aux:=aux*0.95;

                      Vb[nb].total:=aux;
                 end;
         end;
     Listar(Vb,nb);
end;

var
   mt:TMT; Vsilo:TVregS; n,aux,nb:byte;
   tipo:st10; z:real; Vb:TVregB;
begin
     LeerCereal(Vsilo,n);
     LeerExpo(mt,Vsilo,n);
     writeln('Ingrese el tipo de cereal'); readln(tipo);
     aux:=InciA(mt,Vsilo,tipo);
     if aux = 0 then
        writeln('No se encuentra guardado en ningun silo')
     else
         writeln('Se encuentra guardado en:', aux,' Silos');
     writeln('Ingrese Z'); readln(z);
     InciB(mt,Vsilo,n,Vb,nb,z);
     readln;     //1hs, 1hs 10 min con prueba
end.
