part of DQ;

abstract class MapData {
  
  MapData() {
  }
  
  int getTileIdByPos(int px, int py);
  int getImageSrcPx(int tileId);
  int getImageSrcPy(int tileId);
  
  int getSrcTileSize();
  String getSrcImageName();
  
  //@Todo : need to set to nothing 
  int getInitPosX() => 50;
  int getInitPosY() => 35;
  
  Map<String,Trigger> getTriggeMap() => null;
  List<Thing> getNPC(Game gm) => [];
  
  bool isPassable(int tileId) {
    return true;
  }
  
  bool hasEncounter() {
    return false;
  }
  
  String getThemeMusic() {
    return "";
  }
  
  void AddTriggerByRange(Map<String,Trigger> triggerContainer, Rect range, Trigger trigger) {
    for (int c=range.left; c<=range.right; c++) {
      for (int r=range.top; r<=range.bottom; r++) {
        triggerContainer["${c}:${r}"] = trigger;
      }
    }
  }
  
  static MapData createMapByName(String mapName) {
    MapData newMap = null;
    switch(mapName) {
      case "DomdoraTown":
        break;
      case "GaraiTown":
        break;
      case "MairaTown":
        break;
      case "MercadoTown1":
        break;
      case "MercadoTown2":
        break;
      case "MercadoTown3":
        break;
      case "Overworld":
        break;
      case "RadotomeCastle1":
        newMap = new RadotomeCastle1();
        break;
      case "RadotomeCastle2":
        newMap = new RadotomeCastle2();
        break;
      case "RadotomeCastle3":
        break;
      case "RadotomeTown":
        newMap = new RadotomeTown();
        break;
      case "RimuldarTown":
        break;
    }
    return newMap;
  }
}