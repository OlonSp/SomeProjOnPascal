uses WPFObjects;

const Rows = 10;
const Cols = 15;
const Side = 50;

///  Игровое поле
var field : array [,] of integer;
///  Массив картинок
var pics : array [,] of PictureWPF;
var GameInProgress : boolean;
///  Инициализация игры
procedure Init;
begin
  Window.SetSize(Cols*Side, Rows*Side);
  Window.CenterOnScreen;
  
  field := MatrGen(Rows, Cols, (i,j) -> -1);
  
  //  Размещаем бомбы
  loop Rows*Cols div 10 do
    field[Random(Rows), Random(Cols)] := -2;
  
  pics := new PictureWPF[Rows,Cols];
  for var i := 0 to Rows-1 do
    for var j := 0 to Cols-1 do
      pics[i,j] := new PictureWPF(j*Side,i*Side,'Pics/closed.png');
  gameInProgress := true;
end;

///  Рисование поля
///  0..8 - клетка открытая, и посчитаны бомбы вокруг
///  -1 пустая клетка (не открытая) 
///  -2 бомба закрытая (рисуется как не открытая клетка)
///  -3 флажок над пустой клеткой
///  -4 флажок над бомбой
///  -5 взорвавшаяся бомба
procedure DrawField;
begin
  for var i := 0 to Rows-1 do
    for var j := 0 to Cols-1 do
    begin
      pics[i,j].Destroy;
      case field[i,j] of
       -1,-2 : pics[i,j] := new PictureWPF(j*Side,i*Side,'Pics/closed.png');
        0 : pics[i,j] := new PictureWPF(j*Side,i*Side,'Pics/zero.png');
        1..8 : pics[i,j] := new PictureWPF(j*Side,i*Side,'Pics/num' + field[i,j] + '.png');
       -3,-4 : pics[i,j] := new PictureWPF(j*Side,i*Side,'Pics/flaged.png');
       -5 : pics[i,j] := new PictureWPF(j*Side,i*Side,'Pics/bombed.png');
      end;
    end;
end;

function CountBombsNear(r,c : integer) : integer;
begin
  Result := 0;
  for var i := r-1 to r+1 do
    for var j := c-1 to c+1 do
      if (i in 0..Rows-1)  and (j in 0..Cols-1) and (field[i,j] in |-2,-4,-5|) then
        Result += 1;
end;

procedure BlowAllBombs;
begin
  for var i := 0 to Rows-1 do
    for var j := 0 to Cols-1 do
      if field[i,j] in |-2,-4| then
        field[i,j] := -5;
end;

///  Проверка на победителя
function CheckWinner : boolean;
begin
  var minerWins := True;
  var minerFailed := False;
  
  for var i := 0 to Rows-1 do
    for var j := 0 to Cols-1 do
      if field[i,j] = -5 then
        minerFailed := True
      else
        if field[i,j] in |-1,-3| then minerWins := False;
  
  Result := minerWins or minerFailed;
  if minerWins then
    Window.Caption := 'Ура! Вы победили!'
  else
    if minerFailed then
      Window.Caption := 'Вы проиграли...';
  
end;

///  Щелчок мышки в клетке поля с координатами r и c, и номер кнопки мыши
procedure Click(r,c,mb : integer);
begin
  
  if mb = 2 then
  begin
    if field[r,c] in |-1,-2| then field[r,c] -= 2
    else if field[r,c] in |-3,-4| then field[r,c] += 2;
    exit;
  end;
  
  if field[r,c] = -1 then
    begin
      field[r,c] := CountBombsNear(r,c);
      if Field[r,c] = 0 then
      begin
        for var i := r-1 to r+1 do
          for var j := c-1 to c+1 do
            if (i in 0..Rows-1)  and (j in 0..Cols-1) then
              Click(i,j,mb);
      end;
    end
  else
    if field[r,c] = -2 then 
      BlowAllBombs;

  //  Если поле пустое -    -1 пустая клетка (не открытая) 
  //  field[r,c] := CountBombsNear(r,c)
  //  иначе если клетка не открытая с бомбой
  //    то BlowAllBombs;  (все -2,-4 -> -5)
end;

procedure MouseDown(x, y: real; mousebutton: integer); 
begin
  if not GameInProgress then 
    begin
    if mousebutton = 2 then
    begin
      for var i := 0 to Rows-1 do
        for var j := 0 to Cols-1 do
          pics[i,j].Destroy;
      Init;
    end;
    exit;
    end;
  Click(Floor(y/Side), Floor(x/Side), mousebutton);
  DrawField;
  gameinProgress := not CheckWinner;
end;
  

begin
  Init;
  OnMouseDown := MouseDown;
end.