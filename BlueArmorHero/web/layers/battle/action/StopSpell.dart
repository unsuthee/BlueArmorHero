part of DQ;

class StopSpell extends BattleAction {
  
  Battler attacker;
  Battler defender;
  
  StopSpell(Battler atk, Battler def) {
    attacker = atk;
    defender = def;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    
    String msg1 = "${attacker.name} cast Stop.";
    String msg2;
    if (defender.HasMagicArmor) {
      msg2 = "But the magic armor prevents the effect of Stop!";
    }
    else {
      var rng = new MATH.Random();
      if (rng.nextInt(16) + 1 <= defender.StopResist) {
        msg2 = "But it does not work!";
      }
      else {
        msg2 = "${defender.name} is now not be able to cast spell!";
        defender.IsStoping = true;
      }
    }
    List<BattleTask> tasks = new List<BattleTask>();
    tasks.add(new AnnotateTask(gm,[msg1, msg2]));
    return tasks;
  }
}
