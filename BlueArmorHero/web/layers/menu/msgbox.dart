part of DQ;

typedef void OnCompleteMsg(MsgBox msgBox);

class MsgBox extends Layer {
  
  Game _game;
  TextWriter2 _TextWriter = null;
  CanvasElement _guiCanvas = null;
  CanvasRenderingContext2D _guiCtx = null;
  
  int width = 16 * DEF.TILE_SIZE;
  int height = 5 * DEF.TILE_SIZE - (DEF.TILE_SIZE >> 2);
  int px = 2 * DEF.TILE_SIZE;
  int py = 10 * DEF.TILE_SIZE;
  int gap = 2;
  int pad = 5;
  
  // Idle, Writing, WaitNextPage, Done
  String _state = "STATE_IDLE";
  num _waitingCounter = 0;
  num _waitingTime = 5; // 1 sec
  
  String _currentBGColor = DEF.COLOR_WHITE;
  int nextIconPx;
  int nextIconPy;
  bool isCursorVisible = false;
  
  bool _selfDismiss = false;
  final num _waitingToDismissTime = 500;
  
  // Handlers
  OnCompleteMsg _onCompleteMsgHandler = null;
  
  MsgBox(Game game, String msg, 
      { bool selfDismissOnFinish:false, 
        OnCompleteMsg onCompleteMsgHandler:null}) {
    
    _game = game;
    _guiCanvas = game.guiCanvas;
    _guiCtx = game.guiCanvasCtx;
    
    _onCompleteMsgHandler = onCompleteMsgHandler;
    _selfDismiss = selfDismissOnFinish;
    
    _TextWriter = new TextWriter2(new Rect( px+pad+gap,
                                            py+pad+gap,
                                            width-pad-gap,
                                            height-pad-gap));
 
    _TextWriter.MessageToWrite = msg;
    
    // It is double-space
    _TextWriter.rightPadding = _TextWriter.fontWidth;
    _TextWriter.RowSpace = 2;
    _TextWriter.color = DEF.COLOR_WHITE;
    _currentBGColor =  DEF.COLOR_WHITE;
    
    nextIconPx = px + width -pad-gap - _TextWriter.rightPadding;
    nextIconPy = py + height -pad-gap - _TextWriter.fontHeight;
    _state = "STATE_IDLE";
  }
  
  void dismiss() {
    _guiCtx.clearRect(px,py,width,height);
    _game.AddRequest(new PopRequest(_game));
    _game.AddRequest(new RedrawRequest(_game));
    _state = "STATE_IDLE";
  }
  
  void drawBorder(CanvasRenderingContext2D ctx) {
    ctx.clearRect(px,py,width,height); 

    ctx.fillStyle = _currentBGColor;
    ctx.fillRect(px, py, width, height);
    
    ctx.fillStyle = DEF.menuBGColor;
    ctx.fillRect(px+pad, py+pad, width-pad-pad, height-pad-pad);
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
    
    if (_waitingCounter < _waitingTime )
      return;
    
    _waitingCounter = 0;
    
    if (_state == "STATE_IDLE") {
      drawBorder(_guiCtx);
      _state = "STATE_WRITING";
    }
    else {
      if (_TextWriter.isFinish()) {
        if (_selfDismiss) {
          _state = "STATE_WAIT_TO_DISMISS"; 
        }
        else {
          _state = "STATE_DONE";
        }
        if (_onCompleteMsgHandler != null) {
          _onCompleteMsgHandler(this);
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