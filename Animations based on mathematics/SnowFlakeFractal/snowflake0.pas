// Нарисовать снежинку по предложенным картинкам
// Рисовать крест с помощью двух линий, начиная с центра,
// потом рекурсивно рисовать на каждой ветви снежинки, смещая центр и уменьшая размер в 2 раза

uses Turtle,GraphWPF;



Procedure SnowFlake(n : integer; w : real);
begin
  if n = 0 then
  begin
    //Forw(w);
    exit;
  end;
  n := n - 1;
  
  Forw(w);
  SnowFlake(n,w/2);
  Turn(180);
  Forw(w);
  SnowFlake(n,w/2);
  Turn(-90);
  Forw(w);
  SnowFlake(n,w/2);
  Turn(180);
  Forw(w);
  SnowFlake(n,w/2);
  Forw(w);
  SnowFlake(n,w/2);
  Turn(180);
  Forw(w);
  SnowFlake(n,w/2);
  Turn(90);
  Forw(w);
  SnowFlake(n,w/2);
  Turn(180);
  Forw(w);
  SnowFlake(n,w/2);
  
end;

begin
  Window.SetSize(800,900);
  Window.CenterOnScreen;
  ToPoint(Window.Width/2,Window.Height/2);
  Down;
  var w := window.Width/4;
  SnowFlake(5,w);
  
end.