part of DQ;

class questMenu extends Layer {
  
  Game _game = null;
  GameState _gameState = null;
  MapLayer _mapLayer = null;
  
  TextWriter _TextWriter = null;
  
  int width = 8 * DEF.TILE_SIZE;
  int height = 3 * DEF.TILE_SIZE - (DEF.TILE_SIZE >> 2);
  int px = 6 * DEF.TILE_SIZE;
  int py = 1 * DEF.TILE_SIZE;
  int gap = 1;
  int pad = 5;
  
  num timeElapse = 0;
  num blinkDuration = 500;
  
  var _cursorPos = [0,0];
  int get cursorIndex => _cursorPos[1]*2+_cursorPos[0];
  bool _visible = false;
  get visible => _visible;
  
  set visible(bool v) {
    _visible = v;
  }
  
  bool _bgDirty = true;
  
  statusBar _statusBarMenu;
  
  static const int TALK_COMMAND = 1;
  static const int SEARCH_COMMAND = 2;
  // The rest are already handled by its specific menu
  
  QuestAction _choosenAction = null;
  
  questMenu(Game game, MapLayer menu) {
    _game = game;
    _gameState = game.gameState;
    _mapLayer = menu;
    _TextWriter = new TextWriter();
    _TextWriter.drawingRect = new Rect(px+pad+gap,py+pad+gap,width-pad-gap,height-pad-gap);
    
    _statusBarMenu = new statusBar(game,_gameState);
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    
    _game.guiCanvasCtx.fillStyle = DEF.menuBorderColor;
    _game.guiCanvasCtx.fillRect(px, py, width, height);
    
    _game.guiCanvasCtx.fillStyle = DEF.menuBGColor;
    _game.guiCanvasCtx.fillRect(px+pad, py+pad, width-pad-pad, height-pad-pad);
    
    var cursorStr = [" "," "," "," "," "," "];
    if (timeElapse < (blinkDuration / 2)) { 
      cursorStr[cursorIndex] = ">";
    }
    _TextWriter.WriteByRow(_game.guiCanvasCtx,"Command", 1);
    _TextWriter.WriteByRow(_game.guiCanvasCtx,"${cursorStr[0]}Talk  ${cursorStr[1]}Spell", 2);
    _TextWriter.WriteByRow(_game.guiCanvasCtx,"${cursorStr[2]}Status${cursorStr[3]}Item", 3);
    _TextWriter.WriteByRow(_game.guiCanvasCtx,"${cursorStr[4]}Equip ${cursorStr[5]}Search", 4);
    
    _statusBarMenu.draw(_game.guiCanvasCtx);
  }
  
  void activate({Map<String,dynamic> args: null}) { 
    if (args != null && args.containsKey("UserSelection")) {
      QuestAction action = args["UserSelection"];
      assert(action != null);
      _choosenAction = action;
    }
  }
  
  void deactivate({Map<String,dynamic> args: null}) {
  }

  void cleanup() {
  }
  
  void setDirty() {
    _bgDirty = true;  
  }
  
  void update(num delta) {
    timeElapse += delta;
    if (timeElapse > blinkDuration) {
      timeElapse -= blinkDuration;
    }
    
    if (_choosenAction != null) {
      _game.AddRequest(new PopRequest(_game,activateParams:{"UserSelection":_choosenAction}));
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
        _cursorPos[0] = MATH.max(0, _cursorPos[0] - 1);
        break;
      case DEF.KEYBOARD_UP:
        _cursorPos[1] = MATH.max(0, _cursorPos[1] - 1);
        break;
      case DEF.KEYBOARD_RIGHT:
        _cursorPos[0] = MATH.min(1, _cursorPos[0] + 1);
        break;
      case DEF.KEYBOARD_DOWN:
        _cursorPos[1] = MATH.min(2, _cursorPos[1] + 1);
        break;
      case DEF.KEYBOARD_PRIMARY:
        switch(cursorIndex) {
          case 0: // Talk
            _game.guiCanvasCtx.clearRect(0,0,_game.guiCanvas.width,_game.guiCanvas.height);
            _game.AddRequest(new PopRequest(_game,activateParams:{"UserTalkAction":"Talk"}));
            _game.AddRequest(new RedrawRequest(_game));
            break;
          case 1: // Spell
            List spells = _game.gameState.getFieldSpell();
            if (spells.isEmpty) {
              _game.AddRequest(new PushRequest(_game, new MsgBox(_game,"You have not learned any battle spell yet!",selfDismissOnFinish:true)));  
              _game.AddRequest(new RedrawRequest(_game));
            }
            else {
              // push another menu
              _game.AddRequest(new PushRequest(_game, new SpellMenu(_game, _mapLayer, spells)));
            }
            break;
          case 2: // Status
            _game.AddRequest(new PushRequest(_game, new attributeMenu(_game,_gameState)));
            break;
          case 3: // Item
            if (_gameState.Inventory.isEmpty) {
              _game.AddRequest(new PushRequest(_game, new MsgBox(_game,"You don't have any item!", selfDismissOnFinish:true)));  
              _game.AddRequest(new RedrawRequest(_game));
            }
            else {
              _game.AddRequest(new PushRequest(_game, new itemMenu(_game,_gameState)));
            }
            break;
          case 4: // Equip
            _game.AddRequest(new PushRequest(_game, new EquipMenu(_game,_gameState)));
            break;
          case 5: // Search
            _game.guiCanvasCtx.clearRect(0,0,_game.guiCanvas.width,_game.guiCanvas.height);
            _game.AddRequest(new PopRequest(_game,activateParams:{"UserSearchAction":"Search"}));
            _game.AddRequest(new RedrawRequest(_game));
            break;
        }
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