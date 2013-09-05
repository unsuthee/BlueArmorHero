part of DQ;

class SellItemListMenu extends Layer {
  
  Game _game;
  DecisionBox _decisionBox = null;
  
  static const int BROWSING_STATE = 0;
  static const int DISMISSAL_STATE = 2;
  int _state = BROWSING_STATE;
  
  SellItemListMenu(Game gm) {
    _game = gm;  
    
    List<Item> items = _game.gameState.Inventory;
    int maxLen = 0;
    List itemList = [];
    for(Item itm in items) {
      maxLen = MATH.max(itm.name.length, maxLen);
      itemList.add([itm.name,itm]);
    }

    Rect decisionBox = new Rect( 4 * DEF.TILE_SIZE, 
        5 * DEF.TILE_SIZE,
        (maxLen-5) * DEF.TILE_SIZE,
        MATH.max((items.length-2),5) * DEF.TILE_SIZE);
    
    _decisionBox = new DecisionBox.fromList(  _game, 
                                              decisionBox,
                                              itemList);
    
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
    _decisionBox.draw(ctx);
  }
  
  void update(num delta) {
    _decisionBox.update(delta);
    
    switch(_state) {
      case DISMISSAL_STATE:
        dismiss();
        break;
    }
  }
  
  void dismiss() {
    _decisionBox.cleanup();
    _game.AddRequest(new PopRequest(_game));
    _game.AddRequest(new RedrawRequest(_game));
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
        Item toSellItem = action[1];
        int sellingCost = toSellItem.cost ~/ 2;
        String msg = "The ${toSellItem.name} huh?;I'll give you ${sellingCost} gold for that, okay?";
        String yesMsg = "Thanks a lot!";
        String noMsg = "That's too bad...";
        
        _game.AddRequest(new PushRequest(_game, new YesNoMsgBox(_game,
            selfDismissOnFinish:false,
            initMsg:msg,
            yesMsg:yesMsg,
            noMsg:noMsg,
            yesHandler:(Game gm) {
              if(toSellItem.IsEquip) {
                gm.gameState.Stats.UnEquip(toSellItem.getType());
              }
              gm.gameState.RemoveItem(toSellItem);
              gm.gameState.Stats.Gold += sellingCost;
            })));
        
        _state = DISMISSAL_STATE;
        break;
      case DEF.KEYBOARD_SECONDARY:
        _state = DISMISSAL_STATE;
        break;
    }
  }
  
  void OnKeyboardUp(KeyboardEvent e) {
  }
  
}