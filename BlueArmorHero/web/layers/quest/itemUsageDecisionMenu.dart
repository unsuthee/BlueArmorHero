part of DQ;

class ItemUsageDecisionMenu extends Layer {
  
  Game _game = null;
  battleMenu _battleMenu = null;
  DecisionBox _decisionBox = null;
  
  Rect spellCmdBox = new Rect(200,260,220,200);
  
  BattleAction _choosenAction = null;
  
  ItemUsageDecisionMenu(Game game, battleMenu menu, List items) {
    _game = game;
    _battleMenu = menu;
    
    List AvailableItems = [];
    for(String item in items) {
      BattleAction action = null;
      if(stats.BattleItemTable.containsKey(item)) {
        switch(item) {
          case "Herb":
            action = new HerbItem(_battleMenu.heroBattler,_battleMenu.monsBattler);
            break;
          case "Fairy Flute":
            action = new FairyFluteItem(_battleMenu.heroBattler,_battleMenu.monsBattler);
            break;
        }
      }
      AvailableItems.add(["${item}",action]);
    }
    _decisionBox = new DecisionBox.fromList(_game, spellCmdBox, AvailableItems);
  }
  
  void activate({Map<String,dynamic> args: null}) {
  }
  
  void deactivate({Map<String,dynamic> args: null}) {
  }

  void setDirty() {
    _decisionBox.setDirty();
  }
  
  void cleanup() {
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    _decisionBox.draw(ctx);
  }
  
  void update(num delta) {
    _decisionBox.update(delta);
    if (_choosenAction != null) {
      _decisionBox.cleanup();
      _game.AddRequest(new PopRequest(_game,activateParams:{"UserSelection":_choosenAction}));
    }
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
        List selectedItem = _decisionBox.getCurrentSelectedItem();
        // check if hero has enough MP
        if (selectedItem[1] == null) {
          _game.AddRequest(new PushRequest(_game, 
              new MsgBox( _game,
                          "You try to use it as an item but nothing happen!",
                          selfDismissOnFinish:true)));  
          _game.AddRequest(new RedrawRequest(_game));
        }
        else {
          _choosenAction = selectedItem[1];
          assert(_choosenAction != null);
        }
        break;
      case DEF.KEYBOARD_SECONDARY:
        _decisionBox.cleanup();
        _game.AddRequest(new PopRequest(_game));
        _game.AddRequest(new RedrawRequest(_game));
        break;
    }
  }
  
  void OnKeyboardUp(KeyboardEvent e) {
    switch (e.keyCode)
    {
      case DEF.KEYBOARD_LEFT:
        break;
      case DEF.KEYBOARD_UP:
        break;
      case DEF.KEYBOARD_RIGHT:
        break;
      case DEF.KEYBOARD_DOWN:
        break;
      case DEF.KEYBOARD_PRIMARY:
        break;
      case DEF.KEYBOARD_SECONDARY:
        break;
    }
  }
}