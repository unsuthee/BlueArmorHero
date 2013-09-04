part of DQ;

class HerbItemAction extends QuestAction {
  
  MapLayer _map;
  
  HerbItemAction() {
    
  }
  
  List<BattleTask> execute(Game gm, MapLayer menu) {
    List<BattleTask> tasks = new List<BattleTask>();
    tasks.add(new AnnotateTask(gm, ["Use Herb!"]));
    return tasks;
  }
}