part of DQ;

class itemMenu extends Layer {
  
  Game _game;
  GameState _gameState;
  TextWriter _TextWriter = null;
  
  int width = 8 * DEF.TILE_SIZE;
  int height = 10 * DEF.TILE_SIZE - (DEF.TILE_SIZE >> 2);
  int px = 6 * DEF.TILE_SIZE;
  int py = 4 * DEF.TILE_SIZE;
  int gap = 1;
  int pad = 5;
  
  num timeElapse = 0;
  num blinkDuration = 500;
  
  int _cursorPos = 0;
  
  static const int USE_ACTION = 1;
  static const int DROP_ACTION = 2;
  static const int DONE_ACTION = 3;
  int _currentAction = DONE_ACTION;
  
  itemMenu(Game game, GameState gamestate) {
    _game = game;
    _gameState = gamestate;
    
    _TextWriter = new TextWriter();
    _TextWriter.drawingRect = new Rect(px+pad+gap,py+pad+gap,width-pad-gap,height-pad-gap);
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    ctx.fillStyle = DEF.menuBorderColor;
    ctx.fillRect(px, py, width, height);
    
    ctx.fillStyle = DEF.menuBGColor;
    ctx.fillRect(px+pad, py+pad, width-pad-pad, height-pad-pad);
    
    bool drawCursor = false;
    if (timeElapse < (blinkDuration / 2)) { 
      drawCursor = true;
    }

    int row = 0;
    for (Item item in _gameState.Inventory) {
      String cursorStr = (drawCursor && (row == _cursorPos*2)) ? ">" : " ";
      _TextWriter.WriteByRow(ctx,"${cursorStr}${item.name}", row+1);
      row+=2;
    }
  }
  
  void activate({Map<String,dynamic> args: null}) { 
    if (args != null && args.containsKey("UserSelection")) {
      _currentAction = args["UserSelection"][1];
    }
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
    
    if (_gameState.Inventory.isEmpty) {
      _game.AddRequest(new PopRequest(_game));
      _game.AddRequest(new RedrawRequest(_game));
      return;
    }
    
    switch(_currentAction) {
      case USE_ACTION:
        Item item = _gameState.Inventory[_cursorPos];
        print("using ${item.name}");
        break;
      case DROP_ACTION:
        Item item = _gameState.Inventory[_cursorPos];
        print("droping ${item.name}");
        _gameState.RemoveItem(item);
        _cursorPos = 0;
        break;
    }
    _currentAction = DONE_ACTION;
  }
  
  void OnKeyboardDown(KeyboardEvent e) {
    switch (e.keyCode)
    {
      case DEF.KEYBOARD_LEFT:
        break;
      case DEF.KEYBOARD_UP:
        _cursorPos = MATH.max(0, _cursorPos - 1);
        break;
      case DEF.KEYBOARD_RIGHT:
        break;
      case DEF.KEYBOARD_DOWN:
        _cursorPos = MATH.min(_gameState.Inventory.length -1, _cursorPos + 1);
        break;
      case DEF.KEYBOARD_PRIMARY:
        _game.AddRequest(new PushRequest(_game, new DecisionBox.fromList(_game, new Rect(px+width+10,py,100,80), [["Use" ,USE_ACTION],
                                                                                              ["Drop"  ,DROP_ACTION],
                                                                                              ["Done"  ,DONE_ACTION]])));
        break;
      case DEF.KEYBOARD_SECONDARY:
        _game.AddRequest(new PopRequest(_game));
        _game.AddRequest(new RedrawRequest(_game));
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