Program ejerc13;

var
tipo:char;
precio:real;

begin

Readln( Tipo, Precio); Tipo := Upcase(Tipo);
{P=panadería, F=fiambrería, A=almacén}
While (Tipo<>’P’) and (Tipo<>’F’) and (Tipo<>’A’) do
Begin
Readln (Tipo); Tipo := Upcase(Tipo);
End;



repeat
      Readln( Tipo, Precio); Tipo := Upcase(Tipo);
until (Tipo='P') or (Tipo='F') or (Tipo='A');
end.


