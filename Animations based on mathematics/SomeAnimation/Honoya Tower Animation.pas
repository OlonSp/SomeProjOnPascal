  Uses GraphWPF;
  
  
  
  var Tower1, Tower2, Tower3 : array of integer;
  var cols : array of Color;
  
Procedure DrawAll;
begin
  Window.Clear;
  for var i := 0 to tower1.High do
    FillRectangle(150 - (50 + Tower1[i]*30)/2 , 450 - 50*i, 50 + Tower1[i]*30, 45,cols[Tower1[i]]);
  for var i := 0 to tower2.High do
    FillRectangle(400 - (50 + Tower2[i]*30)/2 , 450 - 50*i, 50 + Tower2[i]*30, 45,cols[Tower2[i]]);
  for var i := 0 to tower3.High do
    FillRectangle(650 - (50 + Tower3[i]*30)/2 , 450 - 50*i, 50 + Tower3[i]*30, 45,cols[Tower3[i]]);
  Sleep(200);
end;

  
procedure Hanoi(var Source, dest, tmp : array of integer; N : integer);
begin
  if n > 1 then Hanoi(Source, tmp, dest, n - 1);
  dest := dest + Source[Source.High:];
  Source := Source[:Source.High];
  //Println(Source,Dest,Tmp) ;  
  DrawAll;
  if n > 1 then Hanoi(Tmp, Dest, Source, n - 1);
  
  
end;


begin
  Tower1 := Arr(7,6,5,4,3,2,1);
  Tower2 := new integer[0];
  Tower3 := new integer[0];
  cols := ArrGen(Tower1.Length+1, i -> RandomColor);
  //Println(tower1,Tower2,tower3);
  DrawAll;
  Hanoi(Tower1,Tower3,Tower2, Tower1.length);
  //Println(tower1,Tower2,tower3);
end.
