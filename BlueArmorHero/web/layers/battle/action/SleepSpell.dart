part of DQ;

class SleepSpell extends BattleAction {
  
  Battler attacker;
  Battler defender;
  
  SleepSpell(Battler atk, Battler def) {
    attacker = atk;
    defender = def;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    
    String msg1 = "${attacker.name} cast Sleep.";
    String msg2;
    var rng = new MATH.Random();
    if (rng.nextInt(16) + 1 <= defender.SleepResist) {
      // this spell has no effect
      msg2 = "But it does not work!";
    }
    else {
      msg2 = "${defender.name} is falling into sleep!";
      defender.IsSleeping = true;
    }
    List<BattleTask> tasks = new List<BattleTask>();
    tasks.add(new AnnotateTask(gm,[msg1, msg2]));
    return tasks;
  }
}

class FairyFluteItem extends BattleAction {
  
  Battler attacker;
  Battler defender;
  
  FairyFluteItem(Battler atk, Battler def) {
    attacker = atk;
    defender = def;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    
    String msg1 = "${attacker.name} is using Fairy flute.";
    String msg2;
    if (defender.IsGolem) {
      msg2 = "${defender.name} is falling into sleep!";  
      defender.IsSleeping = true;
    }
    else {
      msg2 = "But nothing happens!";
    }
    List<BattleTask> tasks = new List<BattleTask>();
    tasks.add(new AnnotateTask(gm,[msg1, msg2]));
    return tasks;
  }
}