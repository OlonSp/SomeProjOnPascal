uses Graph3D;

var
  an: AnimationBase;

// Простое перемещение
function Moving1(a, b: PrismT) := 
  a.AnimMoveBy(2, 0, 0, 2) * b.AnimMoveBy(-2, 0, 0, 2);

// Вращения
function Moving2(a, b: PrismT) := 
  a.AnimRotateAt(OrtZ,180, P3D(1,0,0), 2) 
    * a.AnimRotate(OrtZ, -180, 2) // важно!
    * b.AnimRotateAt(OrtZ,180, P3D(-1,0,0), 2) 
    * b.AnimRotate(OrtZ, -180, 2); // важно!

procedure Swap(var a, b: PrismT);
begin
  if an = nil then 
    an := Moving1(a, b)
  else
    an := an + Moving1(a, b);
  (a, b) := (b, a);
end;

procedure Sort(a: array of PrismT);
begin
  for var k := 1 to 5 do
    for var i := 0 to a.Length - k - 1 do
      if a[i].Height > a[i + 1].Height then
        Swap(a[i], a[i + 1]);
end;

begin
  var a := new PrismT[6];
  var x := -5;
  for var i := 0 to 5 do
  begin
    a[i] := Prism(x, 0, 0, 4, Random(1.0, 10.0), 1, RandomColor);
    x += 2;
  end;  
  Sort(a);
  an.Begin;
end.
