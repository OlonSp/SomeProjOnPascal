//  Игра Животные

type TNode = class
  s : string;
  left, right : TNode;
  
  ///  Создание узла дерева
  constructor Create(name : string; left : TNode := nil; right : TNode := nil);
  begin
    s := name;
    self.Left := Left;
    self.Right := Right;
  end;
end;

procedure Play(node : TNode);
begin
  
  while (node.left <> nil) and (node.right <> nil) do
  begin
    Print('Вопрос :', node.s, '?');
    var answer := ReadString;
    if answer in |'Yes','yes','Y','y','Да','Д','да','1','д'| then
      node := node.left
    else
      node := node.right;
  end;
  
  var answer := ReadString('Это ' + node.s + '? Я угадал?');
  if answer in |'Yes','yes','Y','y','Да','Д','да','1','д'| then
     Println('Ого, какой я умный!')
  else
  begin
    var anim :=  ReadString('А кого вы загадали?');
    node.left := new TNode(anim);
    node.right := new TNode(node.s);
    
    Println('Чем отличается', node.left.s, 'от', node.right.s,'?');
    var quest :=  ReadString('Признак, который характерен для ' + node.left.s + ' и не характерен для ' + node.right.s+' :');
    node.s := quest;
    Println('Хорошо, я запомню!');
  end;
end;

procedure SaveTreeToFile(f : text; node : TNode);
begin
  if node = nil then
    f.Println('nil')
  else
  begin
    f.Println(node.s);
    SaveTreeToFile(f, node.left);
    SaveTreeToFile(f, node.right);
  end;
end;

procedure LoadTreeFromFile(f: text; var node : tNode);
begin
  var s := f.ReadlnString;
  if s = 'nil' then
    node := nil
  else
  begin
    node := new TNode(s);
    LoadTreeFromFile(f, node.left);
    LoadTreeFromFile(f, node.right);
  end;
end;

begin
  {var root := new TNode('Морское животное');
  
  var sea1 := new TNode('Млекопитающее');
  sea1.left := new TNode('Кит');
  sea1.right := new TNode('Селёдка');
  
  var bird := new TNode('Умеет летать');
  bird.left := new TNode('Чиж');
  bird.right := new TNode('Собака');
  
  root.left := sea1;
  root.right := bird;}
  
  var root : TNode;
  
  var f := OpenRead('database2.txt');
  
  LoadTreeFromFile(f, root);
  
  f.Close;
  
  
  while true do
  begin
    Println('------------------------------------------------------------');
    var cont := ReadString('Хочешь сыграть?');
    if cont in |'Yes','yes','Y','y','Да','Д','да','1','д'| then
      begin
        Play(root);
        f := OpenWrite('database2.txt');
  
        SaveTreeToFile(f, root);
  
        f.Close;
      end
    else
      exit;
  end;
  f := OpenWrite('database2.txt');
  
  SaveTreeToFile(f, root);
  
  f.Close;
end.