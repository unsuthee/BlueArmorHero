part of DQ;

class InnMenu extends Layer {
  
  Game _gm;
  List<BattleTask> _tasks = [];
  
  static const int PRE_STATE = 0;
  static const int DECISION_STATE = 1;
  static const int STAYING_STATE = 2;
  static const int DISMISS_STATE = 5;
  int _state = PRE_STATE;
  
  int _cost;
  InnMenu(Game gm, int cost) {
    _gm = gm;
    _cost = cost;
  }
  
  void activate({Map<String,dynamic> args: null}) {
  }
  
  void deactivate({Map<String,dynamic> args: null}) {
  }

  void setDirty() {
  }
  
  void cleanup() {
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    
    if (_tasks.isNotEmpty) {
      if (!_tasks[0].isComplete()) {
        _tasks[0].draw(ctx);
      }
      return;
    }
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
    
    switch(_state) {
      case PRE_STATE:
        String msg = "Welcome to Rimuldar Inn. It costs ${_cost}G a night to stay. Would you like to stay here?";
        if (_gm.gameState.Stats.Gold < _cost) {
          String yesMsg = "Sorry... but you don't have enough gold for that!";
          String noMsg = "Have a nice day.";
          _gm.AddRequest(new PushRequest(_gm, new YesNoMsgBox(_gm,
              selfDismissOnFinish:false,
              initMsg:msg,
              yesMsg:yesMsg,
              noMsg:noMsg,
              yesHandler:(Game gm) {
                _state = DISMISS_STATE;
              },
              noHandler: (Game gm) {
                _state = DISMISS_STATE;
              })));
        }
        else {
          String yesMsg = "Thank you very much. Please enjoy your stay!";
          String noMsg = "Have a nice day.";
          
          _gm.AddRequest(new PushRequest(_gm, new YesNoMsgBox(_gm,
              selfDismissOnFinish:false,
              initMsg:msg,
              yesMsg:yesMsg,
              noMsg:noMsg,
              yesHandler:(Game gm) {
                gm.gameState.Stats.Gold -= _cost;
                assert(gm.gameState.Stats.Gold >= 0);
                
                gm.gameState.Stats.RefillHp();
                gm.gameState.Stats.RefillMp();
                _state = STAYING_STATE;
              },
              noHandler: (Game gm) {
                _state = DISMISS_STATE;
              })));
          _state = DECISION_STATE;
        }
        break;
      case STAYING_STATE:
        _tasks.add(new AnnotateTask(_gm, ["Sleeping... Zzz Zzz"]));
        _tasks.add(new AnnotateTask(_gm, ["Hope you enjoy your stay with us. Please come again!"]));
        _state = DISMISS_STATE;
        break;
      case DISMISS_STATE:
        dismiss();
        break;
    }
  }
  
  void dismiss() {
    _gm.AddRequest(new PopRequest(_gm));
    _gm.AddRequest(new RedrawRequest(_gm));
  }
  
  void OnKeyboardDown(KeyboardEvent e) {
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
        _state = DISMISS_STATE;
        break;
    }
  }
  
  void OnKeyboardUp(KeyboardEvent e) {
  }
}