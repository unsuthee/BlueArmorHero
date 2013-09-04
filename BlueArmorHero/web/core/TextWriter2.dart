part of DQ;

class TextWriter2 {
  
  Rect _drawingRect;
  Rect get drawingRect => _drawingRect;
  set drawingRect(Rect r) {
    _drawingRect = r;
  }
  
  // is single space, double space, or n space?
  int _RowSpace = 1;
  set RowSpace(int s) {
    _RowSpace = s;
  }
  
  int _topPadding = 5;
  int _bottomPadding = 5;
  int _leftPadding = 5;
  int _rightPadding = 5;
  set topPadding(int v) { _topPadding = v; }
  set bottomPadding(int v) { _bottomPadding = v; }
  set leftPadding(int v) { _leftPadding = v; }
  set rightPadding(int v) { _rightPadding = v; }
  int get topPadding => _topPadding;
  int get bottomPadding => _bottomPadding;
  int get leftPadding => _leftPadding;
  int get rightPadding => _rightPadding;
  
  int char_space_pcx = 1;
  
  // horizontal spacing (pixel)
  int _line_space_pcx = 2;
  int get line_space_pcx => _line_space_pcx;
  set line_space_pcx(int val) { _line_space_pcx = val; }
  
  int _scale = 1;
  int get scale => _scale;
  set scale(int val) { _scale = val; }
  
  String _alignment = "Left";
  String get alignment => _alignment;
  set alignment(String val) { _alignment = val; }
  
  bool _autoNewline = true;
  bool get AutoNewline => _autoNewline;
  set AutoNewline(bool v) { _autoNewline = v; }
  
  TextWriter2(Rect drawingRegion) {
    setupCharIndices();
    _drawingRect = drawingRegion;
    NewPage();
  }
  
  int calcMsgLength(String msg) {
    return msg.length * (fontWidth + char_space_pcx);
  }
  
  var charIndices = {};
  static const String newlineChar = ";";
  
  void setupCharIndices() {
    // ** Important ** 
    // SCH: I set a semi-colon as a newline character.  
    String upperCase = r"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String lowerCase = r"abcdefghijklmnopqrstuvwxyz";
    String specialCase   = r"0123456789-'!?()*,.>/@#~:=";
    
    int index = 0;
    for (var c in upperCase.split("")) {
      charIndices[c] = [index,0];
      index++;
    }
    index = 0;
    for (var c in lowerCase.split("")) {
      charIndices[c] = [index,1];
      index++;
    }
    index = 0;
    for (var c in specialCase.split("")) {
      charIndices[c] = [index,2];
      index++;
    }
  }
  
  bool _wrap = true;
  
  String _color;
  String get color => _color;
  set color(String val) { 
    switch(val) {
      case DEF.COLOR_YELLOW:
        _color = val;
        _fontTileIndexOffset = 3;
        break;
        
      case DEF.COLOR_RED:
        _color = val;
        _fontTileIndexOffset = 6;
        break;
        
      default:
        _color = DEF.COLOR_WHITE;
        _fontTileIndexOffset = 0;
        break;
    }
  }
  
  int _fontTileIndexOffset = 0;
  int get fontTileIndexOffset => _fontTileIndexOffset;
  
  int _fontWidth = 16;
  int _fontHeight = 16;
  int get fontWidth => _fontWidth;
  int get fontHeight => _fontHeight;
  
  // current writing position
  int _nx;
  int _ny;
  
  List<String> _msgToWrite = [];
  set MessageToWrite(String msg) { _msgToWrite = msg.split(" "); }
  // internal use
  List<String> _charToWrite = [];
  
  void Scrolling() {
  }
  
  void ResetCaret() {
    _nx = _drawingRect.left + leftPadding;
  }
  
  void Newline() {
    _ny += ((fontHeight + line_space_pcx) * _RowSpace);
  }
  
  int getPyByRow(int row) {
    int firstRow = _drawingRect.top + topPadding; 
    if (row == 0) {
      return firstRow;
    }
    return firstRow + (row * ((fontHeight + line_space_pcx) * _RowSpace));
  }
  
  int getPxByIndex(int index) {
    int firstPos = _drawingRect.left + leftPadding;
    if (index == 0) {
      return firstPos;
    }
    return firstPos + (index * (fontWidth + char_space_pcx));
    
  }
  
  void NewPage() {
    ResetCaret();
    _ny = _drawingRect.top + topPadding;
  }
  
  void HorzLine(CanvasRenderingContext2D ctx, int row) {
    var ny = _drawingRect.top + topPadding;
    var lastrow = MATH.max(1,row);
    ny += (fontHeight + line_space_pcx) * (lastrow-1);
    
    int step = fontWidth - 5;
    int nx = _drawingRect.left;
    while (nx + fontWidth < drawingRect.right){
      DrawChar(ctx,"-",nx,ny,scale);
      nx += step;
    }
  }
  
  bool isFinish() {
    return _msgToWrite.isEmpty && _charToWrite.isEmpty;
  }
  
  bool isEndPage() {
    bool isEndOfLine = (_ny + fontHeight >= _drawingRect.bottom - bottomPadding); 
    return isFinish() || isEndOfLine;
  }
  
  void WriteAll(CanvasRenderingContext2D ctx) {
    while (!isFinish()) {
      while (!isEndPage()) {
        WriteNextChar(ctx);
      }
      NewPage();
    }
  }

  void WriteNextChar(CanvasRenderingContext2D ctx) {
    if (isFinish()) {
      return;
    }
    
    if (_charToWrite.isEmpty) {
      String word = _msgToWrite[0];
      for (var c in word.split("")) {
        _charToWrite.add(c);
      }
      _charToWrite.add(" ");
      _msgToWrite.removeAt(0);
      
      var msglen_pcx = word.length * (fontWidth + char_space_pcx);
      bool isNewLine = (word.length == 1 && word == newlineChar);
      if (!isNewLine) { // We skip newline here to avoid double newline. The code below will newline.
        bool exceedLine = (_nx + msglen_pcx >= _drawingRect.right - rightPadding);
        if (exceedLine && _autoNewline) {
          ResetCaret();
          Newline();
        }
      }
    }
    if (_ny + fontHeight >= _drawingRect.bottom  - bottomPadding) {
      return; // do nothing until a user calls NewPage  
    }
    // draw one letter
    if (_charToWrite[0] == newlineChar) {
      ResetCaret();
      Newline();
    }
    else {
      DrawChar(ctx,_charToWrite[0],_nx,_ny, scale);
      _nx += (fontWidth + char_space_pcx);
    }
    _charToWrite.removeAt(0);
  }
  
  bool DrawChar(CanvasRenderingContext2D ctx, String c, int x, int y, int scale ) {
    if (!charIndices.containsKey(c))
      return false;
    
    var pos = charIndices[c];
    int px = pos[0];
    int py = pos[1] + fontTileIndexOffset;
    
    ImageCache imgCache = new ImageCache();
    ctx.drawImageScaledFromSource(
        imgCache.getImageElement("Fonts"),
        (fontWidth+1)*px+1,
        (fontHeight+1)*py+1,
        fontWidth,
        fontHeight,
        x,
        y,  
        fontWidth * scale,
        fontHeight * scale);
    
    return true;
  }
}