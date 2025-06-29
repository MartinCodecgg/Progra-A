program ejerc10;

const
     TOP = 17;

type
    TV = array[1..TOP] of shortint;

const
     A:TV =(3, 5, -1, 3, 8, 2, -5, 2, 10, -4, -8, 4, 6, 7,-3, 11, 2);

procedure ArmarVecs(vecA:TV; na:byte; var vecB,vecC:TV; var nbc:byte);
var
   i:byte;
   sum,cont:word;
begin
     i:=1;
     nbc:=0;
     while vecA[i] > 0 do     //Recordar al no usar for, no avanza de forma automatica, tampoco leo de un archivo para que avance
           i:=i + 1;         //por ello forzar el avanze del numero negativo haciendo i:= i + 1;
     i:= i + 1;
     while i <= na do
           begin
                cont:=0;
                sum:=0;
                while vecA[i] > 0 do
                      begin
                           cont:= cont +1;
                           sum:= sum + vecA[i];     //Asi como si leo de un archivo debo poner un read por for
                           i:= i +1;                //Para este caso igual, sino entra en bucle infinito
                      end;
                if vecA[i] < 0 then
                nbc:= nbc +1;
                vecB[nbc]:= sum;
                vecC[nbc]:= cont;
                i:= i + 1;
           end;
end;

procedure mostrarVectores(vecB,vecC:TV; nbc:byte);
var
   i:byte;
begin
     for i:= 1 to nbc do
         write(vecB[i], ' ');
     writeln();
     for i:=1 to nbc do
         write(vecC[i],' ');
end;

var
   vecA,vecB,vecC:TV;
   na,nbc:byte;
begin
     vecA:=A;
     na:=TOP;
     armarVecs(vecA,na,vecB,vecC,nbc);     //Cada vez que hago un cambio en el nombre de una variable, debo cambiar su nombre en todos lados tambien
     mostrarVectores(vecB,vecC,nbc);
     readln;
end.

{Ej 10) Dado un arreglo A, generar dos arreglos paralelos B y C donde B contiene la suma de los
elementos de A que están entre dos negativos y C la cantidad que se sumó. Mostrar B y C.
Ejemplo:
A=(3, 5, -1, 3, 8, 2, -5, 2, 10, -4, -8, 4, 6, 7,-3, 11, 2)  B=(13, 12, 0, 17) C=(3, 2, 0, 3)
}
