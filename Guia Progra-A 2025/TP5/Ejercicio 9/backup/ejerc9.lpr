program ejerc9;

const
     TOP = 100;                      //[Preguntar la parte B si se entiende]

type
    TV = array[1..TOP] of byte;

procedure almacenar(var vA:TV; var nA:byte);
var
   pri,seg:shortint;
   arch:text;
begin
     assign(arch,'datos.txt');reset(arch);nA:=0;
     read(arch,pri);
     nA:= 1;
     vA[nA]:= pri;

     while not eof(Arch) do
           begin
                read(arch,seg);

                if seg > pri then
                   begin
                        nA:= nA + 1;
                        vA[nA]:= seg;
                   end;
                if seg > 0 then
                pri:=seg;                                   // 1 2 3 4 5 6 7
                                                            // 1 2 3 4 5 6
           end;
end;

procedure generar2doArreglo(vA: TV; nA:byte; var vB: TV);
var
   i,aux:byte;

begin   // si i = 5 , aux = 1
     for i:=1 to nA do
         begin
              aux:= i - (trunc(na/2) + 1);      //El aux se tiene que volver a calcular en cada for  //El aux el elemento simetrico o central del array
              if i <= (trunc(na/2) + 1) then
                 begin
                      if (vA[nA -i + 1] mod vA[i]) = 0 then
                         vB[i]:=vA[i]
                      else
                          vb[i]:=0;
                 end
              else if vb[(trunc(na/2) + 1) - aux] <> 0 then  //Se puede quitar la variable aux y optmizar mas
                      vB[i]:= vA[i]
              else
                  vB[i]:=0;
         end;
end;

procedure mostrarArreglos(vA: TV; nA:byte; vB: TV);
var
   i:byte;

begin
     for i:=1 to nA do
         begin
              write(vA[i],' ');
         end;
     writeln();
     for i:=1 to nA do
         begin
              write(vB[i],' ');
         end;
end;

var
   vA,vB:TV;
   nA:byte;
begin
     almacenar(vA,nA);
     generar2doArreglo(vA,nA,vB);
     mostrarArreglos(va,na,vb);
     readln;
end.
