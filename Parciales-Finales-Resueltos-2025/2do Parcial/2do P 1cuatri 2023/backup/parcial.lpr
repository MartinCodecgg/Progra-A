program parcial;

{
Const TOP = 100;

Type
    TMT = array[1..TOP,1..TOP] of byte;
    TregNiv = record
            nivel,total:byte;
            prom:real;
    end;
    TVreg = array[1..TOP]of TregNiv;   }
const
  TOP = 100;
  Nmax = 5; // Filas
  Mmax = 3; // Columnas

type
  TMT = array[1..Nmax, 1..Mmax] of byte;
  TMTr = array[1..Nmax, 1..Mmax] of real;
  TregNiv = record
            nivel,total:byte;
            prom:real;
  end;
  TVreg = array[1..TOP]of TregNiv;

const
  MatAutos: TMT = (
    (4, 5, 15),
    (1, 0, 3),
    (0, 3, 9),
    (6, 8, 7),
    (2, 1, 3)
  );

  MatHoras: TMTr = (
    (9.5, 15.0, 20.0),
    (6.0, 0.0, 24.0),
    (15.3, 10.5, 9.0),
    (12.0, 11.0, 14.0),
    (4.0, 1.0, 6.5)
  );


Procedure Mostrar(Vniv:TVreg; nv:byte);
var
   i:byte;
begin
     For i:=1 to nv do
         writeln(Vniv[i].nivel,' ',Vniv[i].total,' ',Vniv[i].prom:8:2)
end;

Procedure InciA(mtA:TMT; mtH:TMTr;  Var Vniv:TVreg; n,m:byte; var nv:byte);
var
   i,j:byte; cond:boolean;
begin
     For i:=1 to n do
         Begin
              Vniv[nv+1].nivel:=i; Vniv[nv+1].total:=0;
              Vniv[nv+1].prom:=0; cond:=true;
              j:=1;
              While (j<=m) and cond do
                    begin
                         if mtA[i,j] = 0 then
                            cond:=false
                         else
                             begin
                                  Vniv[nv+1].total:=Vniv[nv+1].total + mtA[i,j];
                                  Vniv[nv+1].prom:=Vniv[nv+1].prom + mtH[i,j];
                             end;
                         j:=j+1;
                    end;
              if cond then
                 begin
                      nv:=nv+1;
                      Vniv[nv].prom:=Vniv[nv].prom/Vniv[nv].total;
                 end;
         end;
     Mostrar(Vniv,nv);
end;

{
Function InciB(mtA: TMT; n,m,tope,x:byte):byte;
begin
     if n=0 then
        InciB:=0
     else
         begin
              if m>1 then
                 begin
                      if mtA[n,m] > x then
                         InciB:=1+InciB(mtA,n-1,tope,tope,x)
                      else
                          InciB:=InciB(mtA,n,m-1,tope,x);
                 end
              else
                  begin
                       if mtA[n,m] > x then
                          InciB:= 1+InciB(mtA,n-1,tope,tope,x)
                       else
                           InciB:=InciB(mtA,n-1,tope,tope,x);
                  end;
         end
end;
}

Function InciB(mtA: TMT; n,m,tope,x:byte):byte;
begin
     if n=0 then
        InciB:=0
     else
         begin
              if mtA[n,m] > x then   //saco factor comun esta expresion
                 InciB:=1+InciB(mtA,n-1,tope,tope,x)
              else
                  begin
                       if m>1 then
                          InciB:=InciB(mtA,n,m-1,tope,x)
                       else
                           InciB:=InciB(mtA,n-1,tope,tope,x);
                  end;
         end
end;

var
   mtA:TMT; mtH:TMTr;  Vniv:TVreg;
   n,m,nv,x:byte;

begin
     //Lectura
     m:=3; n:=5;
     mtA:=matAutos;
     mtH:=matHoras;
     InciA(mtA,mtH,Vniv,n,m,nv);
     writeln('Ingrese X'); readln(x);
     writeln('La cantidad de niveles que cumplen la condicion es: ',InciB(mtA,n,m,m,x));
     readln;
end.

