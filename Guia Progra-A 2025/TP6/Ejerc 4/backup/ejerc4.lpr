program ejerc4;

const
     TOP = 10;
type
    TMT = array[1..TOP,1..TOP] of byte;

Procedure Inicializar(var mt:TMT);
var
   i,j:byte;
begin
     for i:=1 to TOP do
         for j:=1 to TOP do
             mt[i,j]:=0;
end;

Procedure Leer(var mt:tmt; var n,m:byte);
var
   i,j,fila,col,dat:byte;
   arch:text;
begin
     assign(arch,'datos.txt');reset(arch);
     m:=0; n:=0;
     while not eof(arch) do
           begin
                readln(arch,fila,col,dat);
                mt[fila,col]:=dat;
                if fila > n then
                   n:=fila;

                if col > m then
                   m:=col;
           end;

     writeln('N y M son:',n,' ',m);
     for i:=1 to n do
         begin
              for j:=1 to m do
                  write(mt[i,j]:4);
              writeln;
         end;

end;


Function Validar(mt:TMT; n:byte):boolean;      //Cuando recorro el triangulo inferior de la matriz o debajo de la diagonal principal no necesito el m
var                                                  //IMPORTANTE !!, ya que recorro las columnas hasta que j=i-1
   i,j:byte;
begin
     i:=2;
     while (i<=n) do     //Para el while de este caso el i debe incluir al N para recorrer toda la matriz
           begin
                j:=1;
                while (j<i-1) and (mt[i,j] = 0) do
                           j:=j+1;
                if mt[i,j] = 0 then
                   i:=i+1
                else
                    i:=n+2;  //Si no llega a ser cero le doy un valor muy falso para que salga de ambos while
           end;

     if (i<>n+2) and (mt[i,j] = 0) then  //Valido que no sea el valor falso
        Validar:=true
     else
         Validar:=false;

end;

var
   mt:TMT; n,m:byte;
begin
     Inicializar(mt);
     Leer(mt,n,m);

     if n=m then
        begin
             if Validar(mt,n) then
                writeln('La matriz es triangular superior')
             else
                 writeln('La matriz No es triangular superior');
        end
     else
         writeln('La matriz no es cuadrada');
     readln;
end.
