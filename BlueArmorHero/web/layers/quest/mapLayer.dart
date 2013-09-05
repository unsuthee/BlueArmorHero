part of DQ;

class MapLayer extends Layer {
 
  Game _game = null;
  GameState _gameState = null;
  CanvasElement _bgCanvas = null;
  CanvasElement _mainCanvas = null;
  CanvasRenderingContext2D _bgContext = null;
  int _bgCanvasWidth;
  int _bgCanvasHeight;
  int _tileWidth;
  int _tileHeight;
  int _dispCanvasWidth;
  int _dispCanvasHeight;
  Rect _dispRect;
  MapData _mapData = null;
  
  HeroSprite _heroSprite = null;
  HeroSprite get HeroInfo => _heroSprite;
  
  List<Thing> _npcs = null;
  List<Thing> get NPCs => _npcs;
  
  // tracking the last drawing region
  int _lastTilePosX = -1;
  int _lastTilePosY = -1;
  int _lastTileSubPosX = -1;
  int _lastTileSubPosY = -1;
  
  Map<String,Trigger> _triggerMap = null;
  List<BattleTask> _tasks = [];
  
  bool _pendingHandleTalk = false;
  bool _pendingSearch = false;
  
  var _rng = new MATH.Random();
  
  MapLayer( Game game, MapData mapData) {

    _game = game;
    _gameState = game.gameState;
    _mainCanvas = game.canvas;
    _bgCanvas = game.bgCanvas;
    _bgContext = _bgCanvas.context2D;
    _bgCanvasWidth = _bgCanvas.width;
    _bgCanvasHeight = _bgCanvas.height;
    _tileWidth = _bgCanvasWidth ~/ DEF.TILE_SIZE;
    _tileHeight = _bgCanvasHeight ~/ DEF.TILE_SIZE;
    
    _dispCanvasWidth = _mainCanvas.width;
    _dispCanvasHeight = _mainCanvas.height;
    _dispRect = new Rect(0,0,_dispCanvasWidth,_dispCanvasHeight);
    _mapData = mapData;
    
    _heroSprite = new HeroSprite(game, mapData, this);
    _lastTilePosX = _heroSprite.TilePosX;
    _lastTilePosY = _heroSprite.TilePosY;
    _lastTileSubPosX = _heroSprite.TileSubPosX;
    _lastTileSubPosY = _heroSprite.TileSubPosY;
    
    _triggerMap = mapData.getTriggeMap();
    
    // setup NPCs
    _npcs = mapData.getNPC(_game);
  }
  
  void activate({Map<String,dynamic> args: null}) {
    drawBackground(_bgContext);
    
    if (args != null && args.containsKey("UserSelection")) {
      QuestAction action = args["UserSelection"];
      assert(action != null);
      _tasks.addAll(action.execute(_game, this));
    }
    else if (args != null && args.containsKey("UserTalkAction")) {
      _pendingHandleTalk = true;
    }
    else if (args != null && args.containsKey("UserSearchAction")) {
      _pendingSearch = true;
    }
  }
  
  void deactivate({Map<String,dynamic> args: null}) {
  }
  
  void blitBackground(CanvasRenderingContext2D ctx) {
    ctx.clearRect(0, 0, _dispCanvasWidth, _dispCanvasHeight);
    int drawOffsetX = _heroSprite.mapPx.toInt() % DEF.TILE_SIZE;
    int drawOffsetY = _heroSprite.mapPy.toInt() % DEF.TILE_SIZE;
   
    Rect srcRect = new Rect(drawOffsetX,drawOffsetY,_dispCanvasWidth,_dispCanvasHeight);
    ctx.drawImageToRect(_bgCanvas, _dispRect, sourceRect:srcRect);
  }
  
  void drawHero(CanvasRenderingContext2D ctx) {
    _heroSprite.draw(ctx);
  }
  
  void drawNPCS(CanvasRenderingContext2D ctx) {
    for(Thing thing in _npcs) {
      int offsetX = (thing.mapPx - _heroSprite.mapPx).toInt();
      int offsetY = (thing.mapPy - _heroSprite.mapPy).toInt();
      
      if (offsetX.abs() < DEF.SCREEN_HALF_WIDTH_PCX && offsetY.abs() < DEF.SCREEN_HALF_HEIGHT_PCX) {
        thing.draw(ctx,px:DEF.SCREEN_HALF_WIDTH_PCX+offsetX,py:DEF.SCREEN_HALF_HEIGHT_PCX+offsetY);
      }
    }
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    
    if (_tasks.isNotEmpty) {
      if (!_tasks[0].isComplete()) {
        _tasks[0].draw(ctx);
      }
      return;
    }
    
    blitBackground(ctx);
    _game.spriteCanvasCtx.clearRect(0, 0, _game.spriteCanvas.width, _game.spriteCanvas.height);
    drawHero(_game.spriteCanvasCtx);
    drawNPCS(_game.spriteCanvasCtx);
  }
  
  void OnEnterNewSubTile(int px, int py) {
    
    print("${_heroSprite.mapPx.toInt()}:${_heroSprite.mapPy.toInt()}:${_heroSprite.TileSubPosX}:${_heroSprite.TileSubPosY}");
    //print("Tile:${stats.Terrans[_heroSprite.getCurrentTileId()]}");
    
    if (_triggerMap == null)
      return;
    
    String posKey = "${px}:${py}";
    if (_triggerMap.containsKey(posKey)) {
      Trigger trg = _triggerMap[posKey];
      trg.execute(_game);
    }
    else {
      // check for encounter
      if (!DEF.NO_ENCOUNTER) {
        int zoneId = MonsterStats.getZoneByPos((_heroSprite.mapPx - 461) ~/ 512, (_heroSprite.mapPy - 537) ~/ 512);
        List monsList = MonsterStats.getMonsterByZone(zoneId);
        
        if (_rng.nextInt(48) == 0) {
          HeroSprite hero = HeroInfo;
          hero.ResetToIdle();
          LaunchBattle(monsList[_rng.nextInt(5)], stats.getOverworldTerranByTileId(_heroSprite.getCurrentTileId()));  
        }
      }
    }
  }
  
  void OnExitSubTile(int px, int py) {
  }
  
  void update(num delta) {

    if (_tasks.isNotEmpty) {
      if (!_tasks[0].isComplete()) {
        _tasks[0].update(delta);
      }
      else {
        _tasks[0].end();
        _tasks.removeAt(0);
        if (_tasks.isNotEmpty) {
          _tasks[0].start();
        }
      }
      return;
    }
    
    if (_pendingHandleTalk) {
      HeroSprite hero = HeroInfo;
      hero.ResetToIdle();
      
      // check if anyone is close enough to talk
      bool didTalk = false;
      Rect facingBox = hero.getFacingBox();
      for(Thing thing in NPCs) {
        if (facingBox.intersects(thing.getRect())) {
          thing.OnTalkBegin(_game,hero);    
          didTalk = true;
          break;
        }
      }
      if (!didTalk) {
        _tasks.add(new AnnotateTask(_game,["There is no one in front of you."]));
      }
      _pendingHandleTalk = false;
    }
    else if (_pendingSearch) {
      _pendingSearch = false;
    }
    
    _heroSprite.update(delta);
    for(Thing thing in _npcs) {
      thing.update(delta);
    }
    
    if (_heroSprite.TilePosX != _lastTilePosX || _heroSprite.TilePosY != _lastTilePosY) {
      drawBackground(_bgContext);
      _lastTilePosX = _heroSprite.TilePosX;
      _lastTilePosY = _heroSprite.TilePosY;
    }
  
    if (_heroSprite.TileSubPosX != _lastTileSubPosX || _heroSprite.TileSubPosY != _lastTileSubPosY) {
      OnExitSubTile(_lastTileSubPosX,_lastTileSubPosY);
      _lastTileSubPosX = _heroSprite.TileSubPosX;
      _lastTileSubPosY = _heroSprite.TileSubPosY;
      OnEnterNewSubTile(_lastTileSubPosX,_lastTileSubPosY);
    }
  }
  
  void LaunchBattle(String monster, String terran) {
    _game.AddRequest(new PushRequest(_game, new battleMenu(_game,background:terran, monster:monster)));
  }
  
  void OnKeyboardDown(KeyboardEvent e) {
    switch (e.keyCode)
    {
      case DEF.KEYBOARD_LEFT: // left
        _heroSprite.HandleKeyDown(DEF.DIR_LEFT);
        break;
      case DEF.KEYBOARD_UP: // up
        _heroSprite.HandleKeyDown(DEF.DIR_UP);
        break;
      case DEF.KEYBOARD_RIGHT: // right
        _heroSprite.HandleKeyDown(DEF.DIR_RIGHT);
        break;
      case DEF.KEYBOARD_DOWN: // down
        _heroSprite.HandleKeyDown(DEF.DIR_DOWN);
        break;
      case DEF.KEYBOARD_PRIMARY:
        _game.AddRequest(new PushRequest(_game, new questMenu(_game,this)));
        break;
      case DEF.KEYBOARD_SECONDARY:
        //LaunchBattle("M_Magician","Forest");
        break;
      case DEF.KEYBOARD_ATL_1: // Talk
        _pendingHandleTalk = true;
        break;
        
      case DEF.KEYBOARD_ATL_2: // Search
        _pendingSearch = true;
        break;
    }
  }
  
  void OnKeyboardUp(KeyboardEvent e) {
    
    switch (e.keyCode)
    {
      case DEF.KEYBOARD_LEFT:
        _heroSprite.HandleKeyUp(DEF.DIR_LEFT);
        break;
      case DEF.KEYBOARD_UP: // up
        _heroSprite.HandleKeyUp(DEF.DIR_UP);
        break;
      case DEF.KEYBOARD_RIGHT: // right
        _heroSprite.HandleKeyUp(DEF.DIR_RIGHT);
        break;
      case DEF.KEYBOARD_DOWN: // down
        _heroSprite.HandleKeyUp(DEF.DIR_DOWN);
        break;
      case DEF.KEYBOARD_PRIMARY:
        break;
      case DEF.KEYBOARD_SECONDARY:
        break;
    }
  }
  
  void drawBackground(CanvasRenderingContext2D ctx) {
    
    ctx.clearRect(0, 0, _bgCanvasWidth, _bgCanvasHeight);
 
    ImageCache imgCache = new ImageCache();
    ImageElement imgSrc = imgCache.getImageElement(_mapData.getSrcImageName());
    int srcTileSize = _mapData.getSrcTileSize();
    
    int startTileX = (_heroSprite.mapPx ~/ DEF.TILE_SIZE) - 20;
    int startTileY = (_heroSprite.mapPy ~/ DEF.TILE_SIZE) - 20;
    
    for (int ty=0; ty<_tileHeight; ty++) {
      for (int tx=0; tx<_tileWidth; tx++) {
        int tileId = _mapData.getTileIdByPos(startTileX+tx,startTileY+ty);
        int srcPx = _mapData.getImageSrcPx(tileId);
        int srcPy = _mapData.getImageSrcPy(tileId);
        int dstPy = ty * DEF.TILE_SIZE;
        int dstPx = tx * DEF.TILE_SIZE;
        ctx.drawImageScaledFromSource(imgSrc, 
                                      srcPx, srcPy, srcTileSize, srcTileSize, 
                                      dstPx, dstPy, DEF.TILE_SIZE, DEF.TILE_SIZE);
      }
    }
  }
  
}