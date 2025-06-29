program ejerc7;

const N = 11;   //10 cifras son 1 000 000 000   dividir por este numero e ir bajando ,n=11 por si la suma da una cifra mas
                    //Es decir v[1]= 0 se reserva una posicion por si la suma supera las 10 cifras
type
    TV = array[1..N] of byte;

procedure numAVec(var vec1,vec2:TV; n1,n2:int64);
var
   i:byte;
   numAdividir:int64;
begin
     //Almacenar numero 1
     vec1[1]:=0;
     numAdividir:=10000000000;
     for i:=2 to N do
         begin
              numAdividir:=numAdividir div 10;
              vec1[i]:= n1 div numAdividir;
              n1:= n1 mod numAdividir;
         end;

     vec2[1]:=0;
     numAdividir:=10000000000;
     for i:=2 to N do
         begin
              numAdividir:=numAdividir div 10;
              vec2[i]:= n2 div numAdividir;
              n2:= n2 mod numAdividir;
         end;
end;

procedure sumar(var vec1:TV; vec2:TV);
var
   i,pasar:byte;
begin
     for i:=N downto 2 do
         begin
              vec1[i]:= vec1[i] + vec2[i];

              if (vec1[i] div 10 > 0) then
                 begin
                      pasar:=vec1[i] div 10;
                      vec1[i]:=vec1[i] mod 10;
                      vec1[i-1]:= vec1[i-1] + pasar;
                 end;
         end;
end;

procedure ArmarNuevoNum(vec1:TV);
var
   i:byte;
begin
     write('La suma es:    ');
     for i:=1 to N do
         begin
              if vec1[i] <> 0 then
              write(vec1[i]);
         end;
end;

var
   n1,n2:int64;
   vec1,vec2:TV;
begin
     writeln('A continuacion ingrese dos numeros muy grandes de 10 cifras sin decimales y n1 > n2; Por ejemplo n = 1234567891 o tambien para probar que pasa si la suma pasa los 10 digitos n = 9999999999');
     readln(n1,n2);
     numAVec(vec1,vec2,n1,n2);
     sumar(vec1,vec2);
     ArmarNuevoNum(vec1);
     readln;
end.
