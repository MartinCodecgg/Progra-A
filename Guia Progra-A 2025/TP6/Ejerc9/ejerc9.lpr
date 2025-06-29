program ejerc9;

const TOP = 4;   N=4;

type
    st10 = string[10];
    TMTc = array[1..TOP,1..TOP] of char;
    TMT = array[1..TOP,1..TOP] of byte;

const
     T1:TMTc = (('A','R','R','A'),
                ('R','R','R','A'),
                ('R','R','A','A'),
                ('R','R','A','A'));

     T2:TMT = ((1,7,4,3),
             (2,2,5,10),
             (2,8,5,20),
             (5,8,10,9));

Function InciA():st10;
var
  i,j,contAzul,contRojo:byte;
begin
     contAzul:=0; contRojo:=0;
     for i:=1 to N do
         for j:=1 to N do
             if T1[i,j] = 'A' then
                contAzul:=contAzul+1
             else
                 contRojo:=ContRojo+1;

     if contRojo > contAzul then
        InciA:= 'Rojo'
     else
         InciA:='Azul';
end;

Function InciB():st10;
var
  i,j,contAzul,contRojo:byte;
begin
     contAzul:=0; contRojo:=0;
     for i:=1 to N do
         for j:=1 to N do
             if T1[i,j] = 'A' then
                contAzul:=contAzul + T2[i,j]
             else
                 contRojo:=ContRojo + T2[i,j];

     if contRojo > contAzul then
        InciB:= 'Rojo'
     else
         InciB:='Azul';
end;

Function InciC():byte;  //Mucho ojo si pide evaluar columna o evaluar fila
var                        //Si pide columna es siempre primero j y luego i, si pide fila es primero i y luego j
  i,j,cont:byte; primerColor:char;
begin
     cont:=0;
     for J:=1 to N do
         begin
              primerColor:=T1[1,j];
              i:=2;
              while (i<N) and (T1[i,j] = primerColor) do
                    i:=i+1;

              if T1[i,j] = primercolor then
                 cont:=cont+1;
         end;
     InciC:=cont;
end;

begin
     writeln('El color predominante es: ',InciA());
     writeln('El color que tiene mas fichas es :',InciB());
     writeln('La cantidad de columnas de un solo color es :',InciC());
     readln;
end.

