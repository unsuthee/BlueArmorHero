part of DQ;

class EquipMenu extends Layer {
  
  Game _game;
  GameState _gameState;
  TextWriter _TextWriter = null;
  
  int gap = 1;
  int pad = 5;
  int padgap = 6;
  
  num timeElapse = 0;
  num blinkDuration = 500;
  
  Rect ItemNameBox;
  Rect ItemListBox;
  Rect EquipmentBox;
    
  bool _isDirty = true;
  
  int pageNumber = 0;
  int maxPageNumber = 2;
  int minPageNumber = 0;
  
  int _cursorPos = 0;
  List<Item> _subItemList = [];
  
  EquipMenu(Game game, GameState gamestate) {
    _game = game;
    _gameState = gamestate;
    
    padgap = gap + pad;
    
    ItemNameBox = new Rect(2 * DEF.TILE_SIZE+padgap, 1 * DEF.TILE_SIZE+padgap, 8 * DEF.TILE_SIZE-padgap, 4 * DEF.TILE_SIZE-padgap);
    ItemListBox = calcItemListBox(3); 
    EquipmentBox = new Rect(2 * DEF.TILE_SIZE+padgap, 5 * DEF.TILE_SIZE+padgap+5, 8 * DEF.TILE_SIZE-padgap, 6 * DEF.TILE_SIZE-padgap);
    
    _TextWriter = new TextWriter();
  }
  
  Rect calcItemListBox(int numItems) {
    return new Rect(10 * DEF.TILE_SIZE+padgap + 5, 1 * DEF.TILE_SIZE+padgap, 8 * DEF.TILE_SIZE-padgap, (numItems + 2) * DEF.TILE_SIZE-padgap);
  }
  
  void drawBox(CanvasRenderingContext2D ctx, Rect rect) {
    ctx.fillStyle = DEF.menuBorderColor;
    ctx.fillRect(rect.left-padgap, rect.top-padgap, rect.width+padgap, rect.height+padgap);
    
    ctx.fillStyle = DEF.menuBGColor;
    ctx.fillRect(rect.left-gap, rect.top-gap, rect.width+gap-pad, rect.height+gap-pad);
  }
  
  String whitespace(int n) {
    String str = "";
    for(int i=0; i<n; i++) {
      str += " ";
    }
    return str;
  }
  
  void setDirty() {
    _isDirty = true;
  }
  
  Item getCurrentSelectedItem() {
    return _subItemList[_cursorPos];
  }
  
  void drawItemNameBox(CanvasRenderingContext2D ctx) {
    drawBox(ctx,ItemNameBox);
    
    _TextWriter.drawingRect = ItemNameBox;
    
    String itemName;
    String attrName;
    int attrVal;
    switch(pageNumber) {
      case 0:
        itemName = _gameState.heroWeapon;
        attrName = "Attack";
        attrVal = _gameState.heroATK - _gameState.Stats.currentWeapon.pow + getCurrentSelectedItem().power();
        break;
      case 1:
        itemName = _gameState.heroArmor;
        attrName = "Defence";
        attrVal = _gameState.heroDEF - _gameState.Stats.currentArmor.def + getCurrentSelectedItem().defence();
        break;
      case 2:
        itemName = _gameState.heroShield;
        attrName = "Defence";
        attrVal = _gameState.heroDEF - _gameState.Stats.currentShield.def + getCurrentSelectedItem().defence();
        break;
    }
    
    _TextWriter.WriteByRow(ctx,"${whitespace(1)}${itemName}", 1);
    _TextWriter.HorzLine(ctx, 3);
    _TextWriter.WriteByRow(ctx,"${whitespace(1)}${attrName}", 4);
    _TextWriter.WriteByRow(ctx,"${whitespace(3)}=${whitespace(2)}${attrVal}", 5);
  }
  
  void drawItemListBox(CanvasRenderingContext2D ctx, bool drawCursor) {
    
    Item currentHeroItem;
    List<Item> heroItems = _gameState.Inventory;
    String categoryName;
    switch(pageNumber) {
      case 0:
        currentHeroItem = _gameState.Stats.currentWeapon;
        categoryName = "Weapon";
        _subItemList = [];
        _subItemList = heroItems.where((Item n){ return (n.getType() == "Weapon"); }).toList();
        _subItemList.add(stats.WeaponData["Nothing"]);
        break;
      case 1:
        currentHeroItem = _gameState.Stats.currentArmor;
        categoryName = "Armor";
        _subItemList = [];
        _subItemList = heroItems.where((Item n){ return (n.getType() == "Armor"); }).toList();
        _subItemList.add(stats.ArmorData["Nothing"]);
        break;
      case 2:
        currentHeroItem = _gameState.Stats.currentShield;
        categoryName = "Shield";
        _subItemList = [];
        _subItemList = heroItems.where((Item n){ return (n.getType() == "Shield"); }).toList();
        _subItemList.add(stats.ShieldData["Nothing"]);
        break;
    }
    
    ctx.clearRect(ItemListBox.left-7,ItemListBox.top,ItemListBox.width+7,ItemListBox.height);
    ItemListBox = calcItemListBox(_subItemList.length);
    drawBox(ctx,ItemListBox);
    _TextWriter.drawingRect = ItemListBox;
    _TextWriter.WriteByRow(ctx,"${whitespace(1)}${categoryName}", 1);
    _TextWriter.HorzLine(ctx, 2);
    
    bool hasFoundEquipItem = false;
    int row = 1;
    for (Item item in _subItemList) {
      String cursorStr = (drawCursor && (row == _cursorPos*2+1)) ? ">" : whitespace(1);
      
      String equip = whitespace(1);
      if (!hasFoundEquipItem) {
        if (currentHeroItem.compare(item)) { 
          equip = "=";
          hasFoundEquipItem = true;
        }
      }
     
      _TextWriter.WriteByRow(ctx,"${equip}${cursorStr}${item.name}", row+2);
      row += 2;
    }
  }
  
  void drawEquipmentBox(CanvasRenderingContext2D ctx) {
    drawBox(ctx,EquipmentBox);
    
    _TextWriter.drawingRect = EquipmentBox;
    _TextWriter.WriteByRow(ctx,"=${_gameState.heroWeapon}", 1);
    _TextWriter.WriteByRow(ctx,"=${_gameState.heroArmor}", 3);
    _TextWriter.WriteByRow(ctx,"=${_gameState.heroShield}", 5);
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    
    bool drawCursor = false;
    if (timeElapse < (blinkDuration / 2)) { 
      drawCursor = true;
    }
    
    //if (_isDirty) {
      drawItemListBox(_game.guiCanvasCtx, drawCursor);
      drawItemNameBox(_game.guiCanvasCtx);
      drawEquipmentBox(_game.guiCanvasCtx);
      _isDirty = false;
    //}
  }
  
  void activate({Map<String,String> args: null}) { 
  }
  
  void deactivate({Map<String,String> args: null}) {
  }

  void cleanup() {
  }
  
  void update(num delta) {
    timeElapse += delta;
    if (timeElapse > blinkDuration) {
      timeElapse -= blinkDuration;
    }
  }
  
  void dismiss() {
    _game.guiCanvasCtx.clearRect(0,0,_game.guiCanvas.width,_game.guiCanvas.height);
    _game.AddRequest(new PopRequest(_game));
    _game.AddRequest(new RedrawRequest(_game));
  }
  
  void OnKeyboardDown(KeyboardEvent e) {
    switch (e.keyCode)
    {
      case DEF.KEYBOARD_LEFT:
        break;
      case DEF.KEYBOARD_UP:
        _cursorPos = MATH.max(_cursorPos - 1, 0);
        setDirty();
        break;
      case DEF.KEYBOARD_RIGHT:
        break;
      case DEF.KEYBOARD_DOWN:
        _cursorPos = MATH.min(_cursorPos + 1, _subItemList.length - 1);
        setDirty();
        break;
      case DEF.KEYBOARD_PRIMARY:
        Item currentItem = getCurrentSelectedItem();
        _gameState.Stats.Equip(currentItem);
        _cursorPos = 0;
        
        if (pageNumber == maxPageNumber) {
          dismiss();
        }
        else {
          pageNumber = pageNumber + 1;
        }
        setDirty();
        break;
      case DEF.KEYBOARD_SECONDARY:
        dismiss();
        break;
    }
  }
  
  void OnKeyboardUp(KeyboardEvent e) {
    switch (e.keyCode)
    {
      case DEF.KEYBOARD_LEFT:
        break;
      case DEF.KEYBOARD_UP:
        break;
      case DEF.KEYBOARD_RIGHT:
        break;
      case DEF.KEYBOARD_DOWN:
        break;
      case DEF.KEYBOARD_PRIMARY:
        break;
      case DEF.KEYBOARD_SECONDARY:
        break;
    }
  }
}