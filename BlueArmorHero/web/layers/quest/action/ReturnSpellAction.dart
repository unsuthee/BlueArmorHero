part of DQ;

class ReturnSpellAction extends QuestAction {
  
  MapLayer _map;
  
  ReturnSpellAction() {
    
  }
  
  List<BattleTask> execute(Game gm, MapLayer menu) {
    List<BattleTask> tasks = new List<BattleTask>();
    tasks.add(new AnnotateTask(gm, ["Cast Return!"]));
    return tasks;
  }
}