
// Кривая Коха - рисование (использовать модуль Turtle черепашьей графики)
// https://en.wikipedia.org/wiki/Koch_snowflake

uses GraphWPF,Turtle;

Procedure Koch(n : integer; w :real);
Begin
  If n = 0 then
  begin
    Forw(w);
    
    exit;
  end;
  
  n := n - 1;
  
  Koch(n,w/3);
  
  Turn(-60);
  Koch(n,w/3);
  Turn(120);
  Koch(n,w/3);
  Turn(-60);
  
  Koch(n,w/3);
end;

begin
  ToPoint(50.0,Window.Height/2.7);
  var w := Window.Width - 100;
  Window.SetSize(800,1000);
  Window.CenterOnScreen;
  var k := 6;
  
  for var i := 0 to k-1 do
  begin
    Window.Clear;
    ToPoint(50.0,Window.Height/2.7);
    Down;
    Koch(i,w);
    Turn(120);
    Koch(i,w);
    Turn(120);
    Koch(i,w);
    sleep(200);
    Turn(120);
  end;
end.