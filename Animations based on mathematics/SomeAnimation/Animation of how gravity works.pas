uses GraphWPF;

const eps = 0.01;
 timeStep = 0.01;
        G = 6.2;

type Particle = class
  x, y : real;
  dx, dy : real;
  ax, ay : real;
  m : real;
  
  constructor Create(x, y, dx, dy, m : real);
  begin
    self.x := x; self.y := y;
    self.dx := dx; self.dy := dy;
    self.m := m;
  end;
  
  procedure ResetAccel;
  begin
    ax := 0; ay := 0;
  end;
  
  procedure AffectBy(other : Particle);
  begin
    var VectorX := other.x - x;
    var VectorY := other.y - y;
    var r2 := max(eps, sqr(VectorX) + sqr(VectorY));
    var A := G * other.m / r2;
    ax += VectorX * A;
    ay += VectorY * A;
  end;
  
  procedure Move;
  begin
    dx += ax * timeStep; dy += ay * timeStep;
    x += dx * timeStep; y += dy * timeStep;
    FillCircle(x, y, m/2, Colors.DarkBlue);
  end;
end;

begin
  
  window.CenterOnScreen;
  window.Maximize;
  var planets := new list<particle>;
  
  
  planets.Add(new Particle(window.Width/2, Window.Height/2, 0, 0, 200));
  
  for var i := 1 to 10 do
    planets.Add(new Particle(Random(100,1000), Random(100,1000), random(0,20), random(0,20), 10));
  
  while true do
  begin
    //Window.Clear;
    BeginFrameBasedAnimation(planets[0].Move);
    foreach var i in planets do
      if i <> Planets.First then
      begin
      i.resetAccel;
      foreach var e in planets do
        if not (e = i) then
          i.AffectBy(e);
      i.Move ;
      //Sleep(100);
    end;
  end;
  {var p1 := new Particle(100,100,10,0,20);
  var p2 := new Particle(500,120,-3,10,10);
  var p3 := new Particle(350,400,-8,-2,25);
  
  while true do
  begin
    
    planets[0].Move;
    
    p1.ResetAccel;
    p2.ResetAccel;
    p3.ResetAccel;
    
    p1.AffectBy(p2);
    p1.AffectBy(p3);
    p1.AffectBy(planets[0]);
    
    p2.AffectBy(p1);
    p2.AffectBy(p3);
    p2.AffectBy(planets[0]);
    
    p3.AffectBy(p1);
    p3.AffectBy(p2);
    p3.AffectBy(planets[0]);
    
    p1.Move;
    p2.Move;
    p3.Move;
    
    
  end;}
  
end.