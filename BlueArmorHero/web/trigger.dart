part of DQ;

// Trigger
abstract class Trigger {
  
  String _key;
  String get key => _key;
  
  Trigger(String key) {
    _key = key;
  }

  void execute(Game gm);
}

class EnterTownTrigger extends Trigger {
  
  String _townName;
  
  EnterTownTrigger(String key, {String townName}): super(key) {
    _townName = townName;
  }
  
  void execute(Game gm) {
    assert(gm != null);
    
    MapData mapInstance = MapData.createMapByName(_townName);
    assert(mapInstance != null);
    
    gm.AddRequest(new PushRequest(gm, new MapLayer( gm, mapInstance)));
  }
}

class ExitTownTrigger extends Trigger {
  
  String _townName;
  
  ExitTownTrigger(String key, {String townName}): super(key) {
    _townName = townName;
  }
  
  void execute(Game gm) {
    assert(gm != null);
    gm.AddRequest(new PopRequest(gm));
  }
}
