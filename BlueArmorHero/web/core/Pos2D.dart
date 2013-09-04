part of DQ;

class Pos2D {
  
  int _x;
  int _y;
  int get x => _x;
  int get y => _y;
  set x(int px) { _x = px; }
  set y(int py) { _y = py; }
  
  Pos2D(int px, int py) {
    _x = px;
    _y = py;
  }
}