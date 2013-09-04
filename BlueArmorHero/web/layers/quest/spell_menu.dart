part of DQ;

class SpellMenu extends Layer {
  
  Game _game;
  GameState _gameState;
  TextWriter _TextWriter = null;
  MapLayer _maplayer;
  
  int gap = 1;
  int pad = 5;
  int padgap = 6;
  
  num timeElapse = 0;
  num blinkDuration = 500;
  
  Rect drawingBox;
  int _cursorPos = 1;
  
  bool _isDirty = true;
  List spellList;
  
  QuestAction _choosenAction = null;
  
  SpellMenu(Game game, MapLayer menu, List spell) {
    _game = game;
    _gameState = game.gameState;
    _maplayer = menu;
    spellList = spell;
    assert(!spellList.isEmpty);
    
    padgap = gap + pad;
    
    drawingBox = new Rect(6 * DEF.TILE_SIZE+padgap, 4 * DEF.TILE_SIZE+padgap, 8 * DEF.TILE_SIZE-padgap, 8 * DEF.TILE_SIZE-padgap);
    _TextWriter = new TextWriter();
    _TextWriter.drawingRect = drawingBox;
    
    _isDirty = true;
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
  
  void draw(CanvasRenderingContext2D ctx) {
    
    bool drawCursor = false;
    if (timeElapse < (blinkDuration / 2)) { 
      drawCursor = true;
    }
   
    _isDirty = true;
    if(_isDirty) {
      drawBox(ctx,drawingBox);
      
      int row = 1;
      for (String name in spellList) {
        String cursorStr = (drawCursor && (row == _cursorPos*2-1)) ? ">" : whitespace(1);
        _TextWriter.WriteByRow(ctx," ${cursorStr}${name}", row+1);
        row += 2;
      }
      _isDirty = false;
    }
    
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
    
    if (_choosenAction != null) {
      _game.AddRequest(new PopRequest(_game,activateParams:{"UserSelection":_choosenAction}));
    }
  }
  
  void OnKeyboardDown(KeyboardEvent e) {
    switch (e.keyCode)
    {
      case DEF.KEYBOARD_LEFT:
        break;
      case DEF.KEYBOARD_UP:
        _cursorPos = MATH.max(1, _cursorPos-1);
        break;
      case DEF.KEYBOARD_RIGHT:
        break;
      case DEF.KEYBOARD_DOWN:
        _cursorPos = MATH.min(6, _cursorPos+1);
        break;
      case DEF.KEYBOARD_PRIMARY:
        String spellName = spellList[_cursorPos-1];
        switch (spellName) {
          case "Heal":
            _choosenAction = new FieldHealSpellAction(healMore:false);
            break;
          case "Radiant":
            _choosenAction = new RadiantSpellAction();
            break;
          case "Outside":
            _choosenAction = new OutsideSpellAction();
            break;
          case "Return":
            _choosenAction = new ReturnSpellAction();
            break;
          case "Repel":
            _choosenAction = new RepelSpellAction();
            break;
          case "HealMore":
            _choosenAction = new FieldHealSpellAction(healMore:true);
            break;
        }
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