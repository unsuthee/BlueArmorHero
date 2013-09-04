part of DQ;

class ShakingScreenTask extends BattleTask {
  
  Game _game;
  static const int shakingDistance = 20;
  static const int shakingPerDistance = 50;
  
  int _shakeDistance;
  int _shakeCounter;
  num _prevHorzOffset;
  
  battleMenu _battleMenu;
  
  ShakingScreenTask(Game gm, battleMenu menu) {
    _game = gm;  
    _shakeDistance = shakingDistance;
    _shakeCounter = 0;
    _prevHorzOffset = 0;
    
    _battleMenu = menu;
  }
  
  void start() {
  }
  
  void end() {
  }
 
  bool isComplete() {
    return (_shakeDistance <= 0);
  }
  
  void update(num delta) {
    if (_shakeDistance <= 0)
      return;
    
    if (_shakeCounter < shakingPerDistance) {
      _shakeCounter++;
    }
    else {
      _shakeCounter = 0;
    }
    _shakeDistance--;
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    if (_shakeDistance <= 0)
      return;
    
    _battleMenu.clearBackground(horzOffset:_prevHorzOffset);
    num horzOffset = (_shakeCounter % 2 == 0) ? _shakeDistance: -1 * _shakeDistance;
    _battleMenu.drawBackground(_game.spriteCanvasCtx, horzOffset: horzOffset);
    _battleMenu.drawMonster(_game.spriteCanvasCtx, horzOffset: horzOffset);
    _prevHorzOffset = horzOffset;
  }
}