part of DQ;

class BuySellMenu extends Layer {
  
  Game _gm;
  DecisionBox _decisionBox = null;
  
  static const int PRE_PENDING_STATE = 0;
  static const int BUY_PENDING_STATE = 1;
  static const int SELL_PENDING_STATE = 2;
  static const int POST_PENDING_STATE = 3;
  int _state = PRE_PENDING_STATE;
  
  static const int BUY_ACTION = 1;
  static const int SELL_ACTION = 2;
  static const int END_ACTION = 3;
  
  List<BattleTask> _tasks = [];
  List itemInfo = null;
  
  BuySellMenu(Game gm, String shopname, List itmInfo) {
    _gm = gm;
    _tasks.add(new AnnotateTask(_gm,["This is a ${shopname} shop.;How may I help you?"],selfDismissOnFinish:true));
    itemInfo = itmInfo;
  }
  
  void activate({Map<String,dynamic> args: null}) {
  }
  
  void deactivate({Map<String,dynamic> args: null}) {
  }

  void setDirty() {
    if (_decisionBox != null) {
      _decisionBox.setDirty();
    }
  }
  
  void cleanup() {
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    
    if (_tasks.isNotEmpty) {
      if (!_tasks[0].isComplete()) {
        _tasks[0].draw(ctx);
      }
      else {
        _tasks.removeAt(0);
        if (_tasks.isNotEmpty) {
          _tasks[0].start();
        }
      }
      return;
    }
    if (_decisionBox != null) {
      _decisionBox.draw(ctx);
    }
  }
   
  void update(num delta) {
    
    if (_tasks.isNotEmpty) {
      if (!_tasks[0].isComplete()) {
        _tasks[0].update(delta);
      }
      else {
        _tasks[0].end();
      }
      return;
    }
    
    if (_decisionBox == null) {
      Rect decisionBox = new Rect( 15 * DEF.TILE_SIZE, 
          4 * DEF.TILE_SIZE,
          3 * DEF.TILE_SIZE,
          2 * DEF.TILE_SIZE + (DEF.TILE_SIZE >> 2));
      
      _decisionBox = new DecisionBox.fromList(  _gm, 
          decisionBox,
          [["Buy" ,BUY_ACTION],
           ["Sell",SELL_ACTION],
           ["End" ,END_ACTION]]);
    }
    _decisionBox.update(delta);
    
    switch (_state) {
      case PRE_PENDING_STATE:
        break;
      case BUY_PENDING_STATE:
        _gm.AddRequest(new PushRequest(_gm, new BuyItemListMenu(_gm, itemInfo)));
        _state = POST_PENDING_STATE;
        break;
      case SELL_PENDING_STATE:
        _gm.AddRequest(new PushRequest(_gm, new SellItemListMenu(_gm)));
        _state = POST_PENDING_STATE;
        break;
      case POST_PENDING_STATE:
        _tasks.add(new AnnotateTask(_gm,["Would you like anything else?"]));
        _state = PRE_PENDING_STATE;
        break;
    }
  }
  
  void dismiss() {
    _decisionBox.cleanup();
    _gm.AddRequest(new PopRequest(_gm));
    _gm.AddRequest(new RedrawRequest(_gm));
  }
  
  void OnKeyboardDown(KeyboardEvent e) {
    switch (e.keyCode)
    {
      case DEF.KEYBOARD_LEFT:
        break;
      case DEF.KEYBOARD_UP:
        _decisionBox.MoveCursorUp();
        break;
      case DEF.KEYBOARD_RIGHT:
        break;
      case DEF.KEYBOARD_DOWN:
        _decisionBox.MoveCursorDown();
        break;
      case DEF.KEYBOARD_PRIMARY:
        List action = _decisionBox.getCurrentSelectedItem();
        switch(action[1]){
          case BUY_ACTION:
            _tasks.add(new AnnotateTask(_gm,["So you want to buy something...;What would you like to buy?"]));
            _state = BUY_PENDING_STATE;
            break;
          case SELL_ACTION:
            _tasks.add(new AnnotateTask(_gm,["What's for sale?"]));
            _state = SELL_PENDING_STATE;
            break;
          case END_ACTION:
            dismiss();
            break;
          default:
            break;
        }
        break;
      case DEF.KEYBOARD_SECONDARY:
        dismiss();
        break;
    }
  }
  
  void OnKeyboardUp(KeyboardEvent e) {
  }
}