{Ej 1) Una empresa de transporte de encomiendas tiene un registro de los paquetes a transportar en un
archivo PAQUETES.DAT, de cada uno se conoce:
# CODIGO de PAQUETE
# PESO
# CODIGO de DESTINO (1..30)
# MONTO ASEGURADO
Por otro lado se cuenta con un archivo DESTINO.DAT que contiene:
# CODIGO de DESTINO (1..30, desordenado)
# DESCRIPCION (cadena de 15)
Se desea saber:
a) El peso promedio de los paquetes.
b) Total del monto asegurado de la carga a transportar.
c) Al finalizar el proceso armar el siguiente listado:
Destino Cantidad de Paquetes
Xxxxxxxxxxxxxxxx 99
. . . . . .
TOTAL}

program ejer1;

const
     Destinos = 30;

Type
     ST15= string[5];

     TregArPaq = record
         cod,Dest:byte; peso,monto:real;
     end;
     TarPaq = file of TregArPaq;

     TregArDest = record
         Dest:byte; Descrip:ST15;
     end;
     TarDest = file of TregArDest;

     TVdest = array[1..Destinos] of byte;


Procedure CrearBinario(Var ArPaq:TarPaq; Var ArDest:TarDest);
var
   TextPaq,TextDest:text;
   car:char;

   regPaq:TregArPaq;
   regDest:TregArDest;
begin
     assign(TextPaq,'paquetes.txt');
     assign(TextDest,'Destino.txt');
     rewrite(ArPaq); rewrite(ArDest);
     reset(TextPaq);reset(TextDest);

     //Generar Binarios
     while not eof(TextPaq) do
           begin
                read(TextPaq,regPaq.cod,regPaq.peso,regPaq.dest,regPaq.monto);
                Write(ArPaq,regPaq);
           end;

     while not eof(TextDest) do
           begin
                read(TextDest,regDest.Dest,car,regDest.Descrip);
                Write(ArDest,regDest);
           end;

     writeln('Mostrando Binarios');
     writeln('Dimesion de archivo de paquetes ',fileSize(ArPaq));
     writeln('Dimesion de archivo de Destinos ',fileSize(ArDest));
     Seek(ArPaq, 0);
     Seek(ArDest, 0);
     //Mostrar Binarios Generados
     while not eof(ArPaq) do
           begin
                read(ArPaq,regPaq);
                writeln(regPaq.cod,' ',regPaq.peso:8:2,' ',regPaq.dest,' ',regPaq.monto:8:2);
           end;

     while not eof(ArDest) do
           begin
                read(ArDest,regDest);
                Writeln(regDest.Dest,' ',regDest.Descrip);
           end;
end;

Procedure PesoProm(Var ArPaq:TarPaq);
var
   Paq:TregArPaq;  acumPeso:real;   cont:byte;
begin
     reset(ArPaq);
     acumPeso:=0; cont:=0;
     while not eof(ArPaq) do
           begin
                read(ArPaq,paq);
                acumPeso:=acumPeso + paq.PESO;
                cont:=cont+1;
           end;
     writeln('El peso promedio de los paquetes es: ',acumPeso/cont:8:2);
end;

Procedure MontoTotal(Var ArPaq:TarPaq);
var
   Paq:TregArPaq;  acumMonto:real;
begin
     reset(ArPaq);
     acumMonto:=0;
     while not eof(ArPaq) do
           begin
                read(ArPaq,paq);
                acumMonto:=acumMonto + paq.Monto;
           end;
     writeln('El monto total de los paquetes es: ',acumMonto:8:2);
end;

Procedure GenerarVdest(Var ArPaq:TarPaq; Var Vdest:TVdest);
var
   Paq:TregArPaq;  i:byte;
begin
     reset(ArPaq);

     for i:=1 to Destinos do
         Vdest[i]:=0;

     while not eof(ArPaq) do
           begin
                read(ArPaq,paq);
                Vdest[paq.dest]:=Vdest[paq.dest]+1;
           end;
end;

Procedure Listado(Var ArPaq:TarPaq; Var ArDest:TarDest; Vdest:TVdest);
var
   dest:TregArDest;
begin
     reset(ArPaq);
     reset(ArDest);
     //Seek(ArPaq, 0);
     //Seek(ArDest, 0);

     while not eof(ArDest)do
           begin
                read(ArDest,dest);
                writeln('Destino: ',dest.Dest,'. Cantidad de Paquetes: ',Vdest[dest.Dest]);
           end;

end;

var
   ArPaq:TarPaq; ArDest:TarDest;  Vdest:TVdest;
begin
     assign(ArPaq,'Paquetes.dat');
     assign(ArDest,'Destino.dat');
     CrearBinario(ArPaq,ArDest);
     PesoProm(ArPaq);
     MontoTotal(ArPaq);
     GenerarVdest(ArPaq,Vdest);
     Listado(ArPaq,ArDest,Vdest); //Enves de crear un procedimiento convenia crear este vector en la lectura pero como supongo que ya tengo el archivo
     readln;                         //Entonces da lo mismo [preguntar]
end.
