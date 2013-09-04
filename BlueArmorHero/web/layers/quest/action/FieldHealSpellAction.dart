part of DQ;

class FieldHealSpellAction extends QuestAction {
  
  MapLayer _map;
  bool _healMore;
  
  FieldHealSpellAction({bool healMore:false}) {
    _healMore = healMore;
  }
  
  List<BattleTask> execute(Game gm, MapLayer menu) {
    List<BattleTask> tasks = new List<BattleTask>();
    String spellname = (_healMore)? "HealMore": "Heal";
    tasks.add(new AnnotateTask(gm, ["Cast ${spellname}!"]));
    return tasks;
  }
}