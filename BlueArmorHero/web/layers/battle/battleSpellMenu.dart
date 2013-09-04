part of DQ;

class BattleSpellMenu extends Layer {
  
  Game _game = null;
  battleMenu _battleMenu = null;
  DecisionBox _decisionBox = null;
  
  Rect spellCmdBox = new Rect(200,260,184,130);
  
  BattleAction _choosenAction = null;
  
  BattleSpellMenu(Game game, battleMenu menu, List spells) {
    _game = game;
    _battleMenu = menu;
    
    List items = [];
    for(String spell in spells) {
      if(stats.BattleSpellTable.containsKey(spell)) {
        int spellCost = stats.BattleSpellTable[spell][1];
        items.add(["${spell}",spellCost]);
      }
    }
    _decisionBox = new DecisionBox.fromList(_game, spellCmdBox, items);
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
        if (selectedItem[1] > _game.gameState.heroMP) {
          _game.AddRequest(new PushRequest(_game, 
              new MsgBox( _game,
                          "You do not have enough MP to cast this spell!",
                          selfDismissOnFinish:true)));  
          _game.AddRequest(new RedrawRequest(_game));
        }
        else {
          switch(selectedItem[0]) {
            case "Heal":
              _choosenAction = new HealSpell(_battleMenu.heroBattler,_battleMenu.monsBattler);
              break;
            case "Hurt":
              _choosenAction = new HeroHurtSpell(_battleMenu.heroBattler,_battleMenu.monsBattler);
              break;
            case "Sleep":
              _choosenAction = new SleepSpell(_battleMenu.heroBattler,_battleMenu.monsBattler);
              break;
            case "Stop":
              _choosenAction = new StopSpell(_battleMenu.heroBattler,_battleMenu.monsBattler);
              break;
            case "HealMore":
              _choosenAction = new HealSpell(_battleMenu.heroBattler,_battleMenu.monsBattler,healMore:true);
              break;
            case "HurtMore":
              _choosenAction = new HeroHurtSpell(_battleMenu.heroBattler,_battleMenu.monsBattler,hurtMore:true);
              break;
            default:
              assert(false); // unknown item
              break;
          }
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