part of DQ;

class OutsideSpellAction extends QuestAction {
  
  MapLayer _map;
  
  OutsideSpellAction() {
    
  }
  
  List<BattleTask> execute(Game gm, MapLayer menu) {
    List<BattleTask> tasks = new List<BattleTask>();
    tasks.add(new AnnotateTask(gm, ["Cast outside!"]));
    return tasks;
  }
}