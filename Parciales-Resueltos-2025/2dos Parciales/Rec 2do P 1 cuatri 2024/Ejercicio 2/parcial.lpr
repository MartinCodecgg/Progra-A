program parcial;

Const TOP = 3;   //TOP deberia ser 100, tomo datos genericos para ver si funciona mi programa

Type
    TMT = array[1..TOP,1..TOP] of byte;

const
     mat:TMT = ((1,1,1),
               (4,5,6),
               (7,8,9));

Function Suma(mt:TMT; i,j,n:byte):byte;
begin
     if i=0 then
        suma:=0
     else
         begin
              if j > i+1 then
                 suma:= mt[i,j] + Suma(mt,i,j-1,n)
              else
                  suma:=mt[i,j] + suma(mt,i-1,n,n);
         end;
end;

Function Calcular(mt:TMT; i,j,n:byte; prom:real):byte;
begin
     if j=0 then
        Calcular:=0     //Cuando hago recursividad por columas se invierte todo practicamete, lo que era i sera j, TODO ES INVERSAAMENTE IGUAL
     else
         begin
              if mt[i,j] > prom then
                 calcular:=1 + calcular(mt,n,j-1,n,prom)
              else
                  begin
                       if i>1 then
                          calcular:=calcular(mt,i-1,j,n,prom)
                       else
                           calcular:=calcular(mt,n,j-1,n,prom);
                  end;
         end;
end;

var
   mt:TMT; n:byte; prom:real;
begin
     n:=3;
     mt:=mat;
     prom:=suma(mt,n-1,n,n)/(((n*n)-n)/2);    //Recordarse reglas para recorrer las matrices y formulas, es n-1 a 1 para i en este caso
     writeln('Promedio es: ',prom:8:2);
     writeln('La cantidad de columnas que cumplen la condicion de tener algun elemento  mayor al promedio es: ',Calcular(mt,n,n,n,prom));
     readln;
end.
