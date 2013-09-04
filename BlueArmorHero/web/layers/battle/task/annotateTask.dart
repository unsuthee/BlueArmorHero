part of DQ;

class AnnotateTask extends BattleTask {
  
  Game _game;
  List<String> _msg;
  
  AnnotateTask(Game gm, List<String> msg) {
    _game = gm;  
    _msg = msg;
  }
  
  void start() {
  }

  void end() {
  }
  
  bool isComplete() {
    return _msg.isEmpty;
  }
  
  void update(num delta) {
    if (isComplete())
      return;
    
    String msg = _msg[0];
    _msg.removeAt(0);
    _game.AddRequest(new PushRequest(_game, new MsgBox(_game,msg)));  
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    if (isComplete())
      return;
  }
}
