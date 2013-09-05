part of DQ;

typedef void HandleSelection(Game gm);

class YesNoMsgBox extends MsgBox {
  
  String _yesMsg;
  String _noMsg;
  
  bool isFirstMsg;
  HandleSelection _yesHandler = null;
  HandleSelection _noHandler = null;
  
  YesNoMsgBox(Game game, 
      { String initMsg, 
        String yesMsg, 
        String noMsg,
        HandleSelection yesHandler:null,
        HandleSelection noHandler:null,
        bool selfDismissOnFinish:false}): super(game,initMsg,selfDismissOnFinish:selfDismissOnFinish) {
    
    _yesMsg = yesMsg;
    _noMsg = noMsg;
    _yesHandler = yesHandler;
    _noHandler = noHandler;
    
    isFirstMsg = true;
  }
    
  bool _bgDirty = true;
  void setDirty() {
    _bgDirty = true;  
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    
    if (_state == "STATE_WAIT_TO_DISMISS") {
      if (_waitingCounter >= _waitingToDismissTime) {
        dismiss(); 
      }
      return;
    }
    
    if (_state == "STATE_DONE" || _state == "STATE_WAIT_NEXT_PAGE") {
      if (_waitingCounter < DEF.CURSOR_BLINKING_DURATION )
        return;
      
      _waitingCounter = 0;
      if (isCursorVisible) {
        _guiCtx.fillStyle = DEF.menuBGColor;
        _guiCtx.fillRect(nextIconPx, nextIconPy, _TextWriter.fontWidth, _TextWriter.fontHeight);
        isCursorVisible = false;
      }
      else {
        _TextWriter.DrawChar(_guiCtx, "~", nextIconPx, nextIconPy, _TextWriter.scale );
        isCursorVisible = true;
      }
      return;
    }
    
    if (_state == "STATE_WAIT_DECISION") {
      drawBorder(_guiCtx);
      _state = "STATE_WRITING_2";
      return;
    }
    
    if (_waitingCounter < _waitingTime )
      return;
    
    _waitingCounter = 0;
    
    if (_state == "STATE_IDLE") {
      drawBorder(_guiCtx);
      _state = "STATE_WRITING";
    }
    else {
      if (_TextWriter.isFinish()) {
        if (isFirstMsg) {
          _game.AddRequest(new PushRequest(_game, 
              new DecisionBox.fromList(_game,
                              DecisionBox.GetYesNoMsgBoxRect(),
                              [["Yes",_yesMsg],["No",_noMsg]])));
          _state = "STATE_WAIT_DECISION";  
        }
        else {
          if (!_selfDismiss) {
            _state = "STATE_DONE";
          }
          else {
            _state = "STATE_WAIT_TO_DISMISS";
          }
        }
      }
      else {
        if (_TextWriter.isEndPage()) {
          _state = "STATE_WAIT_NEXT_PAGE";
        }
        else {
          _TextWriter.WriteNextChar(_guiCtx);
        }
      }
    }
  }
  
  void activate({Map<String,dynamic> args: null}) { 
    if (_state == "STATE_WAIT_DECISION") {
      if (args != null && args.containsKey("UserSelection")) {
        
        var item = args["UserSelection"];
        if (item[0] == "Yes") {
          if (_yesHandler != null) {
            _yesHandler(_game);
          }
        }
        else {
          if (_noHandler != null) {
            _noHandler(_game);
          }
        }
        
        drawBorder(_guiCtx);
        _TextWriter.MessageToWrite = item[1];
        _TextWriter.NewPage();
        isFirstMsg = false;
      }
    }
  }
  
  void deactivate({Map<String,dynamic> args: null}) {
  }

  void reset() {
    _state = "STATE_IDLE";
  }
  
  void update(num delta) {
    if (_state == "STATE_DONE" || _state == "STATE_WAIT_NEXT_PAGE") {
      if (_waitingCounter < DEF.CURSOR_BLINKING_DURATION ) {
        _waitingCounter += delta;  
      }
    }
    else if (_state == "STATE_WAIT_TO_DISMISS") {
      if (_waitingCounter < _waitingToDismissTime) {
        _waitingCounter += delta;  
      }
    }
    else {
      if (_waitingCounter < _waitingTime ) {
        _waitingCounter += delta;  
      }
    }
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
        if (_state == "STATE_DONE") {
          if (!_selfDismiss) { 
            dismiss();
          }
        }
        else if (_state == "STATE_WAIT_NEXT_PAGE") {
          _TextWriter.NewPage();
          drawBorder(_guiCtx);
          _state = "STATE_WRITING";
        }
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