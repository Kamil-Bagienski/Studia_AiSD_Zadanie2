// // AiSD5_Z1 Ćwiczenie zaliczeniowe nr 2, v.01, 14.01.2023
// Bagieński Kamil, 155623, 2022/2023, Informatyki, Zarządzania i Transportu, D1, I
program ZadanieZaliczeniowe2;
uses CRT;
type
  TStos = record
    Dane: Integer;
    Nast: ^TStos;
  end;
  Pstos = ^TStos;
  TKolejka = record
    Dane: Integer;
    Nast: ^TKolejka;
  end;
  TPary = record
    Pierwsza: Integer;
    Druga: Integer;
  end;
  PKolejka = ^TKolejka;

procedure IniTKolejka(var GLOWA: PKolejka);
begin
  GLOWA := nil;
end;

function JestPusty(GLOWA: PKolejka): Boolean;
begin
  JestPusty := (GLOWA = nil);
end;

procedure DodajDoKolejki(var GLOWA: PKolejka; Wartosc: Integer);
var
  OGON: PKolejka;
begin
  New(OGON);
  OGON^.Dane := Wartosc;
  OGON^.Nast := GLOWA;
  GLOWA := OGON;
end;

function ZdejmijZKolejki(var GLOWA: PKolejka): Integer;
var
  OGON: PKolejka;
begin
  if JestPusty(GLOWA) then
  begin
    Writeln('Kolejka jest pusta.');
    ZdejmijZKolejki := -1;
  end
  else
  begin
    OGON := GLOWA;
    GLOWA := GLOWA^.Nast;
    ZdejmijZKolejki := OGON^.Dane;
    Dispose(OGON);
  end;
end;

procedure PokazKolejke(GLOWA: PKolejka);
var
  i:integer;
begin
  i:=0;
  if JestPusty(GLOWA) then
    Writeln('Kolejka jest pusta.')
  else
  begin
    while GLOWA <> nil do
    begin
      i:=i+1;
        Writeln(i:2,': ',GLOWA^.Dane, ' ');
        GLOWA := GLOWA^.Nast;
    end;
    Writeln;
  end;
end;
procedure IniTStos(var GLOWA: Pstos);
begin
  GLOWA := nil;
end;

function JestPusty(GLOWA: Pstos): Boolean;
begin
  JestPusty := (GLOWA = nil);
end;

procedure Dodaj(var GLOWA: Pstos; Wartosc: Integer);
var
  OGON: Pstos;
begin
  New(OGON);
  OGON^.Dane := Wartosc;
  OGON^.Nast := GLOWA;
  GLOWA := OGON;
end;

function Zdejmij(var GLOWA: Pstos): Integer;
var
  OGON: Pstos;
begin
  if JestPusty(GLOWA) then
  begin
    Writeln('Stos jest pusty.');
    Zdejmij := -1;
  end
  else
  begin
    OGON := GLOWA;
    GLOWA := GLOWA^.Nast;
    Zdejmij := OGON^.Dane;
    Dispose(OGON);
  end;
end;

procedure PokazStos(GLOWA: Pstos);
begin
  if JestPusty(GLOWA) then
    Writeln('Stos jest pusty.')
  else
  begin
    while GLOWA <> nil do
    begin
        Writeln(GLOWA^.Dane, ' ');
        GLOWA := GLOWA^.Nast;
    end;
    Writeln;
  end;
end;

procedure PodzielKolejka(GLOWA: PKolejka; var ParzysteS, NieparzysteS: Pstos);
begin
  IniTStos(ParzysteS);
  IniTStos(NieparzysteS);
  while GLOWA <> nil do
  begin
    if (GLOWA^.Dane mod 2 = 0) then
      Dodaj(ParzysteS, GLOWA^.Dane)
    else
      Dodaj(NieparzysteS, GLOWA^.Dane);
    GLOWA := GLOWA^.Nast;
  end;
end;

procedure PolaczoneStosys(ParzysteS, NieparzysteS: Pstos; var Laczenie: array of TPary; var Uzyte: integer);
var
  i,Y: Integer;
  para: TPary;
begin
  i := 0;
  Uzyte := 0;
  Y:=4;
  while (not JestPusty(ParzysteS)) and (not JestPusty(NieparzysteS)) do
  begin
    para.Pierwsza := Zdejmij(ParzysteS);
    para.Druga := Zdejmij(NieparzysteS);
    Laczenie[i] := para;
    Inc(i);
    Inc(Uzyte);
  end;
  i:=0;
  if not JestPusty(ParzysteS) then
  begin


    while not JestPusty(ParzysteS) do
    begin
      i:=i+1;
      gotoXY(40,Y);
      Writeln(i,': ',Zdejmij(ParzysteS));
      Y:=Y+1
    end;
  end else if not JestPusty(NieparzysteS) then
  begin

    while not JestPusty(NieparzysteS) do
    begin
      i:=i+1;
      gotoXY(20,Y);
      Writeln(i,': ',Zdejmij(NieparzysteS));
      Y:=Y+1
    end;
  end else begin
    Writeln('Obydwa stosy sa puste');
  end;
end;

procedure PokazTablice(Uzyte,Y:integer; Laczenie: array of TPary);
var
  i:integer;
   begin
  for i:=0 to Uzyte-1 do
  begin
  gotoXY(60,Y);
  Writeln(i+1:2,': ',Laczenie[i].pierwsza:3, ' ', Laczenie[i].druga);
  Y:=Y+1
  end;
end;


var
  GLOWA: PKolejka;
  ParzysteS, NieparzysteS: Pstos;
  I,Uzyte,Y: Integer;
  Laczenie: array[1..25] of TPary;
begin
  Randomize;
  writeln('Program: Cwiczenie zaliczeniowe nr 2: kolejka,stos,tablica');
  writeln('Autor: Bagienski Kamil, 155623, 2022/2023, Informatyk, Zarzadzania i Transportu, D1, I');
  IniTKolejka(GLOWA);
  Y:=4;
  for I := 1 to 25 do
  begin
  DodajDoKolejki(GLOWA, Random(1000));
  end;
  gotoXY(1,3);
  Writeln('---KOLEJKA---');
  PokazKolejke(GLOWA);
  PodzielKolejka(GLOWA, ParzysteS, NieparzysteS);
  gotoXY(20,3);
  Writeln('---STOS NPAR---');
  gotoXY(40,3);
  Writeln('---STOS PAR---');
  PolaczoneStosys(ParzysteS, NieparzysteS, Laczenie,Uzyte);
  gotoXY(60,3);
  Writeln('---TABLICA PAR---');
  PokazTablice(uzyte,Y,Laczenie);


  Readln;
end.

