part of DQ;

class BlinkMonsterTask extends BattleTask {
  
  Game _game;
  static const num blinkDuration = 500; // ms
  battleMenu _battleMenu;
  bool _isDead;
  
  num blinkCounter = 0;
  
  BlinkMonsterTask(Game gm, battleMenu menu, {bool dead: false}) {
    _game = gm;  
    _battleMenu = menu;
    
    _isDead = dead;
  }
  
  void start() {
    blinkCounter = 0;
  }
  
  void end() {
    _battleMenu.clearBackground();
    _battleMenu.drawBackground(_game.spriteCanvasCtx);
    if (!_isDead) {
      _battleMenu.drawMonster(_game.spriteCanvasCtx);
    }
  }
  
  bool isComplete() {
    return (blinkCounter >= blinkDuration);
  }
  
  void update(num delta) {
    if (isComplete())
      return;
    
    if (blinkCounter < blinkDuration) {
      blinkCounter+=delta;
    }
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    if (isComplete())
      return;
    
    _battleMenu.clearBackground();
    _battleMenu.drawBackground(_game.spriteCanvasCtx);
    
    if ((blinkCounter ~/50) % 2 == 0) {
      _battleMenu.drawMonster(_game.spriteCanvasCtx);  
    }
  }
}