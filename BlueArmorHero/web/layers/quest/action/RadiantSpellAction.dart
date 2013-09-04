part of DQ;

class RadiantSpellAction extends QuestAction {
  
  MapLayer _map;
  
  RadiantSpellAction() {
    
  }
  
  List<BattleTask> execute(Game gm, MapLayer menu) {
    List<BattleTask> tasks = new List<BattleTask>();
    tasks.add(new AnnotateTask(gm, ["Use Radiant!"]));
    return tasks;
  }
}