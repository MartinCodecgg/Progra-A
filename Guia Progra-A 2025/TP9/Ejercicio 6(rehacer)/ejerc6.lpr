{Ej 6) Una empresa paga a fin de mes a sus empleados una comisión del 0.5% sobre las ventas
efectuadas, para ello almacena el acumulado mensual de ventas en un archivo cuyo diseño de registro es:
UNMDP – FI Programación I
Pág. 3
# LEGAJO (campo de secuencia, clave primaria)
# NOMBRE y APELLIDO
# TOTAL de VENTAS
# NRO de FACTURA de MAYOR VENTA del MES
# IMPORTE de MAYOR VENTA del MES
Al final del día actualiza los registros de ese archivo con las ventas efectuadas almacenadas en otro
archivo cuyo diseño de registro es:
# LEGAJO (campo de secuencia, clave secundaria)
# NRO de FACTURA
# IMPORTE
Se pide actualizar el primer archivo y listar las comisiones que le corresponden hasta el momento a cada
empleado. }
program ejerc6;

Const
     TOP=100;
Type
    ST10=string[10];

    TregEmpl=record
      leg:word;
      nomYapel:ST10;
      total:real;
      nroFac:word;
      impMayor:real;
    end;
    TarchEmpl=file of TregEmpl;

    TregDia=record
      leg:word;
      nroFac:word;
      Imp:real;
    end;
    TarchDia=file of TregDia;

    TVleg=array[0..TOP] of word;

Procedure CrearBinarios(var archEmpl:TarchEmpl; var archDia:TarchDia);
var
   arch1,arch2:text;
   regEmpl:TregEmpl;
   regDia:TregDia;
   i:byte;
   car:char;
begin
     assign(arch1,'empleados.txt'); assign(arch2,'ventasDiarias.txt');
     rewrite(archEmpl);
     rewrite(archDia);
     reset(arch1); reset(arch2);

     while not eof(arch1) do
           begin
                readln(arch1,regEmpl.leg,car,regEmpl.nomYapel,regEmpl.total,regEmpl.nroFac,regEmpl.impMayor);
                write(archEmpl,regEmpl);
           end;

     while not eof(arch2) do
          begin
               readln(arch2,regDia.leg,regDia.nroFac,regDia.imp);
               write(archDia,regDia);
          end;

    //Mostrando binarios generados
    //(Es indistinto usar for o while, for usa una variable i:byte de mas pero for es mas seguro antes ciclos infinitos que while)
    seek(archEmpl,0);
    seek(archDia,0);
    for i:=0 to filesize(archEmpl)-1 do
        begin
             read(archEmpl,regEmpl);
             writeln(regEmpl.leg,' ',regEmpl.nomYapel,' ',regEmpl.total:8:2,' ',regEmpl.nroFac,' ',regEmpl.impMayor:8:2);
        end;
    writeln;
    for i:=0 to filesize(archDia)-1 do
        begin
             read(archDia,regDia);
             writeln(regDia.leg,' ',regDia.nroFac,' ',regDia.imp:8:2)
        end;
    close(arch1); close(arch2);
    close(archEmpl); close(archDia);
end;

Procedure GenerarV(var archDia:TarchDia; var Vleg:TVleg);
var
   regDia:TregDia;
   i:byte;
begin
    reset(archDia);
     for i:=0 to filesize(archDia)-1 do
         begin
              read(archDia,regDia);
              Vleg[i]:=regDia.leg;
         end;
     close(archDia);
end;

//La funcion de Busqueda es totalemente innesaria si los archivos de tipo vienen ordenados por el numero de legajo(campo de secuencia)

Procedure Actualizar(var archEmpl:TarchEmpl; var archDia:TarchDia; Vleg:TVleg);
var
   regDia:TregDia;
   regEmpl:TregEmpl;
   i:byte;
   archTemp:TarchEmpl;
begin
     reset(archEmpl);
     reset(archDia);
     assign(archTemp,'Temp.dat');
     rewrite(archTemp); //Debo abrir para escritura el archivo recien creado

     for i:=0 to filesize(archEmpl)-1 do
         begin
              read(archEmpl,regEmpl);
              if Vleg[i]=regEmpl.leg then //Es decir si el empleado con tal legajo vendio en el dia me quedo con lo que vendio antes + en el dia
                 begin                      //Sino con solo lo que vendio antes
                      seek(archDia,i);
                      read(archDia,regDia);
                 end;
              if regDia.leg = regEmpl.leg then
                 begin
                      regEmpl.total:=regEmpl.Total+regDia.imp;
                      if regDia.imp>regEmpl.impMayor then
                         begin
                              regEmpl.impMayor:=regDia.imp;
                              regEmpl.nroFac:=regDia.nroFac;
                         end
                 end;
              write(archTemp,regEmpl);

         end;

     close(archEmpl);
     erase(archEmpl);
     close(archTemp);   //RECORDAR: tanto para rename o erase debo cerrar antes el archivo
     rename(archTemp,'Empleados.dat');

     //Listado
     writeln('Listado');
     reset(archTemp);
     writeln(filesize(archTemp));
     for i:=0 to filesize(archTemp)-1 do
         begin
              read(archTemp,regEmpl);
              writeln('El empleado con legajo: ',regEmpl.leg,' Tiene una ganancia de: ',regEmpl.total*0.05:8:2);
         end;
     close(archDia);
     close(archTemp);
end;

var
   archEmpl:TarchEmpl; archDia:TarchDia; Vleg:TVleg;
begin
     assign(archEmpl,'Empleados.dat');
     assign(archDia,'ventasDiarias.dat');
     CrearBinarios(archEmpl,archDia);
     GenerarV(archDia,Vleg); //Genero un vector con los legajos de empleados que vendieron en el archivo DEL DIA
     Actualizar(archEmpl,archDia,Vleg);
     readln;
end.
