uses WPFObjects;

const rows = 10;
const cols = 15;
const side = 50;

var field : array[,] of integer;

var pics : array[,] of PictureWPF;

procedure Init;
Begin
  Window.SetSize(Cols*Side,Rows*Side);
  Window.CenterOnScreen;
  field := MatrGen(Rows,Cols, (i,j) -> Random(0,8));
  
  loop rows*cols div 10 do
    field[Random(rows), Random(Cols)] := -2;
  
  pics := new PictureWPF[Rows, Cols];
  for var i := 0 to Rows-1 do
    for var j := 0 to Cols-1 do
      pics[i,j] := new PictureWPF(j*Side, i*Side, 'Pics/closed.png');
  
end;

procedure DrawField;
begin
  for var i := 0 to Rows-1 do
    for var j := 0 to Cols-1 do
    begin
      pics[i,j].Destroy;
      case field[i,j] of
        -1, -2: pics[i,j] := new PictureWPF(j*Side, i*Side, 'Pics/closed.png');
        0: pics[i,j] := new PictureWPF(j*Side, i*Side, 'Pics/zero.png');
        1..8: pics[i,j] := new PictureWPF(j*Side, i*Side, 'Pics/num' + field[i,j] + '.png');
        -3,-4: pics[i,j] := new PictureWPF(j*Side, i*Side, 'Pics/flaged.png');
        -5: pics[i,j] := new PictureWPF(j*Side, i*Side, 'Pics/bombed.png');
        end;
    end;
end;

procedure MouseDown(x, y: real; mousebutton: integer); 
begin
  Click(Floor(y/Side),Floor(x/Side));
  DrawField;
end;

function CountBombsNear(r,c : integer)
begin
  
end;
Function BlowAllBombs();
begin
  
end;

procedure Click(r,c, mb : integer);
begin
  if mb = 1 then
    if 
end;

begin
  Init;
  DrawField;
  OnMouseDown := MouseDown;
end.