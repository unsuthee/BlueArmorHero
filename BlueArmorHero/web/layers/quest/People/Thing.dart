part of DQ;

abstract class Thing {
  
  double _mapPx;
  double _mapPy;
  double get mapPx => _mapPx;
  double get mapPy => _mapPy;
  void set mapPx(double px) {
    _mapPx = px;
  }
  void set mapPy(double py) {
    _mapPy = py;
  }
  
  int get TilePosX => _mapPx ~/ 8;
  int get TilePosY => _mapPy ~/ 8;
  
  String get PositionStr => "${mapPx}:${mapPy}";
  
  Game _game = null;
  
  Thing(Game game, double px, double py) {
    _game = game;
    _mapPx = px;
    _mapPy = py;
  }
  
  void draw(CanvasRenderingContext2D ctx, {int px, int py});
  
  void update(num delta);
  
  Rect getRect() {
    return new Rect(_mapPx.toInt(),_mapPy.toInt(),DEF.TILE_SIZE,DEF.TILE_SIZE);
  }
  
  void OnTalkBegin(Game gm, HeroSprite talker) {
  }
}