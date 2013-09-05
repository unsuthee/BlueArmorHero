part of DQ;

class DecisionBox extends Layer {
  
  Game _game;
  TextWriter2 _TextWriter = null;
  CanvasElement _guiCanvas = null;
  CanvasRenderingContext2D _guiCtx = null;
  
  int gap = 2;
  int pad = 5;
  Rect _drawingBox = null;
  
  // Idle, Writing, WaitNextPage, Done
  String _state = "STATE_IDLE";
  num _waitingCounter = 0;
  
  String _currentBGColor = DEF.COLOR_WHITE;
  bool isCursorVisible = false;
  
  List<List<String,dynamic>> _items;
  int _cursorIndex = 0;
  int _lastCursorIndex = -1;
  
  List getCurrentSelectedItem() {
    return _items[_cursorIndex];
  }
  
  Rect get DrawingBox => _drawingBox;
  
  static Rect GetYesNoMsgBoxRect() {
    return new Rect( 15 * DEF.TILE_SIZE, 
                      4 * DEF.TILE_SIZE,
                      3 * DEF.TILE_SIZE,
                      2 * DEF.TILE_SIZE - (DEF.TILE_SIZE >> 2));
  }
  
  bool _bgDirty = true;
  void setDirty() {
    _bgDirty = true;  
  }
  
  String _msg = null;
  bool _allowCancel = false;
  
  DecisionBox.fromList(Game game, Rect box, List<List<dynamic>> items, {bool allowCancel:false}) {
    _game = game;
    _guiCanvas = game.guiCanvas;
    _guiCtx = game.guiCanvasCtx;
    
    _items = items;
    _allowCancel = allowCancel;
    
    _drawingBox = box;
    _TextWriter = new TextWriter2(new Rect( 
        _drawingBox.left+pad+gap,
        _drawingBox.top+pad+gap,
        _drawingBox.width-pad-gap,
        _drawingBox.height-pad-gap));
 
    bool isFirst = true;
    String msg = "";
    for(List item in items) {
      if (isFirst) {
        msg += item[0];
        isFirst = false;
      }
      else {
        msg += " ;" + item[0];
      }
    }
    
    _msg = msg;
    _TextWriter.leftPadding = _TextWriter.fontWidth;
    _TextWriter.rightPadding = 1;
    _TextWriter.topPadding = 1;
    _TextWriter.bottomPadding = 1;
    _TextWriter.color = DEF.COLOR_WHITE;
    _TextWriter.AutoNewline = false;
    
    _currentBGColor =  DEF.COLOR_WHITE;
    
    _state = "STATE_IDLE";
    
    _TextWriter.NewPage();
  
    drawBorder(_guiCtx);
    while (!_TextWriter.isFinish()) {
      _TextWriter.WriteNextChar(_guiCtx);
    }
  }
  
  void InitTextWriter(Rect box, List<List<String,dynamic>> items, {bool allowCancel:false}) {
    _items = items;
    _allowCancel = allowCancel;
    
    _drawingBox = box;
    _TextWriter = new TextWriter2(new Rect( 
        _drawingBox.left+pad+gap,
        _drawingBox.top+pad+gap,
        _drawingBox.width-pad-gap,
        _drawingBox.height-pad-gap));
 
    bool isFirst = true;
    String msg = "";
    for(List item in items) {
      if (isFirst) {
        msg += item[0];
        isFirst = false;
      }
      else {
        msg += " ;" + item[0];
      }
    }
    _TextWriter.MessageToWrite = msg;
    _TextWriter.leftPadding = _TextWriter.fontWidth;
    _TextWriter.rightPadding = 1;
    _TextWriter.topPadding = 1;
    _TextWriter.bottomPadding = 1;
    _TextWriter.color = DEF.COLOR_WHITE;
    _TextWriter.AutoNewline = false;
    
    //DrawMessage();
    _state = "STATE_IDLE";
  }
  
  void DrawMessage() {
    drawBorder(_guiCtx);
    _TextWriter.NewPage();
    _TextWriter.MessageToWrite = _msg;
    _TextWriter.WriteAll(_guiCtx);
  }
  
  DecisionBox(Game game) {
    _game = game;
    
    _items = null;
    _drawingBox = null;
    
    _guiCanvas = game.guiCanvas;
    _guiCtx = game.guiCanvasCtx;
    _currentBGColor =  DEF.COLOR_WHITE;
    _state = "STATE_INIT";
  }
  
  void drawBorder(CanvasRenderingContext2D ctx) {
    ctx.clearRect(_drawingBox.left, _drawingBox.top, _drawingBox.width, _drawingBox.height); 
    
    ctx.fillStyle = _currentBGColor;
    ctx.fillRect(_drawingBox.left, _drawingBox.top, _drawingBox.width, _drawingBox.height);
    
    ctx.fillStyle = DEF.menuBGColor;
    ctx.fillRect(_drawingBox.left+pad, _drawingBox.top+pad, _drawingBox.width-pad-pad, _drawingBox.height-pad-pad);
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    if (_state == "STATE_INIT")
      return;
    if (_bgDirty) {
      DrawMessage();
      _bgDirty = false;
    }
    if (_waitingCounter < DEF.CURSOR_BLINKING_DURATION )
      return;
    
    _waitingCounter = 0;
    int py = _TextWriter.getPyByRow(_cursorIndex);
    int px = _TextWriter.getPxByIndex(0) - _TextWriter.fontWidth;
    
    if (isCursorVisible) {
      _guiCtx.fillStyle = DEF.menuBGColor;
      _guiCtx.fillRect(px, py, _TextWriter.fontWidth, _TextWriter.fontHeight);
      isCursorVisible = false;
    }
    else {
      _TextWriter.DrawChar(_guiCtx, ">", px, py, _TextWriter.scale );
      isCursorVisible = true;
    }
  }
  
  void activate({Map<String,String> args: null}) { 
  }
  
  void deactivate({Map<String,String> args: null}) {
  }

  void cleanup() {
    _guiCtx.clearRect(_drawingBox.left, _drawingBox.top, _drawingBox.width, _drawingBox.height);
  }
  
  void update(num delta) {
    if (_state == "STATE_INIT")
      return;
    
    if (_waitingCounter < DEF.CURSOR_BLINKING_DURATION ) {
      _waitingCounter += delta;  
    }
  }
  
  void clearCursor(CanvasRenderingContext2D ctx) {
    int py = _TextWriter.getPyByRow(_cursorIndex);
    int px = _TextWriter.getPxByIndex(0) - _TextWriter.fontWidth;
    ctx.fillStyle = DEF.menuBGColor;
    ctx.fillRect(px, py, _TextWriter.fontWidth, _TextWriter.fontHeight);
  }
  
  void MoveCursorUp() {
    if (_cursorIndex > 0) {
      clearCursor(_guiCtx);
      _cursorIndex--;
    }
  }
  
  void MoveCursorDown() {
    if (_cursorIndex < _items.length - 1) {
      clearCursor(_guiCtx);
      _cursorIndex++;
    }
  }
  
  void OnKeyboardDown(KeyboardEvent e) {
    switch (e.keyCode)
    {
      case DEF.KEYBOARD_LEFT:
        break;
      case DEF.KEYBOARD_UP:
        MoveCursorUp();
        break;
      case DEF.KEYBOARD_RIGHT:
        break;
      case DEF.KEYBOARD_DOWN:
        MoveCursorDown();
        break;
      case DEF.KEYBOARD_PRIMARY:
        if (_state == "STATE_IDLE") {
          _guiCtx.clearRect(_drawingBox.left, _drawingBox.top, _drawingBox.width, _drawingBox.height);
          _game.AddRequest(new PopRequest(_game,activateParams:{"UserSelection":_items[_cursorIndex]}));
          _game.AddRequest(new RedrawRequest(_game));
          _state = "STATE_DONE";
        }
        break;
      case DEF.KEYBOARD_SECONDARY:
        if (_allowCancel) {
          _guiCtx.clearRect(_drawingBox.left, _drawingBox.top, _drawingBox.width, _drawingBox.height);
          _game.AddRequest(new PopRequest(_game,activateParams:{"UserSelection":null}));
          _game.AddRequest(new RedrawRequest(_game));
          _state = "STATE_DONE";
        }
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