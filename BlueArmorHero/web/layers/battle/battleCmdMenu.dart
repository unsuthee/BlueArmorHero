part of DQ;

class BattleCmdMenu extends Layer {
  
  Game _game = null;
  battleMenu _battleMenu = null;
  DecisionBox _decisionBox = null;
  
  Rect CmdBarBox = new Rect(32,264,154,88);
  
  BattleAction _choosenAction = null;
  
  BattleCmdMenu(Game game, battleMenu menu) {
    _game = game;
    _battleMenu = menu;
    _decisionBox = new DecisionBox.fromList(_game, CmdBarBox, 
        [["Fight" ,null],
         ["Flee"  ,null],
         ["Spell" ,null],
         ["Item"  ,null]]);
  }
  
  void activate({Map<String,dynamic> args: null}) {
    if (args != null && args.containsKey("UserSelection")) {
      BattleAction action = args["UserSelection"];
      assert(action != null);
      _choosenAction = action;
    }
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
    if (_choosenAction != null) 
      return;
    
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
        switch(selectedItem[0]) {
          case "Fight":
            _choosenAction = new HeroAtkAction(_battleMenu.heroBattler,_battleMenu.monsBattler);
            break;
          case "Flee":
            _choosenAction = new HeroFleeAction(_battleMenu.heroBattler,_battleMenu.monsBattler);
            break;
          case "Spell":
            List spells = _game.gameState.getBattleSpells();
            if (spells.isEmpty) {
              _game.AddRequest(new PushRequest(_game, new MsgBox(_game,"You have not learned any battle spell yet!",selfDismissOnFinish:true)));  
              _game.AddRequest(new RedrawRequest(_game));
            }
            else {
              // push another menu
              _game.AddRequest(new PushRequest(_game, new BattleSpellMenu(_game, _battleMenu, spells)));
            }
            break;
          case "Item":
            List items = [];
            for (Item item in _game.gameState.Inventory) {
              items.add(item.name); 
            }
            if (items.isEmpty) {
              _game.AddRequest(new PushRequest(_game, new MsgBox(_game,"You do not have any item to use!",selfDismissOnFinish:true)));  
              _game.AddRequest(new RedrawRequest(_game));
            }
            else {
              _game.AddRequest(new PushRequest(_game, new BattleItemMenu(_game, _battleMenu, items)));
            }
            break;
          default:
            assert(false); // unknown item
            break;
        }
        // we don't pop immediately. we wait until the next frame to pop.
        break;
      case DEF.KEYBOARD_SECONDARY:
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