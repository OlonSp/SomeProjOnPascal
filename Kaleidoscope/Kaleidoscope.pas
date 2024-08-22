uses GraphABC;

begin
  var w := 200;
  Window.SetSize(2 * w, 2 * w);
  Window.CenterOnScreen;
  var p := new Picture(w, w);
  Pen.Color := clTransparent;
  while True do
  begin
    p.Clear;
    for var i := 1 to 300 do
    begin
      Brush.Color := ARGB(Random(100, 200),
        Random(256), Random(256), Random(256));
      var a := Random(0, 359);
      p.Pie(Random(0, w-1), Random(0, w-1), Random(10, 70), 
        a, a + Random(20, 90));
    end;
    p.Draw(0,0);
    p.FlipVertical;
    p.Draw(0,w);
    p.FlipHorizontal;
    p.Draw(w,w);
    p.FlipVertical;
    p.Draw(w,0);
    Window.Save(Random(0,9) + '.png');
    Sleep(1000);
  end;
end.
