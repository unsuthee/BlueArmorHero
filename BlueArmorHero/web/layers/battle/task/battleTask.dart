part of DQ;

abstract class BattleTask {

  void start();
  void end();
  
  bool isComplete();
  void update(num delta);
  void draw(CanvasRenderingContext2D ctx);
}