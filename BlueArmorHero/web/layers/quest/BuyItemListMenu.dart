part of DQ;

class BuyItemListMenu extends Layer {
  
  Game _gm;
  DecisionBox _decisionBox = null;
  
  static const int BUY_ACTION = 1;
  static const int SELL_ACTION = 2;
  static const int END_ACTION = 3;
  
  static const int BROWSING_STATE = 0;
  static const int HAS_BOUGHT_ITEM_STATE = 1;
  static const int DISMISSAL_STATE = 2;
  int _state = BROWSING_STATE;
  
  List<BattleTask> _tasks = [];
  
  bool launchItemList = false;
  bool isBuy;
  
  BuyItemListMenu(Game gm, List<Item> itemInfo) {
    _gm = gm;
    
    int maxItemNameLen = 0;
    List itemList = [];
    for(Item itm in itemInfo) {
      maxItemNameLen = MATH.max(maxItemNameLen, itm.name.length);    
    }
    
    int horzSpace = maxItemNameLen + 6;
    for(Item itm in itemInfo) {
      String cost = "${itm.cost}";
      String ws = whitespace(horzSpace - itm.name.length - cost.length);
      itemList.add(["${itm.name}${ws}${cost}",itm]);
    }
    
    Rect decisionBox = new Rect( 4 * DEF.TILE_SIZE, 
        5 * DEF.TILE_SIZE,
        (horzSpace - 6) * DEF.TILE_SIZE,
        (itemList.length) * DEF.TILE_SIZE);
    
    _decisionBox = new DecisionBox.fromList(  _gm, 
                                              decisionBox,
                                              itemList);
  }
  
  String whitespace(int n) {
    assert(n>=0);
    String str = "";
    for(int i=0; i<n; i++) {
      str += " ";
    }
    return str;
  }
  
  void activate({Map<String,dynamic> args: null}) {
  }
  
  void deactivate({Map<String,dynamic> args: null}) {
  }

  void setDirty() {
    _decisionBox.setDirty();
  }
  
  void cleanup() {
    _decisionBox.cleanup();
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    
    if (_tasks.isNotEmpty) {
      if (!_tasks[0].isComplete()) {
        _tasks[0].draw(ctx);
      }
      return;
    }
    
    _decisionBox.draw(ctx);
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
    
    _decisionBox.update(delta);  
    
    switch(_state) {
      case DISMISSAL_STATE:
        dismiss();
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
        Item toBuyItem = action[1];
        
        if (_gm.gameState.isInventoryFull()) {
          String msg = "The ${toBuyItem.name}...;But your bag doesn't have enough room to store this item.";
          _gm.AddRequest(new PushRequest(_gm, new MsgBox(_gm,msg,selfDismissOnFinish:true)));
          _state = DISMISSAL_STATE;
        }
        else if (_gm.gameState.heroGold <= toBuyItem.cost) {
          String msg = "The ${toBuyItem.name}...;Would you like to equip this right now?";
          String yesMsg = "${_gm.gameState.heroName} equipped ${toBuyItem.name}";
          String noMsg = "Here you go ${_gm.gameState.heroName}";
          
          _gm.AddRequest(new PushRequest(_gm, new YesNoMsgBox(_gm,
              selfDismissOnFinish:false,
              initMsg:msg,
              yesMsg:yesMsg,
              noMsg:noMsg,
              yesHandler:(Game gm) {
                _gm.gameState.AddItem(toBuyItem);
                _gm.gameState.Stats.Equip(toBuyItem);
              },
              noHandler: (Game gm) {
                _gm.gameState.AddItem(toBuyItem);
              })));
          
          _state = DISMISSAL_STATE;
        }
        else {
          String msg = "The ${toBuyItem.name}...;But you don't have enough money to purchase that.";
          _gm.AddRequest(new PushRequest(_gm, new MsgBox(_gm,msg,selfDismissOnFinish:true)));
          _state = DISMISSAL_STATE;
        }
        break;
      case DEF.KEYBOARD_SECONDARY:
        _state = DISMISSAL_STATE;
        break;
    }
  }
  
  void OnKeyboardUp(KeyboardEvent e) {
  }
}