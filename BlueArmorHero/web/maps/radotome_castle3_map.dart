part of DQ;

class RadotomeCastle3 extends MapData {
  
  var world = const [
              const [729, 730, 731, 732, 732, 732, 731, 732, 733, 728, 728, 728, 728, 728, 728, 728, 728, 728],
              const [735, 736, 737, 738, 739, 740, 741, 742, 743, 728, 728, 728, 728, 728, 728, 728, 728, 728],
              const [735, 744, 745, 746, 747, 748, 749, 742, 743, 728, 750, 751, 752, 753, 753, 752, 754, 728],
              const [735, 736, 745, 755, 756, 757, 749, 758, 743, 728, 759, 760, 761, 762, 762, 761, 763, 728],
              const [735, 736, 745, 764, 765, 766, 749, 742, 767, 752, 768, 769, 770, 761, 771, 761, 763, 728],
              const [735, 772, 773, 774, 775, 773, 775, 770, 761, 761, 761, 771, 761, 776, 777, 771, 763, 728],
              const [735, 760, 761, 761, 771, 761, 761, 761, 778, 751, 779, 780, 761, 771, 761, 761, 763, 728],
              const [735, 772, 761, 761, 761, 761, 771, 761, 743, 728, 759, 760, 770, 761, 761, 771, 763, 728],
              const [735, 760, 771, 761, 781, 761, 761, 771, 743, 728, 782, 752, 752, 752, 752, 752, 783, 728],
              const [784, 785, 785, 785, 785, 785, 785, 785, 786, 728, 728, 728, 728, 728, 728, 728, 728, 728],
              ];
  
  int _maxPX;
  int _maxPY;
  int _srcTileSize = 16;
  int _defaultTileId = 728;
  int _tilePerRow = 20;
  
  RadotomeCastle3() {
    _maxPX = world[0].length;
    _maxPY = world.length;
  }
  
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