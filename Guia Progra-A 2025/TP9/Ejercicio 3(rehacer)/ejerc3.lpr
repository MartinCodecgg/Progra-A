program ejerc3;

const
     TOP = 50; //en realidad seria 49 el maximo contando el 0
Type
    ST15=string[15];
    ST3=string[3];

    TregEsc=record
      cod:ST3;
      descrip:ST15;
      Pbase:real;
      Pcomida:real;
    end;
    TarchEsc = file of TregEsc;

    TregBol=record
      cod:ST3;
      nro:word;
      IncluyeCom:char;
    end;
    TarchBol=file of TregBol;

    TVesc=array[0..TOP] of ST3;
    TV=array[0..TOP] of byte;
    TVmonto=array[0..TOP] of real;

Procedure CrearBinarios(var archEsc:TarchEsc; var BOLETERIA:TarchBol);
var
   arch1,arch2:text; car:char;
   regEsc:TregEsc;
   regBol:TregBol;
begin
     assign(arch1,'excursiones.txt');
     assign(arch2,'boleteria.txt');
     reset(arch1);
     reset(arch2);

     //Creo binario de excursiones
     rewrite(archEsc);
     while not eof(arch1) do
           begin
                readln(arch1,regEsc.cod,car,regEsc.descrip,regEsc.Pbase,regEsc.Pcomida);
                write(archEsc,regEsc);
           end;
     close(arch1);

     //Creo binario de boleteria
     rewrite(BOLETERIA);
     while not eof(arch2) do
           begin
                readln(arch2,regBol.cod,car,regBol.nro,car,regBol.IncluyeCom);
                write(BOLETERIA,regBol);
           end;
     close(arch2);


     //Mostrar binarios Generado
     writeln('Mostrando Binario de escursiones');
     seek(archEsc,0);
     while not eof(archEsc) do
           begin
                read(archEsc,regEsc);
                writeln(regEsc.cod,' ',regEsc.descrip,' ',regEsc.Pbase:8:2,regEsc.Pcomida:8:2);
           end;

     writeln('Mostrando Binario de boleteria');
     seek(Boleteria,0);
     while not eof(Boleteria) do
           begin
                read(Boleteria,regBol);
                writeln(regBol.cod,' ',regBol.nro,' ',regBol.IncluyeCom);
           end;
     close(Boleteria);
     close(archEsc);
end;

Procedure GenerarV(var archEsc:TarchEsc; var Vcod:TVesc);
var
   regEsc:TregEsc; i:shortint;
begin
     reset(archEsc);
     i:=-1;
     while not eof(archEsc) do
           begin
                i:=i+1;
                read(archEsc,regEsc);
                Vcod[i]:=regEsc.cod;
           end;
end;

Function Buscar(Vesc:TVesc; n:byte; cod:ST3):byte;
var
   i:byte;
begin
     i:=0;
     while (i<n) and (Vesc[i]<>cod) do
           i:=i+1;

     buscar:=i;
end;

Procedure Listado(var archEsc:TarchEsc; var BOLETERIA:TarchBol; Vcod:TVesc);
var
   regEsc:TregEsc;
   regBol:TregBol;
   pos,i,contSIcomida:byte;
   Vboletos,Vcomida:TV;
   Vmonto:TVmonto;
begin
     reset(archEsc);
     reset(BOLETERIA);
     //Inicializar vectores paralelos
     for i:=0 to filesize(ArchEsc) do
         begin
              Vmonto[i]:=0;
              Vboletos[i]:=0;
              Vcomida[i]:=0;
         end;

     contSIcomida:=0;
     while not eof(BOLETERIA) do
           begin
                read(BOLETERIA,regBol);
                pos:=buscar(Vcod,filesize(archEsc),regBol.cod);
                Vboletos[pos]:=Vboletos[pos] + 1;
                seek(archEsc,pos);
                read(archEsc,regEsc);
                Vmonto[pos]:=Vmonto[pos] + regEsc.Pbase;
                if regBol.IncluyeCom = 'S' then
                   begin
                        Vmonto[pos]:=Vmonto[pos] + regEsc.Pcomida;
                        Vcomida[pos]:=Vcomida[pos] + 1;
                        contSIcomida:=contSIcomida+1;
                   end;
           end;
     //Finalmente el listado pedido
     writeln('Listado:');
     writeln(filesize(archEsc));
     //Filesize devuelve la cantidad de registros.
     //Pero Como los registros van del 0 al valor, entonces
     //por el 0 hay que hacer valor-1 siempre
     for i:=0 to filesize(archEsc)-1 do

         begin
              seek(archEsc,i);
              read(archEsc,regEsc);
              writeln(regEsc.cod,'  ',Vboletos[i],'  ',Vcomida[i],'  ',Vmonto[i]:8:2);
         end;

     writeln('El porcentaje de clientes que pidieron comida es: ',
                 (contSIcomida/filesize(BOLETERIA))*100:8:2);
end;

var
   archEsc:TarchEsc;  BOLETERIA:TarchBol; Vcod:TVesc;
begin
     assign(archEsc,'Excursiones.dat');
     assign(Boleteria,'Boleteria.dat');
     CrearBinarios(archEsc,BOLETERIA);
     GenerarV(archEsc,Vcod);
     Listado(archEsc,BOLETERIA,Vcod);
     readln;
end.
