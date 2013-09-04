
part of DQ;

class Sprite 
{
  int src_x;
  int src_y;
  String src_id;
  
  Sprite({int sx, int sy, String src})
  {
    src_x = calcSrcPos(sx);
    src_y = calcSrcPos(sy);
    src_id = src;
  }
  
  int calcSrcPos(int index)
  {
    return index * 16;
  }
  
  void draw({CanvasRenderingContext2D context, int dx, int dy, int size})
  {
    ImageCache imgCache = new ImageCache();
    context.drawImageScaledFromSource(imgCache.getImageElement(src_id),
                      src_x.toDouble(),
                      src_y.toDouble(),
                      16,
                      16,
                      dx - (size >> 1),
                      dy - (size >> 1),
                      size,
                      size);
  }
  
  void drawTile({CanvasRenderingContext2D context, int dx, int dy})
  {
    ImageCache imgCache = new ImageCache();
    ImageElement img = imgCache.getImageElement(src_id);
    context.drawImageScaled(img, dx, dy, img.clientWidth*2, img.clientHeight*2);
  }
  
  String toString()
  {
    return "${src_x}:${src_y}";
  }
}
