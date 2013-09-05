part of DQ;

class itemMenu extends Layer {
  
  Game _game;
  GameState _gameState;
  DecisionBox _decisionBox = null;
  
  int px = 6 * DEF.TILE_SIZE;
  int py = 4 * DEF.TILE_SIZE;
  int gap = 1;
  int pad = 5;
  
  static const int USE_ACTION = 1;
  static const int DROP_ACTION = 2;
  static const int DONE_ACTION = 3;
  int _currentAction = DONE_ACTION;
  
  itemMenu(Game game, GameState gamestate) {
    _game = game;
    _gameState = gamestate;
    
    _decisionBox = initDecisionBox();
  }
  
  DecisionBox initDecisionBox() {
    List<Item> items = _game.gameState.Inventory;
    int maxLen = 0;
    List itemList = [];
    for(Item itm in items) {
      maxLen = MATH.max(itm.name.length, maxLen);
      itemList.add([itm.name,itm]);
    }

    Rect decisionBox = new Rect( px,py,(maxLen-5) * DEF.TILE_SIZE, MATH.max((items.length-2),5) * DEF.TILE_SIZE);
    return new DecisionBox.fromList(_game, decisionBox, itemList);
  }
  
  void setDirty() {
    _decisionBox.setDirty();
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    _decisionBox.draw(ctx);
  }
  
  void activate({Map<String,dynamic> args: null}) { 
    if (args != null && args.containsKey("UserSelection")) {
      _currentAction = DONE_ACTION;
      if (args["UserSelection"] != null) {
        _currentAction = args["UserSelection"][1];
      }
    }
  }
  
  void deactivate({Map<String,String> args: null}) {
  }

  void cleanup() {
  }
  
  void update(num delta) {
    
    if (_gameState.Inventory.isEmpty) {
      _game.guiCanvasCtx.clearRect(0,0,_game.guiCanvas.width,_game.guiCanvas.height);
      _game.AddRequest(new PopRequest(_game));
      _game.AddRequest(new RedrawRequest(_game));
      return;
    }
    
    _decisionBox.update(delta);
    
    switch(_currentAction) {
      case USE_ACTION:
        List item = _decisionBox.getCurrentSelectedItem();
        print("using ${item[0]}");
        _gameState.RemoveItem(item[1]);
        _decisionBox.cleanup();
        _decisionBox = initDecisionBox();
        setDirty();
        break;
      case DROP_ACTION:
        List item = _decisionBox.getCurrentSelectedItem();
        print("droping ${item[0]}");
        _gameState.RemoveItem(item[1]);
        _decisionBox.cleanup();
        _decisionBox = initDecisionBox();
        setDirty();
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
        _decisionBox.MoveCursorUp();
        setDirty();
        break;
      case DEF.KEYBOARD_RIGHT:
        break;
      case DEF.KEYBOARD_DOWN:
        _decisionBox.MoveCursorDown();
        setDirty();
        break;
      case DEF.KEYBOARD_PRIMARY:
        _game.AddRequest(new PushRequest(_game, new DecisionBox.fromList(_game, new Rect(px+_decisionBox.DrawingBox.width+10,py,100,80), 
                                                                                             [["Use" ,USE_ACTION],
                                                                                              ["Drop"  ,DROP_ACTION],
                                                                                              ["Done"  ,DONE_ACTION]],
                                                                                              allowCancel:true)));
        break;
      case DEF.KEYBOARD_SECONDARY:
        _game.guiCanvasCtx.clearRect(0,0,_game.guiCanvas.width,_game.guiCanvas.height);
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