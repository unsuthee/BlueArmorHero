part of DQ;

class TextWriter {
  
  TextWriter() {
    setupCharIndices();
  }
  
  var charIndices = {};
  String newlineChar = ";";
  
  void setupCharIndices() {
    // ** Important ** 
    // SCH: I set a semi-colon as a newline character.  
    String upperCase = r"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String lowerCase = r"abcdefghijklmnopqrstuvwxyz";
    String specialCase   = r"0123456789-'!?()*,.>/@#$:=";
    
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
  
  int padding = 1;
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
  
  void Scrolling() {
    
  }
  
  void ResetCaret() {
    
  }
  
  void HorzLine(CanvasRenderingContext2D ctx, int row) {
    var ny = _drawingRect.top + padding;
    var lastrow = MATH.max(1,row);
    ny += (fontHeight + line_space_pcx) * (lastrow-1);
    
    int step = fontWidth - 5;
    int nx = _drawingRect.left;
    while (nx + fontWidth < drawingRect.right){
      DrawChar(ctx,"-",nx,ny,scale);
      nx += step;
    }
  }
  
  int WriteByRow(CanvasRenderingContext2D ctx, String write_msg, int row) {
    var msg = write_msg.split(" ");
    var ny = _drawingRect.top + padding;
   
    var lastrow = MATH.max(1,row);  // add row offset
   
    ny += (fontHeight + line_space_pcx) * (lastrow-1);
    
    // clear the current row
    //ctx.fillStyle = "#000000";
    //ctx.fillRect(nx,ny,this._drawingRect.Width(),this.font_height + this._line_space_pcx);
    
    var nx;
    if (alignment == "Left") {
      nx = _drawingRect.left + padding;
      for (String word in msg) {
        if (_wrap) {
          var msglen_pcx = word.length * (fontWidth + char_space_pcx);
          if (nx + msglen_pcx >= _drawingRect.right) {
            nx = _drawingRect.left + padding;
            ny += ((fontHeight + line_space_pcx) * _RowSpace);
            lastrow+=_RowSpace;
          }
        }
        
        for (var c in word.split("")) {
          DrawChar(ctx,c,nx,ny,scale);
          nx += (fontWidth + char_space_pcx);
        }
        nx += (fontWidth + char_space_pcx);
      }
    }
    /**
    else if (this._alignment == "Right") {
      nx = this._drawingRect.Right() - this._paddingRect.Right();
      for (var i=0; i<msg.length; i++) {
        if (this._wrap) {
          var msglen_pcx = msg[i].length * (this.font_width + this._char_space_pcx);
          if (nx - msglen_pcx <= this._drawingRect.Left()) {
            nx = this._drawingRect.Right() - this._paddingRect.Right();
            ny += (this.font_height + this._line_space_pcx);
            lastrow++;
          }
        }
        
        for (var j=msg[i].length-1; j>=0; j--) {
          this.DrawChar(ctx,msg[i].charAt(j),nx,ny,this._scale);
          nx -= (this.font_width + this._char_space_pcx);
        }
        nx -= (this.font_width + this._char_space_pcx);
      }
    }
    **/
    return lastrow;
  }
  
  void DrawChar(CanvasRenderingContext2D ctx, String c, int x, int y, int scale ) {
    if (!charIndices.containsKey(c))
      return;
    
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
  }
}