{Ej 5) Dado un archivo ALUMNOS.DAT con las notas de alumnos cuyo diseño de registro es:
# MATRICULA (campo de secuencia, clave primaria)
# NOTA en MATEMÁTICA (0..10)
# NOTA en FISICA I (0..10)
# NOTA en QUIMICA I (0..10)
y un archivo de inscriptos (INSCRIPTOS.DAT) en QUIMICA II y FISICA II cuyo diseño de registro es:
# MATRICULA (campo de secuencia, clave primaria)
# QUIMICA II (1=inscripto, 0=no inscripto)
# FISICA II (1=inscripto, 0=no inscripto)
Obtener un listado con la matrícula de aquellos alumnos inscriptos que no cumplan con los requisitos de
equivalencia exigidos, que son: para FISICA II, tener aprobados MATEMATICA y FISICA I, y para
QUIMICA II, tener aprobado QUIMICA I. (se aprueba con NOTA >=4)
}
program ejerc5;

const
     TOP=100;
Type
    ST5=string[5];

    TregAlum=record
      mat:ST5;
      matematica,fisica1,quimica1:real;
    end;
    TarchAlum=file of TregAlum;

    TregInscrip=record
      mat:ST5;
      quimica2,fisica2:byte;
    end;
    TarchInscrip=file of TregInscrip;

    TVmat=array[0..TOP] of ST5;

Procedure CrearBinario(var archAlum:TarchAlum; var archInscrip:TarchInscrip);
var
   arch1,arch2:text;
   regAlum:TregAlum;
   regInscrip:TregInscrip;
   i:byte;
begin
     assign(arch1,'alumnos.txt');
     assign(arch2,'inscriptos.txt');
     reset(arch1); reset(arch2);
     rewrite(archAlum);
     while not eof(arch1) do
           begin
                readln(arch1,regAlum.mat,regAlum.matematica,regAlum.fisica1,regAlum.quimica1);
                write(archAlum,regAlum);
           end;

    rewrite(archInscrip);
    while not eof(arch2) do
          begin
               readln(arch2,regInscrip.mat,regInscrip.fisica2,regInscrip.quimica2);
               write(archInscrip,regInscrip)
          end;

    //Muestro Binarios usando for
    seek(archAlum,0);
    seek(archInscrip,0);
    for i:=0 to filesize(archAlum)-1 do
        begin
             read(archAlum,regAlum);
             writeln(regAlum.mat,regAlum.matematica:8:2,regAlum.fisica1:8:2,regAlum.quimica1:8:2);
        end;
    for i:=0 to filesize(archInscrip)-1 do
        begin
             read(archInscrip,regInscrip);
             writeln(regInscrip.mat,' ',regInscrip.fisica2,' ',regInscrip.quimica2);
        end;
    close(archAlum); close(archInscrip);
    close(arch1); close(arch2);

end;

Procedure GenerarVmat(var archAlum:TarchAlum; var Vmat:TVmat);
var
   regAlum:TregAlum;  i:byte;
begin
     reset(archAlum);

     for i:=0 to filesize(archAlum)-1 do
         begin
              read(archAlum,regAlum);
              Vmat[i]:=regAlum.mat;
         end;
     close(archAlum);
end;

Function Buscar(Vmat:TVmat; n:byte; mat:ST5):byte;
var
   i:byte;
begin
    i:=0;
    while (i<n) and (Vmat[i]<>mat) do
          i:=i+1;

    buscar:=i;
end;

Procedure Listado(var archAlum:TarchAlum; var archInscrip:TarchInscrip; Vmat:Tvmat);
var
   regInscrip:TregInscrip;
   regAlum:TregAlum;
   i,pos:byte;
begin
     reset(archAlum);
     reset(archInscrip);

     for i:=0 to filesize(archInscrip)-1 do
         begin
              read(archInscrip,regInscrip);
              pos:=buscar(Vmat,filesize(archAlum)-1,regInscrip.mat);
              seek(archAlum,pos);
              read(archAlum,regAlum);
              if ((regInscrip.fisica2=1) and ((regAlum.fisica1<4) or (regAlum.matematica<4))) Or
                   ((regInscrip.quimica2=1) and (regAlum.quimica1<4))                         then

                   writeln('El alumno con matricula: ',regInscrip.mat,' No cumple con los requisitos de equivalencia requeridos');
         end;
     close(archAlum); close(archInscrip);
end;

var
   archAlum:TarchAlum; archInscrip:TarchInscrip; Vmat:TVmat;
begin
     assign(archAlum,'alumnos.dat');
     assign(archInscrip,'inscriptos.dat');
     CrearBinario(archAlum,archInscrip);
     GenerarVmat(archAlum,Vmat);
     Listado(archAlum,archInscrip,Vmat);
     readln;
end.
