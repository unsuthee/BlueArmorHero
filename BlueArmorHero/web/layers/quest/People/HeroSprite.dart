part of DQ;

class HeroSprite {
  
  static const int STATE_IDLE = 0;
  static const int STATE_MOVING = 1;
  
  static double velocity = DEF.HERO_SPEED;
 
  // query the hero's actual position on the map
  double _mapPx;
  double _mapPy;
  double get mapPx => _mapPx;
  double get mapPy => _mapPy;
  int get TilePosX => _mapPx ~/ DEF.TILE_SIZE;
  int get TilePosY => _mapPy ~/ DEF.TILE_SIZE;
  int get TileSubPosX => _mapPx ~/ DEF.HALF_TILE_SIZE;
  int get TileSubPosY => _mapPy ~/ DEF.HALF_TILE_SIZE;
  
  String get PositionStr => "${mapPx}:${mapPy}";
  
  String get name => _game.gameState.heroName;
  
  Game _game = null;
  MapData _mapData = null;
  MapLayer _layer = null;
  
  CharacterSprite _currSprite = null;
  int _currState;
  int _currDir;
  int get direction => _currDir;
  
  HeroSprite(Game game, MapData mapData, MapLayer layer, {int initPx:-1, int initPy:-1} ) {
    _game = game;
    _mapData = mapData;
    _layer = layer;
    
    _currSprite = new CharacterSprite("Hero");
    _currSprite.setAnimation(DEF.DIR_UP);
    
    _currState = STATE_IDLE;
    _currDir = DEF.DIR_UP;
    
    // Position
    _mapPx = mapData.getInitPosX().toDouble();
    _mapPy = mapData.getInitPosY().toDouble();
  }
  
  Rect getFacingBox() {
    double x;
    double y;
    switch(_currDir) {
      case DEF.DIR_UP:
        x = _mapPx + DEF.QUARTER_TILE_SIZE;
        y = _mapPy - DEF.QUARTER_TILE_SIZE;
        break;
      case DEF.DIR_DOWN:
        x = _mapPx + DEF.QUARTER_TILE_SIZE;
        y = _mapPy + DEF.TILE_SIZE;
        break;
      case DEF.DIR_LEFT:
        x = _mapPx - DEF.QUARTER_TILE_SIZE;
        y = _mapPy + DEF.QUARTER_TILE_SIZE;
        break;
      case DEF.DIR_RIGHT:
        x = _mapPx + DEF.TILE_SIZE;
        y = _mapPy + DEF.QUARTER_TILE_SIZE;
        break; 
    }
    return new Rect(x,y,DEF.HALF_TILE_SIZE,DEF.HALF_TILE_SIZE);
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    _currSprite.draw(ctx,px:DEF.SCREEN_HALF_WIDTH_PCX,py:DEF.SCREEN_HALF_HEIGHT_PCX);
  }
 
  void ResetToIdle() {
    _currState = STATE_IDLE;
  }
  
  void HandleKeyUp(int dir) {
    if (_currState == STATE_MOVING) {
      _currState = STATE_IDLE;
    }
  }
  
  void HandleKeyDown(int dir) {
    if (_currState == STATE_IDLE) {
      _currState = STATE_MOVING;
    }
    _currDir = dir;
    _currSprite.setAnimation(dir);
  }
  
  int getCurrentTileId({num px:-1, num py:-1}) {
    if (px < 0)
      px = _mapPx;
    if (py < 0)
      py = _mapPy;
    int startTileX = (px - 320) ~/ DEF.TILE_SIZE;
    int startTileY = (py - 400) ~/ DEF.TILE_SIZE;
    return _mapData.getTileIdByPos(startTileX,startTileY);
  }
  
  void update(num delta) {
    //print("delta:${delta}");
    
    _currSprite.update(delta.toInt());
    
    if (_currState == STATE_MOVING) {
      double dist = delta * velocity;
      double rollbackPx = _mapPx;
      double rollbackPy = _mapPy;
      
      switch (_currDir) {
        case DEF.DIR_UP:
          _mapPy-=dist;
          break;
        case DEF.DIR_DOWN:
          _mapPy+=dist;
          break;
        case DEF.DIR_LEFT:
          _mapPx-=dist;
          break;
        case DEF.DIR_RIGHT:
          _mapPx+=dist;
          break;
      }
      
      if (!_mapData.isPassable(getCurrentTileId(px:_mapPx,py:_mapPy))) {
        _mapPx = rollbackPx;
        _mapPy = rollbackPy;
      }
      //print("${mapPx}:${mapPy}:${TilePosX}:${TilePosY}");   
    }
  }
}