program parcial;

const TOP = 100;

Type
    st8 = string[8];
    TV = array[1..TOP] of byte;

Procedure Leer(Var Vhas,Vt,Va,Vc:TV; Var n:byte);
var
   DNI:st8; tipo:char;
   parcelas,has,tons,i:byte;

begin
     n:=0;
     repeat
           writeln('Ingrese DNI');readln(DNI);
           if DNI <> '999' then
              begin
                   writeln('Ingrese cant. de parcelas a informar'); readln(parcelas);
                   if parcelas <> 0 then
                      n:=n+1;
                   for i:=1 to parcelas do
                       begin
                            writeln('Ingrese total de Has sembradas');
                            readln(has);
                            if has <> 0 then
                               begin
                                    writeln('Ingrese Tipo'); readln(tipo);
                                    tipo:=upcase(tipo);
                                    writeln('Ingrese cant. de ton.');readln(tons);
                                    case tipo of
                                    'T': Vt[n]:=Vt[n] + tons;
                                    'A': Va[n]:=Va[n] + tons;
                                    'C': Vc[n]:=Vc[n] + tons;
                                    end;

                                    Vhas[n]:=Vhas[n] + has;
                               end;
                       end;
              end;
     until DNI = '999';

     for i:=1 to n do
         begin
              writeln(Vt[i]);
              writeln(Va[i]);
              writeln(Vc[i]);
         end;
end;

function cant(Vt,Va,Vc:TV; n:byte):byte;
var
   i,cont:byte;
begin
     cont:=0;
     for i:=1 to n do
         begin
              if ((vt[i]<>0) and (Va[i] = 0) and (Vc[i] = 0) OR
                 (Vt[i] = 0) and (Va[i] <> 0) and (Vc[i] = 0) OR
                 (Vt[i] = 0) and (Va[i] = 0) and (Vc[i] <> 0)) then
                    cont:=cont+1;
         end;
     cant:= cont;
end;


Function Rinde(Vt,Va,Vc,Vhas:TV; n,x:byte):shortint;
var
   i:byte; cond,condPri:boolean;
begin
     cond:=true; condPri:=false; i:=1;
     while (i <= n) and cond do //Solo en la busquedas pasa que se usa (i < n), porque se evalua por separado la ultima iteracion
           begin                //Si no se evalua por separado la ultima iteracion hay que hacer (i <= n)
                writeln(Vhas[i]);
                writeln(Vt[i]);
                writeln(Va[i]);
                writeln(Vc[i]);
                if ((Vt[i] > 0 ) and (Va[i] > 0) and (Vc[i] > 0)) then
                    begin
                         condPri:=true;
                         if ((Vhas[i]/(Vt[i] + Va[i] + Vc[i])) < X ) then
                            begin
                                 writeln('Entro if');
                                 cond:=false;
                            end;
                    end;
                i:= i+1;
           end;
     if condPri and cond then
        Rinde:=1
     else if condPri then
         Rinde:=0
     else
         Rinde:=-1;
end;

var
   Vhas,Vt,Va,Vc:TV;
   n,x:byte;  aux:shortint;

begin
     //Almacenar
     Leer(Vhas,Vt,Va,Vc,n);
     //Inciso A
     writeln('La cantidad de productores que han cosechado un unico cereal es: ',cant(Vt,Va,Vc,n));

     //Inciso B
     writeln('Ingrese X'); readln(x);
     aux:= Rinde(Vt,Va,Vc,Vhas,n,x);
     if aux = 1 then
        writeln('Todos los productores superaron el rinde ingresado por teclado')
     else if aux = 0 then
         writeln('No todos superaron el rinde')
     else
         writeln('Ningun productor cosecho los 3 tipos de cereales');
     readln;
end.   //56,09 min
