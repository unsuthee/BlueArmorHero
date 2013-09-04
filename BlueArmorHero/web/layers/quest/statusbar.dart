part of DQ;

class statusBar {
  
  Game _game = null;
  GameState _gameState = null;
  TextWriter _TextWriter = null;
  
  int width = 4 * DEF.TILE_SIZE - (DEF.TILE_SIZE >> 2);
  int height = 4 * DEF.TILE_SIZE - (DEF.TILE_SIZE >> 1);
  int px = 15 * DEF.TILE_SIZE;
  int py = 11 * DEF.TILE_SIZE;
  int gap = 1;
  int pad = 5;
  
  bool _visible = false;
  get visible => _visible;
  set visible(bool v) {
    _visible = v;
  }
  
  statusBar(Game game, GameState gameState) {
    _game = game;
    _gameState = gameState;
    _TextWriter = new TextWriter();
    _TextWriter.drawingRect = new Rect(px+pad+gap,py+pad+gap,width-pad-gap,height-pad-gap);
  }

  void draw(CanvasRenderingContext2D ctx) {
    ctx.fillStyle = DEF.menuBorderColor;
    ctx.fillRect(px, py, width, height);
    
    ctx.fillStyle = DEF.menuBGColor;
    ctx.fillRect(px+pad, py+pad, width-pad-pad, height-pad-pad);
    
    _TextWriter.WriteByRow(ctx,formatName(_gameState.heroName), 1);
    _TextWriter.WriteByRow(ctx,"HP:${formatNumber(_gameState.heroHP)}", 2);
    _TextWriter.WriteByRow(ctx,"MP:${formatNumber(_gameState.heroMP)}", 3);
    _TextWriter.WriteByRow(ctx,"Lv:${formatNumber(_gameState.heroLevel)}", 4);
    _TextWriter.WriteByRow(ctx,"G${formatGoldValue(_gameState.heroGold)}", 5);
  }
  
  // upto 6 letters
  String formatName(String name) {
    if (name.length <= 6) {
      return name;
    }
    return name.substring(0, 6);
  }

  String formatGoldValue(int val) {
    String vstr = val.toString();
    int len = 5 - vstr.length;
    String tmp = "";
    for(var i=0; i<len; i++) {
      tmp = tmp + " ";
    }
    return tmp + val.toString();
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
  
  void update(num delta) {
  }
}