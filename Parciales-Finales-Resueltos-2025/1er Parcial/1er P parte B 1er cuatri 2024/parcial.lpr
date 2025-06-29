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
              //Supongo que el archivo es valido, es decir al menos el primer DNI debe ser valido
     writeln('Ingrese DNI');readln(DNI);
     repeat   //Hubiese sido mejor usar un while directamente, ya que tambien valido que no venga vacio
           begin
                writeln('Ingrese cant. de parcelas a informar'); readln(parcelas);
                for i:=1 to parcelas do
                    begin
                         n:=n+1;
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
                            end
                         else n:= n-1;
                    end;
                writeln('Ingrese DNI');readln(DNI);
           end;
     until DNI = '999';
end;

function cant(Vt,Va,Vc:TV; n:byte):byte;
var
   i,cont:byte;
begin
     cont:=0;
     for i:=1 to n do
         begin
              if ((vt[i]<>0) and (Va[i] = 0) and (Vc[i] = 0) OR
                 (Vt[i] = 0) and (Va[i] = 0) and (Vc[i] <> 0) OR
                 (Vt[i] = 0) and (Va[i] = 0) and (Vc[i] <> 0)) then
                    cont:=cont+1;
         end;
     cant:= cont;
end;


Function Rinde(Vt,Va,Vc,Vhas:TV; n,x:byte):boolean;
var
   i:byte; cond:boolean;
begin
     cond:=true; i:=1;
     while (i <= n) and cond do //Solo en la busquedas pasa que se usa (i < n), porque se evalua por separado la ultima iteracion
           begin                //Si no se evalua por separado la ultima iteracion hay que hacer (i <= n)
                i:= i+1;
                if ((Vt[i] > 0 ) and (Va[i] > 0) and (Vc[i] > 0)
                   and ((Vhas[i]/(Vt[i] + Va[i] + Vc[i])) < X )) then
                                        cond:=false;
           end;
               Rinde:=cond;
end;

var
   Vhas,Vt,Va,Vc:TV;
   n,x:byte;

begin
     //Almacenar
     Leer(Vhas,Vt,Va,Vc,n);
     //Inciso A
     writeln('La cantidad de productores que han cosechado un unico cereal es: ',cant(Vt,Va,Vc,n));

     //Inciso B
     writeln('Ingrese X'); readln(x);
     if Rinde(Vt,Va,Vc,Vhas,n,x) then
        writeln('Todos los productores superaron el rinde ingresado por teclado')
     else
         writeln('No todos superaron el rinde');
     readln;
end.   //56,09 min
