program ejerc8;

type
    st30=string[30];

const
     N = 3;  //Cantidad de clientes

function Descuento(tipo:char;dia:byte;monto:real):byte;
begin
     if (tipo = 'O') and (dia in [10,20,30]) and (monto > 300) then
        Descuento:=5
     else if (dia in [15..31]) and (tipo = 'C') then
          Descuento:=10
     else if (dia in [1..15]) and (tipo = 'S') then
          Descuento:=15;
end;

{procedure calcularTotalyDesc(var total:real;var totalDesc:byte;var condALLDesc:boolean);

var
   tipo:char;
   dia,aux:byte;
   monto:real;
   arch:text;
   codigo:st30;
   cond1,cond2,cond3:boolean;
begin
     assign(arch,'datos.txt');reset(arch);
     cond1:=false;
     cond2:=false;
     cond3:=false;

     readln(arch,codigo);
     readln(arch,tipo);
     tipo:=upcase(tipo);

     while tipo <> 'F' do
           begin
                readln(arch,dia);
                readln(arch,monto);
                aux:=Descuento(tipo,dia,monto);

                if aux = 15 then
                   cond1:=true
                   else if aux = 10 then
                        cond2:=true
                        else if aux = 5 then
                             cond3:=true;

                totalDesc:= totalDesc + aux;
                total:= total + monto;

                readln(arch,tipo);
                tipo:=upcase(tipo);
           end;

     if totalDesc = 0 then
          writeln('El cliente ',codigo,' Abono un total de: ',total:8:2)
     else
         writeln('El cliente ahorro ',(total * (totalDesc/100)):8:2);

     if cond1 and cond2 and cond3 then
        condAllDesc:=true;
end;

var
   i,totalDesc,cont3rubros:byte;
   total:real;
   condAllDesc:boolean;
begin
     cont3rubros:=0;
     for i:=1 to N do
         begin
              total:=0;
              totalDesc:=0;
              condALLDesc:=false;
              calcularTotalyDesc(total,totalDesc,condAllDesc);

              if condAllDesc then
                 cont3rubros:=cont3rubros + 1;
         end;

     writeln('La cantidad de clientes que obtuvieron descuento en los 3 rubros fueron: ',cont3rubros);
     readln;
end. }
//La lectura de un archivo no se leer por separado, se lee en un procedimiento o en el programa principal, sino hay que usar variables globales
var
   tipo:char;
   dia,aux,i,cont3rubros,totalDesc:byte;
   monto,total:real;
   arch:text;
   codigo:st30;
   cond1,cond2,cond3:boolean;
begin
     assign(arch,'datos.txt');reset(arch);
     cont3rubros:=0;

     for i:=1 to N do
         begin
              total:=0;
              totalDesc:=0;
              cond1:=false;
              cond2:=false;
              cond3:=false;

              readln(arch,codigo);
              readln(arch,tipo);
              tipo:=upcase(tipo);

              while tipo <> 'F' do
                         begin
                              readln(arch,dia);
                              readln(arch,monto);
                              aux:=Descuento(tipo,dia,monto);

                              if aux = 15 then
                                 cond1:=true
                                 else if aux = 10 then
                                      cond2:=true
                                      else if aux = 5 then
                                           cond3:=true;

                              totalDesc:= totalDesc + aux;
                              total:= total + monto;

                              readln(arch,tipo);
                              tipo:=upcase(tipo);
                         end;

              if cond1 and cond2 and cond3 then
                 cont3rubros:=cont3rubros + 1;

              if totalDesc = 0 then
                   writeln('El cliente ',codigo,' Abono un total de: ',total:8:2)
              else
                  writeln('El cliente ahorro ',(total * (totalDesc/100)):8:2);
         end;

     writeln('La cantidad de clientes que obtuvieron descuento en los 3 rubros fueron: ',cont3rubros);
     readln;
end.


{Ej 8) En un archivo de texto se registraron las compras de N titulares de tarjetas de crédito de la siguiente
forma:
- Código de Cliente y a continuación sus compras: no se sabe cuántas son, por cada una:
• Tipo de compra: (C=combustible, S=supermercado, O=otros, F=fin de datos)
UNMDP – FI Programación I
Pág. 2
• Día (1..31)
• Monto
El banco ofrece un descuento de:
- 5% los días 10, 20 y 30 para el tipo Otros si el monto supera los $300.
- 10% para Combustible en la 2º quincena.
- 15% para Supermercado en la 1º quincena.
Se pide:
a) Código del cliente y total abonado, por cada cliente que no se benefició con ningún descuento.
b) Cuántos clientes obtuvieron descuento en los tres rubros.
c) Informar cuánto ahorró cada cliente.
En la solución debe desarrollar la función Descuento, que a partir del tipo de compra, día y monto
devuelva el correspondiente descuento.}
