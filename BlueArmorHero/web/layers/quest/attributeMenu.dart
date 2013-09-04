part of DQ;

class attributeMenu extends Layer {
  
  Game _game;
  GameState _gameState = null;
  TextWriter _TextWriter = null;
  
  bool _isDirty = true;
  
  int width = 16 * DEF.TILE_SIZE;
  int height = 8 * DEF.TILE_SIZE;
  int px = 1 * DEF.TILE_SIZE;
  int py = 2 * DEF.TILE_SIZE;
  int gap = 1;
  int pad = 5;
  
  attributeMenu(Game game, GameState gamestate) {
    _game = game;
    _gameState = gamestate;
    _TextWriter = new TextWriter();
    _TextWriter.drawingRect = new Rect(px+pad+gap,py+pad+gap,width-pad-gap,height-pad-gap);
    _TextWriter.line_space_pcx = 5;
  }
  
  void setDirty() {
    _isDirty = true;
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    
    if (_isDirty) {
      _game.guiCanvasCtx.fillStyle = DEF.menuBorderColor;
      _game.guiCanvasCtx.fillRect(px, py, width, height);
      
      _game.guiCanvasCtx.fillStyle = DEF.menuBGColor;
      _game.guiCanvasCtx.fillRect(px+pad, py+pad, width-pad-pad, height-pad-pad);
      
      _TextWriter.WriteByRow(_game.guiCanvasCtx,formatName(_gameState.heroName), 1);
      
      var tmpStr;
      int numWhiteSpace = MATH.max(0, 5 - _gameState.heroSTR.toString().length);
      tmpStr = "Level :${formatNumber(_gameState.heroLevel)}" 
      +  "${whitespace(3)}Strength :${whitespace(numWhiteSpace)}${_gameState.heroSTR}";
      _TextWriter.WriteByRow(_game.guiCanvasCtx,tmpStr, 3);
      
      numWhiteSpace = MATH.max(0, 5 - _gameState.heroAGI.toString().length);
      tmpStr = "HP    :${formatNumber(_gameState.heroHP)}" 
      +  "${whitespace(3)}Agility  :${whitespace(numWhiteSpace)}${_gameState.heroAGI}";
      _TextWriter.WriteByRow(_game.guiCanvasCtx,tmpStr, 4);
      
      numWhiteSpace = MATH.max(0, 5 - _gameState.heroATK.toString().length);
      tmpStr = "MP    :${formatNumber(_gameState.heroMP)}" 
      +  "${whitespace(3)}Attack   :${whitespace(numWhiteSpace)}${_gameState.heroATK}";
      _TextWriter.WriteByRow(_game.guiCanvasCtx,tmpStr, 5);
      
      numWhiteSpace = MATH.max(0, 5 - _gameState.heroDEF.toString().length);
      tmpStr = "Max HP:${formatNumber(_gameState.heroMaxHP)}"
      +  "${whitespace(3)}Defense  :${whitespace(numWhiteSpace)}${_gameState.heroDEF}";
      _TextWriter.WriteByRow(_game.guiCanvasCtx,tmpStr, 6);
      
      numWhiteSpace = MATH.max(0, 5 - _gameState.heroEXP.toString().length);
      tmpStr = "Max MP:${formatNumber(_gameState.heroMaxMP)}"
      +  "${whitespace(3)}EXP      :${whitespace(numWhiteSpace)}${_gameState.heroEXP}";
      _TextWriter.WriteByRow(_game.guiCanvasCtx,tmpStr, 7);
      
      numWhiteSpace = MATH.max(0, 5 - _gameState.heroNextLV.toString().length);
      _TextWriter.WriteByRow(_game.guiCanvasCtx,"${whitespace(13)}Next LV  :${whitespace(numWhiteSpace)}${_gameState.heroNextLV}", 8);
      
      _TextWriter.WriteByRow(_game.guiCanvasCtx,"=${_gameState.heroWeapon}", 9);
      _TextWriter.WriteByRow(_game.guiCanvasCtx,"=${_gameState.heroArmor}", 10);
      _TextWriter.WriteByRow(_game.guiCanvasCtx,"=${_gameState.heroShield}", 11);
      
      _isDirty = false;
    }
  }
  
  String whitespace(int n) {
    String str = "";
    for(int i=0; i<n; i++) {
      str += " ";
    }
    return str;
  }
  
  // upto 6 letters
  String formatName(String name) {
    if (name.length <= 6) {
      return name;
    }
    return name.substring(0, 6);
  }
  
  String formatNumber(int val) {
    if (val < 10) {// single digit
      return "  ${val}";
    }
    else if (val < 100) {
      return " ${val}";
    }
    else {
      return "${val}";
    }
  }
  
  void OnKeyboardDown(KeyboardEvent e) {
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
        _game.guiCanvasCtx.clearRect(0,0,_game.guiCanvas.width,_game.guiCanvas.height);
        _game.AddRequest(new PopRequest(_game));
        _game.AddRequest(new RedrawRequest(_game));
        break;
    }
  }
}