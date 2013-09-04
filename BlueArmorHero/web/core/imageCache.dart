part of DQ;

class ImageCache 
{
  static final ImageCache _imgCache = new ImageCache._internal();
  static Map<String,ImageElement> _imgs = null;
  static const String _imgPath = "characters.png";
  
  factory ImageCache()
  {
    if (_imgs == null)
    {
      _imgs = new Map<String,ImageElement>();
    }
    return _imgCache;
  }

  void setImageElement(String name, ImageElement instance) {
    _imgs[name] = instance;
  }
  
  ImageElement getImageElement(String name) {
    return _imgs[name];
  }

  ImageCache._internal();
}
