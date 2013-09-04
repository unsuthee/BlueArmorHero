part of DQ;

class MercadoTown3 extends MapData {
  
  var world = const [
const [517, 518, 519, 519, 520],
const [521, 372, 373, 373, 543],
const [521, 372, 544, 373, 545],
const [521, 372, 373, 373, 546],
const [547, 548, 548, 548, 549],
];
  
  MercadoTown3() {
    _maxPX = world[0].length;
    _maxPY = world.length;
  }
  
  int _maxPX;
  int _maxPY;
  int _srcTileSize = 16;
  int _defaultTileId = 728;
  int _tilePerRow = 20;
  
  int getSrcTileSize() {
    return _srcTileSize;
  }
  
  String getSrcImageName() {
    return "TownImage";
  }
  
  int getTileIdByPos(int px, int py) {
    if (px >= 0 && px < _maxPX && py >= 0 && py < _maxPY) {
      return world[py][px];
    }
    return _defaultTileId;
  }
  
  int getImageSrcPx(int tileId) {
    return (tileId % _tilePerRow).toInt() * _srcTileSize;
  }
  
  int getImageSrcPy(int tileId) {
    return (tileId / _tilePerRow).toInt() * _srcTileSize;  
  }
  
}