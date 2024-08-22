uses GraphWPF;

type
  TreeNode = auto class
    data: integer;
    left, right: TreeNode;
  end;

// Вставка элемента в бинарное дерево поиска
procedure InsertNode(var node: TreeNode; x: integer);
begin
  if node = nil then
    node := new TreeNode(x, nil, nil)
  else
    if x < node.data then
      InsertNode(node.left, x)
    else
      InsertNode(node.right, x);
  
  {//while node.data <> x do
  while true do
  begin
    if x < node.data then
      if node.left = nil then
      begin
        node.left := new TreeNode(x, nil, nil);
        exit;
      end
      else
      node := node.left
    else
    if x >= node.data then
      if node.right = nil then
      begin
        node.right := new TreeNode(x, nil, nil);
        exit;
      end
      else
      node := node.right;    
  end;}
end;

//вывод дерева
procedure PrintTree(node: TreeNode);
begin
  if node = nil then exit;
  PrintTree(node.left);
  Print(node.data);
  PrintTree(node.right);
end;

// Графический вывод дерева
procedure DrawTree(node: TreeNode; x,y,dx,dy : real);
begin
  if node = nil then exit;
  
  if node.left <> nil then
    begin
      Line(x, y, x-dx, y+dy);
      DrawTree(node.left, x-dx, y+dy, dx/2, dy);
    end;
 
  if node.right <> nil then
    begin
      Line(x, y, x+dx, y+dy);
      DrawTree(node.right, x+dx, y+dy, dx/2, dy);
    end;
  if odd(node.data) then   
    FillCircle(x, y, 30, Colors.Red)
  else
    FillCircle(x, y, 30, Colors.Green);
  DrawText(x-30, y-30, 60, 60, node.data.ToString, Alignment.Center);
end;


// проверяет есть ли элемент в дереве
function ElemInTree(x : integer; node : TreeNode) : boolean;
begin
  if x = node.data then
  begin
    Print('Yes');
    exit;
  end
  else Print('No');
  
  if x < node.data then
    if node.left <> nil then
      ElemInTree(x, node.left)
    else if node.right <> nil then
      ElemIntree(x, node.right); 
end;

begin
  var root : TreeNode := nil;
  //InsertNode(root, 12);
  {InsertNode(root, 23);
  InsertNode(root, 5);
  InsertNode(root, 30);
  InsertNode(root, 7);
  InsertNode(root, 20);  
  InsertNode(root, 17);
  InsertNode(root, 10);
  InsertNode(root, 25);}
  
  Window.SetSize(1400,800);
  Window.CenterOnScreen;
  Font.Size := 28;
  Pen.Width := 4;
  Pen.Color := Colors.Gray;
  
  var n := 10;
  loop n do
    begin
    Insertnode(root,Random(1,50));
    Window.Clear;
    DrawTree(root, Window.Width/2, 50, Window.Width/4, 100);
    Sleep(500);
    end;
  
  ElemInTree(Random(1,50), root);
  ElemInTree(Random(1,50), root);
  
  PrintTree(root);
  {Window.SetSize(1400,800);
  Window.CenterOnScreen;
  Font.Size := 28;
  Pen.Width := 4;
  Pen.Color := Colors.Gray;
  DrawTree(root, Window.Width/2, 50, Window.Width/4, 100);}
end.
