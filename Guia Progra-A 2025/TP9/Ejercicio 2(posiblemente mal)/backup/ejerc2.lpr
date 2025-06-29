{Ej 2) Un Banco registra en TARJETAS.DAT el movimiento de las tarjetas de crédito de sus usuarios.
# NUMERO de TARJETA (1er campo de secuencia, clave primaria)
# NOMBRE del PROPIETARIO
# TOPE
# GASTO del MES (hasta el momento)
Además, se van ingresando (desde teclado ó archivo de texto) las compras con los siguientes datos:
- Número de Tarjeta (puede repetirse)
- Monto
- Código de operación
Procesar los datos, actualizando los gastos del mes, siempre que no supere el monto tope, en caso
contrario, rechazarlo y grabar en un archivo RECHAZADOS.DAT con la siguiente información:
# NUMERO de TARJETA
# CODIGO DE OPERACION
# MONTO
Sugerencia: para obtener la dirección relativa y acceder en forma directa al archivo TARJETAS, descargar
del mismo los números de tarjeta sobre un arreglo (tabla). }
program ejerc2;

Const
     TOP = 100;    //Procedurar primero antes de hacer un ejercicio asi, pensar y anotar la logica en papel, es decir como pienso hacerlo
Type                   //y luego recien hacerlo
    ST16 = string[16];
    ST3 = string[3];
    TregTar = record
             nro:ST16; nom:ST3; Tope,gasto:real;
    end;
    TarchTar = file of TregTar;

    TregErr = record
        nro:ST16; cod:byte; monto:real;
    end;
    TarchErr = file of TregErr;

    TVnro = array[0..TOP] of ST16;
    TVmonto = array[0..TOP] of real;


Procedure CrearBinario(var ArchTar:TarchTar);
var
   arch:text;
   regTar:TregTar;   car:char;
begin
     assign(arch,'tarjetas.txt'); reset(arch);
     rewrite(archTar);
     while not eof(arch) do
           begin
                readln(arch,regTar.nro,car,regTar.nom,regTar.Tope,regTar.gasto);
                write(archTar,regTar);
           end;

     //Mostrando binarios
     writeln('Mostrando Binarios');
     seek(archTar,0);
     while not eof(archTar) do
           begin
                read(archTar,regTar);
                writeln(regTar.nro,' ',regTar.nom,' ',regTar.Tope:8:2,' ',regTar.gasto:8:2);
           end;
    close(arch); close(archTar);
    writeln;
end;

Procedure CrearAccesoDirecto(var ArchTar:TarchTar; var Vdir:TVnro; var Vmonto:TVmonto; var ndir:shortint);
var
   regTar:TregTar;
begin
    reset(archTar);  //Recordar para cada nuevo procedimiento que uso nuevamente el archivo, debere abrir y cerrar el archivo
    ndir:=-1;
    while not eof(archTar) do
          begin
               ndir:=ndir+1;
               read(archTar,regTar);
               Vdir[ndir]:=regTar.nro;
               Vmonto[ndir]:=regTar.gasto;
          end;
end;

Function BuscarNro(Vnro:TVnro; n:byte; nro:st16):shortint;
var
   i:byte;
begin
     i:=0;
     while (i<n) and (Vnro[i] <> nro) do
           i:=i+1;

     if Vnro[i] = nro then
        buscarNro:=i
     else
       buscarNro:=-1;

end;

Procedure ProcesarCompras(var ArchTar:TarchTar; Vdir:TVnro; var Vmonto:TVmonto; ndir:byte; var ArchErr:TarchErr);
var
   arch:text; archTemp:TarchTar; cod:byte;
   pos:byte; i:shortint;  nro:ST16; monto:real;
   regTar:TregTar;
   regErr:TregErr;
begin
    assign(arch,'compras.txt'); reset(arch);
    rewrite(ArchErr);

    //Armo vectores paralelos
    while not eof(arch) do
          begin
               readln(arch,nro,cod,monto);
               pos:=buscarNro(Vdir,ndir,nro);
               writeln('pos es: ',pos);
               seek(archTar,pos);
               read(archTar,regTar);
               writeln('tope y monto :',regTar.Tope:8:2,' ',monto:8:2);
               if regTar.Tope <= monto then
                  begin
                       Vmonto[pos]:=Vmonto[pos] + monto;
                       writeln('Se actualiza Vmonto en posicion', pos);
                  end
               else
                   begin
                        writeln('error');
                        regErr.nro:=regTar.nro;
                        regErr.cod:=cod;
                        regErr.monto:=monto;
                        write(archErr,regErr);
                   end;
          end;

    assign(archTemp,'temp.dat');
    rewrite(archTemp); reset(archTar);

    //Creo archivo temporal que luego reemplazara al original
    seek(archTar,0);
    i:=-1;
    while not eof(archTar) do
          begin
               i:=i+1;
               read(archTar,regTar);
               regTar.gasto:=Vmonto[i];
               write(archTemp,regTar);
          end;
    close(archTar);
    close(archTemp);
    erase(archTar);   //Antes de borrar o renombrar un archivo debo cerrarlo con close
    rename(archTemp,'Tarjetas.dat');

    writeln('Mostrando archivo actualizado');
    reset(archTemp);
    while not eof(archTemp) do
          begin
               read(archTemp,regTar);
               writeln(regTar.nro,' ',regTar.nom,' ',regTar.Tope:8:2,' ',regTar.gasto:8:2);
          end;
    close(archTemp);
    writeln;

    writeln('Mostrando archivo de errores');
    reset(archErr);
    while not eof(archErr) do
          begin
               read(archErr,regErr);
               writeln(regErr.nro,' ',regErr.cod,' ',regErr.monto:8:2);
          end;
    close(archErr);
end;

var
   ArchTar:TarchTar; ArchErr:TarchErr; Vdir:TVnro; Vmonto:TVmonto; ndir:shortint;
begin
     assign(ArchTar,'Tarjetas.dat');
     assign(ArchErr,'Rechazados.dat');
     CrearBinario(ArchTar);
     CrearAccesoDirecto(ArchTar,Vdir,Vmonto,ndir);
     ProcesarCompras(archTar,Vdir,Vmonto,ndir,ArchErr);
     readln;
end.
