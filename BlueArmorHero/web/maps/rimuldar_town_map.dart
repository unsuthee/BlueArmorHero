part of DQ;

class RimuldarTown extends MapData {
  
  var world = const [
const [550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550],
const [550, 550, 550, 550, 893, 893, 893, 893, 893, 893, 893, 893, 893, 893, 893, 893, 893, 893, 893, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550],
const [550, 550, 893, 894, 139, 130, 130, 130, 130, 897, 897, 897, 897, 897, 897, 897, 897, 897, 152, 899, 893, 893, 893, 550, 550, 550, 550, 550, 550, 550, 550, 550],
const [550, 675, 482, 897, 902, 903, 904, 905, 906, 556, 908, 908, 908, 871, 871, 871, 871, 865, 911, 897, 897, 897, 152, 899, 893, 893, 550, 550, 550, 550, 550, 550],
const [550, 894, 912, 913, 913, 914, 915, 916, 914, 562, 557, 557, 893, 893, 893, 893, 893, 893, 919, 919, 919, 920, 911, 897, 897, 152, 899, 893, 893, 550, 550, 550],
const [675, 482, 921, 922, 923, 924, 925, 913, 914, 562, 557, 557, 926, 926, 926, 926, 926, 926, 926, 926, 926, 927, 908, 871, 865, 911, 897, 897, 152, 651, 550, 550],
const [675, 458, 864, 914, 925, 913, 913, 913, 914, 562, 903, 931, 932, 933, 934, 931, 932, 935, 906, 936, 926, 651, 550, 550, 550, 871, 908, 920, 458, 899, 550, 550],
const [675, 458, 651, 937, 931, 938, 938, 933, 939, 561, 914, 925, 913, 913, 914, 925, 913, 941, 914, 942, 926, 651, 550, 903, 904, 905, 905, 906, 911, 152, 651, 550],
const [675, 458, 651, 914, 925, 913, 913, 913, 914, 561, 914, 943, 913, 913, 914, 943, 913, 913, 914, 942, 926, 651, 550, 914, 925, 913, 913, 914, 944, 458, 651, 550],
const [675, 458, 651, 945, 946, 946, 946, 946, 947, 561, 914, 948, 913, 913, 914, 948, 913, 913, 914, 942, 926, 949, 550, 950, 951, 938, 933, 939, 942, 458, 651, 550],
const [675, 458, 651, 550, 550, 550, 550, 550, 893, 893, 945, 946, 946, 946, 952, 946, 946, 946, 947, 942, 926, 926, 926, 913, 913, 913, 913, 914, 942, 458, 651, 550],
const [675, 458, 651, 550, 550, 893, 893, 894, 139, 140, 557, 557, 557, 550, 893, 893, 954, 893, 893, 894, 926, 955, 956, 922, 923, 913, 913, 914, 942, 458, 899, 550],
const [675, 458, 651, 557, 894, 482, 897, 897, 957, 438, 140, 557, 557, 959, 926, 926, 926, 926, 926, 926, 926, 651, 550, 914, 925, 913, 913, 914, 960, 911, 152, 651],
const [675, 458, 961, 894, 482, 921, 955, 908, 920, 446, 963, 651, 959, 926, 926, 926, 926, 926, 926, 926, 926, 651, 550, 945, 946, 946, 946, 947, 562, 920, 458, 651],
const [675, 458, 964, 965, 966, 955, 550, 550, 959, 458, 864, 894, 926, 926, 926, 864, 871, 871, 865, 926, 926, 899, 893, 893, 893, 893, 954, 954, 954, 959, 458, 651],
const [675, 458, 967, 968, 912, 550, 550, 959, 482, 921, 969, 926, 926, 926, 864, 550, 557, 550, 675, 926, 926, 926, 926, 926, 926, 926, 926, 926, 926, 926, 970, 550],
const [675, 458, 964, 965, 966, 949, 959, 482, 921, 864, 675, 926, 926, 864, 550, 557, 557, 557, 675, 926, 926, 926, 926, 926, 926, 926, 926, 926, 926, 926, 971, 550],
const [675, 458, 972, 865, 911, 897, 897, 921, 864, 550, 675, 926, 926, 651, 973, 557, 557, 922, 974, 926, 864, 871, 871, 871, 871, 871, 871, 908, 908, 920, 458, 651],
const [675, 458, 651, 557, 871, 871, 871, 871, 973, 550, 675, 926, 926, 651, 975, 976, 903, 977, 951, 932, 903, 904, 905, 934, 978, 905, 905, 906, 556, 675, 458, 651],
const [675, 458, 651, 550, 550, 550, 550, 979, 980, 976, 675, 926, 926, 651, 981, 982, 914, 925, 938, 925, 924, 925, 913, 914, 983, 913, 984, 914, 561, 675, 458, 651],
const [675, 458, 651, 903, 904, 905, 905, 905, 905, 905, 951, 932, 985, 922, 555, 987, 937, 904, 951, 925, 913, 913, 913, 924, 925, 913, 988, 914, 561, 894, 458, 651],
const [675, 458, 651, 914, 925, 913, 913, 913, 913, 913, 913, 913, 913, 914, 561, 550, 914, 925, 913, 913, 913, 913, 913, 913, 913, 913, 913, 914, 942, 482, 921, 651],
const [675, 458, 651, 914, 989, 990, 913, 913, 913, 903, 904, 905, 905, 939, 561, 550, 914, 925, 913, 913, 903, 904, 951, 991, 903, 904, 905, 939, 960, 458, 864, 550],
const [675, 458, 651, 914, 992, 993, 913, 913, 988, 914, 97, 97, 97, 914, 561, 550, 914, 925, 913, 913, 914, 925, 913, 995, 924, 925, 996, 914, 960, 458, 651, 550],
const [675, 458, 651, 914, 925, 997, 913, 913, 988, 914, 97, 998, 97, 914, 561, 999, 914, 925, 913, 913, 914, 1000, 1001, 913, 991, 913, 1002, 914, 482, 921, 651, 550],
const [675, 458, 899, 914, 992, 993, 913, 913, 988, 914, 97, 97, 97, 914, 561, 1003, 945, 946, 946, 946, 952, 946, 946, 946, 1004, 946, 946, 947, 458, 864, 550, 550],
const [675, 911, 152, 914, 989, 990, 913, 913, 913, 950, 905, 905, 905, 939, 562, 1005, 1006, 1006, 1007, 557, 550, 893, 893, 894, 482, 897, 897, 897, 921, 651, 550, 550],
const [550, 865, 458, 914, 925, 913, 913, 913, 913, 913, 913, 913, 913, 914, 562, 557, 550, 550, 954, 893, 894, 482, 897, 897, 921, 864, 871, 871, 871, 550, 550, 550],
const [550, 675, 156, 945, 946, 946, 946, 946, 946, 946, 946, 946, 946, 947, 1009, 954, 954, 959, 482, 897, 897, 921, 864, 871, 871, 550, 550, 550, 550, 550, 550, 550],
const [550, 550, 871, 675, 965, 897, 897, 897, 897, 897, 897, 897, 897, 897, 897, 897, 897, 897, 921, 864, 871, 871, 550, 550, 550, 550, 550, 550, 836, 836, 550, 550],
const [550, 550, 550, 550, 871, 871, 871, 871, 871, 871, 871, 871, 871, 871, 871, 871, 871, 871, 871, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 836, 836, 550]
];
  
  RimuldarTown() {
    _maxPX = world[0].length;
    _maxPY = world.length;
  }
  
  int _maxPX;
  int _maxPY;
  int _srcTileSize = 16;
  int _defaultTileId = 550;
  int _tilePerRow = 20;
  
  int getInitPosX() => 20;
  int getInitPosY() => 8;
  
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