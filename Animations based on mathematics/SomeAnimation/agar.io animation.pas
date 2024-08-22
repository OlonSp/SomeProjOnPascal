uses WPFObjects;

begin
  var (w,h) := (800,600);
  Window.SetSize(w,h);
  Window.CenterOnScreen;
  loop 50 do
  begin
    var a := new CircleWPF(Random(50, w-50), Random(50, h-50),
      Random(10.0,50.0), CLRandom);
    (a.Dx, a.Dy) := Random2(-3.0, 3.0);
  end;
  while True do
  begin
     foreach var a in Objects do
     begin
       
       if a.Left <= 0 then
         a.Dx := abs(a.Dx)
       else if a.Left + a.Width >= Window.Width then
         a.Dx := -abs(a.Dx);
       if a.Top <= 0 then
         a.Dy := abs(a.Dy)
       else if a.Top + a.Height >= Window.Height then
         a.Dy := -abs(a.Dy);
       
       a.Move;
       
       foreach var b in a.IntersectionList do
         if a.Width < b.Width then
          begin
            a.Dx := 100; b.Width += 4; b.Left -= 2; b.Top -= 2;
          end
         else
         begin
           b.Dx := 100; a.Width += 4; a.Left -= 2; a.Top -= 2;
         end;
     end;
     for var i := Objects.Count - 1 downto 0 do
       if Objects[i].Dx = 100 then
         Objects[i].Destroy;
     Sleep(10);
  end;
end.