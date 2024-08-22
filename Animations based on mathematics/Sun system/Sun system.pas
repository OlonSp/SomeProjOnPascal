uses Graph3D;
begin
  View3D.BackgroundColor := Colors.Black;
  View3D.ShowCoordinateSystem := False;
  View3D.ShowGridLines := False;
  View3D.ShowViewCube := False;
  View3D.ShowCameraInfo := False;
  // (7)Настройка фона и удаление вспомогательных изображений
  

  var a := Sphere(0,0,0, 2, Colors.Yellow); // Солнце
  var b := Sphere(6,0,0, 1, Colors.Green);  // Земля
  var c := Sphere(8,0,0, 0.5, Colors.Gray); // Луна
  a.Material := ImageMaterial('2k_sun.jpg'); 
  b.Material := ImageMaterial('2k_earth_daymap.jpg');
  c.Material := ImageMaterial('2k_moon.jpg');
  // (0) Наложение текстур


  var cb := c.AnimRotateAt(OrtZ,360, P3D(-2,0,0), 1);
//  cb.Begin; // (1) Оборот Луны вокруг Земли
//  cb.Forever.Begin;  // (2) Луна вращается вокруг Земли

  var bb := b.AnimRotate(OrtZ, 360, 2);
//  bb.Forever.Begin; // (3) Вращение Земли

  var ba := b.AnimRotateAt(OrtZ, 360, P3D(-6, 0, 0), 6);
//  ba.Begin; // (4) Оборот Земли вокруг Солнца

  var g := Group(b, c);
  var ga := g.AnimRotateAt(OrtZ, 360, P3D(0, 0, 0), 6);
//  ga.Begin; // (5) Оборот Земли и Луны вокруг Солнца

  (ga.Forever*bb.Forever*cb.Forever).Begin; 
  // (6) Одновременное вращение
  // Земли вокруг Солнца, 
  // а Луны вокруг Земли
end.
