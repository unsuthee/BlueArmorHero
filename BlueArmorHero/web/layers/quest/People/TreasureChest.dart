part of DQ;

class TreasureChest extends Thing {
  
  bool _isClosed;
  int spritePosX;
  int spritePosY;
  int _size;
  
  static int chestOpenSpriteSX = 0;
  static int chestOpenSpriteSY = 0;
  static int chestCloseSpriteSX = 1;
  static int chestCloseSpriteSY = 0;
  
  static String src_id = "TileSet";
  
  TreasureChest(  Game game, 
      { int px:0, 
        int py:0, 
        int size:DEF.TILE_SIZE,
        bool isClosed: true,
        OnTalkHandler talkHandler:null}): super(game,px.toDouble(),py.toDouble()) 
  {
    _isClosed = isClosed;
    _size = size;
    
    setSprite(_isClosed);
  }
  
  int calcSrcPos(int index)
  {
    return index * 17 + 1;
  }
  
  void setSprite(bool isClosed) {
    if (isClosed) {
      spritePosX = calcSrcPos(chestOpenSpriteSX);
      spritePosY = calcSrcPos(chestOpenSpriteSY);
    }
    else {
      spritePosX = calcSrcPos(chestCloseSpriteSX);
      spritePosY = calcSrcPos(chestCloseSpriteSY);
    }
  }
  
  void draw(CanvasRenderingContext2D ctx, {int px, int py}) {

    ImageCache imgCache = new ImageCache();
    ctx.drawImageScaledFromSource(imgCache.getImageElement(src_id),
                      spritePosX.toDouble(),
                      spritePosY.toDouble(),
                      16,
                      16,
                      px - (_size >> 1),
                      py - (_size >> 1),
                      _size,
                      _size);
  }
  
  void update(num delta) {
  }
  
  void OnTalkBegin(Game gm, HeroSprite talker) {
    if (_isClosed) {
      _isClosed = false;
      setSprite(_isClosed);
      gm.AddRequest(new RedrawRequest(gm));
      gm.AddRequest(new PushRequest(gm, new MsgBox(gm,"There is nothing.")));
    }
  }
}