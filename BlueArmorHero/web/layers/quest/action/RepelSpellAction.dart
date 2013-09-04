part of DQ;

class RepelSpellAction extends QuestAction {
  
  MapLayer _map;
  
  RepelSpellAction() {
    
  }
  
  List<BattleTask> execute(Game gm, MapLayer menu) {
    List<BattleTask> tasks = new List<BattleTask>();
    tasks.add(new AnnotateTask(gm, ["Cast Repel!"]));
    return tasks;
  }
}