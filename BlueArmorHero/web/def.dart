part of DQ;

class DEF {
  static const int NO_DIRECTION = 0;
  static const int NORTH = 1;
  static const int SOUTH = 2;
  static const int EAST  = 3;
  static const int WEST  = 4;
  
  static const int DIR_LEFT = WEST;
  static const int DIR_RIGHT = EAST;
  static const int DIR_UP = NORTH;
  static const int DIR_DOWN = SOUTH;
  
  static const int TILE_SIZE = 32;
  static const int HALF_TILE_SIZE = TILE_SIZE >> 1;
  static const int QUARTER_TILE_SIZE = TILE_SIZE >> 2;
  
  static const int SCREEN_WIDTH_PCX = 640;
  static const int SCREEN_HEIGHT_PCX = 480;
  static const int SCREEN_HALF_WIDTH_PCX = SCREEN_WIDTH_PCX >> 1;
  static const int SCREEN_HALF_HEIGHT_PCX = SCREEN_HEIGHT_PCX >> 1;
  
  static const String menuBGColor = "#222222";
  static const String menuBorderColor = "#EEEEEE";
  
  static const String COLOR_WHITE = "#EEEEEE";
  static const String COLOR_YELLOW = "#EEEE00";
  static const String COLOR_RED = "#EE0000";
  
  static const num CURSOR_BLINKING_DURATION = 250;
  
  static const bool NO_ENCOUNTER = true;
  
  static int OppositeDirection(int direction)
  {
    switch (direction)
    {
      case NORTH:
        return SOUTH;
      case SOUTH:
        return NORTH;
      case EAST:
        return WEST;
      case WEST:
        return EAST;
      default:
        return NO_DIRECTION;
    }
  }
  
  static int StringToDirection(String directionStr)
  {
    switch (directionStr)
    {
      case "NORTH":
        return DEF.NORTH;
      case "SOUTH":
        return DEF.SOUTH;
      case "EAST":
        return DEF.EAST;
      case "WEST":
        return DEF.WEST;
      default:
        return DEF.NO_DIRECTION;
    }
  }
  
  static const int KEYBOARD_LEFT = 37;
  static const int KEYBOARD_UP = 38;
  static const int KEYBOARD_RIGHT = 39;
  static const int KEYBOARD_DOWN = 40;
  static const int KEYBOARD_PRIMARY = 88; // x
  static const int KEYBOARD_SECONDARY = 67; // c
  static const int KEYBOARD_ATL_1 = 83; // s
  static const int KEYBOARD_ATL_2 = 68; // d
}