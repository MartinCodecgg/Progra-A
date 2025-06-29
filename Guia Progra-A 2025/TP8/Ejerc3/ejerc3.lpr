program ejerc3;

function confuso(a,b:integer):integer;     //Calcula el doble de un numero
begin

 if (b = 0) then
 confuso := 0
 else
 if (b mod 2 = 0) then
 confuso := confuso(a+a, b div 2)
 else
 confuso := confuso(a+a, b div 2) + a;
end;

begin
     writeln(confuso(2,3));
     readln;
end.
// La función confuso(a, b) simplemente calcula a * b
// — usando una técnica recursiva basada en duplicación y división entera.

