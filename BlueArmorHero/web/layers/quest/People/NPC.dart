part of DQ;

typedef void OnTalkHandler(Game gm, HeroSprite talker, NPC talkee);

class NPC extends Thing {
  
  CharacterSprite _currSprite = null;
  CharacterSprite get characterSprite => _currSprite;

  int _currDirection;
  int get direction => _currDirection;
  int _currState;
  
  String _name;
  String get name => _name;
  
  OnTalkHandler _talkHandler = null;
  
  static const int BEHAVIOR_STANDING = 0;
  static const int BEHAVIOR_WALKING = 1;
  int _behavior;
  
  static const int STATE_IDLE = 0;
  static const int STATE_MOVING = 1;
  
  static double velocity = (50 / 1000); // 10 / 1000 pcx per ms
  
  var rng = new MATH.Random();
  num waiting_counter;
  num max_waiting_time;
  
  static const num MIN_WAITING_TIME_MOVING = 250;
  static const num MAX_WAITING_TIME_MOVING = 1000;
  static const num WAITING_TIME_MOVING_RANGE = MAX_WAITING_TIME_MOVING - MIN_WAITING_TIME_MOVING;
  static const num MIN_WAITING_TIME_STANDING = 1000;
  static const num WAITING_TIME_STANDING_RANGE = 2000;
  
  int offsetX;
  int offsetY;
  
  NPC(  Game game, 
        String type, 
      { String name, 
        int px:0, 
        int py:0, 
        int direction:DEF.DIR_DOWN,
        int behavior_type:BEHAVIOR_STANDING,
        int drawingOffsetX: 0,
        int drawingOffsetY: 0,
        OnTalkHandler talkHandler:null}): super(game,px.toDouble(),py.toDouble()) 
  {
    _talkHandler = talkHandler;
    _name = name;
    _currSprite = new CharacterSprite(type);
    _currSprite.setAnimation(direction);
    _currDirection = direction;
    
    _behavior = behavior_type;
    _currState = STATE_IDLE;
    
    waiting_counter = 0;
    max_waiting_time = 1000;
    
    offsetX = drawingOffsetX;
    offsetY = drawingOffsetY;
  }
  
  void draw(CanvasRenderingContext2D ctx, {int px, int py}) {
    _currSprite.draw(ctx,px:px,py:py);
  }
  
  void update(num delta) {
    _currSprite.update(delta.toInt());
    
    if (_behavior == BEHAVIOR_WALKING) {
      if (waiting_counter >= max_waiting_time) {
        switch(_currState) {
          case STATE_IDLE:
            // pick the direction and go
            int dir = rng.nextInt(4) + 1;
            characterSprite.setAnimation(dir);
            _currDirection = dir;
            _currState = STATE_MOVING;
            max_waiting_time = rng.nextInt(WAITING_TIME_MOVING_RANGE.toInt()) + MIN_WAITING_TIME_MOVING;
            break;
          case STATE_MOVING:
            // stop walking
            _currState = STATE_IDLE;
            max_waiting_time = rng.nextInt(WAITING_TIME_STANDING_RANGE.toInt()) + MIN_WAITING_TIME_STANDING;
            break;
        }
        waiting_counter = 0;
      }
      else {
        if (_currState == STATE_MOVING) {
          double dist = delta * velocity;
          switch(direction) {
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
        }
        waiting_counter += delta;
      }
    }
  }
  
  void ResetToIdle() {
    _currState = STATE_IDLE;
    max_waiting_time = rng.nextInt(WAITING_TIME_STANDING_RANGE.toInt()) + MIN_WAITING_TIME_STANDING;;
    waiting_counter = 0;
  }
  
  Rect getRect() {
    return new Rect(_mapPx.toInt()+offsetX,_mapPy.toInt()+offsetY,DEF.TILE_SIZE,DEF.TILE_SIZE);
  }
  
  void OnTalkBegin(Game gm, HeroSprite talker) {
    if (_talkHandler != null) {
      _talkHandler(gm,talker,this);
    }
  }
}