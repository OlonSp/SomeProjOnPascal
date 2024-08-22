uses GraphWPF;

const StartSpeed = 50;

procedure RunParticle(x, y, alpha, speed, force : real);
begin
  if (speed < 1) or (x > Window.Width) then
    exit;
  
  if (speed > StartSpeed/5) and (Random < 0.03) and (speed < StartSpeed*0.75) then
  begin
    //  Распад частицы на несколько
    RunParticle(x, y, alpha + Random(-0.1,-0.2), speed*0.94, force);
    RunParticle(x, y, alpha + Random(0.1,0.2), speed*0.95, force);
    RunParticle(x, y, alpha, speed*0.15, force*Random(10,20));
  end
  else
  begin
    //  Просто движение частицы
    alpha += force;
    var (x2,y2) := (x + speed * cos(alpha), y - speed * sin(alpha));
    Pen.Width := 1+speed/20;
    Pen.Color := Colors.White;
    if Random > 0.2 then
      Line(x,y,x2,y2);
    RunParticle(x2, y2, alpha, speed*0.993, force);
  end;  
end;

begin
  Window.Maximize;
  Window.Clear(Colors.Black);
  loop 20 do
    RunParticle(0, Window.Height/2, DegToRad(Random(-1, 1)), Random(StartSpeed*0.8, StartSpeed), Random(-0.01, 0.01));
  Window.Save('Wilson2.jpg');
end.