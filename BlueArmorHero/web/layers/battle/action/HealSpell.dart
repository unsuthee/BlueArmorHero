part of DQ;

/**
 *     HEAL recovers 20 - 27 HP
    HEALMORE recovers 85 - 100 HP
 */
class HealSpell extends BattleAction {
  
  Battler attacker;
  Battler defender;
  bool _healMore;
  
  HealSpell(Battler atk, Battler def, {bool healMore:false}) {
    attacker = atk;
    defender = def;
    _healMore = healMore;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    
    var rng = new MATH.Random();
    
    int minDamage;
    int maxDamage;
    if (_healMore) {
      minDamage = 85;
      maxDamage = 100;
    }
    else {
      minDamage = 20;
      maxDamage = 27;
    }
    int range = maxDamage - minDamage;
    int damage = rng.nextInt(range) + minDamage + 1;
    print("Heal = ${damage}");
    defender.decHP(-1 * damage);
    
    List<BattleTask> tasks = new List<BattleTask>();
    String spellName = (_healMore)? "HealMore": "Heal";
    String msg1 = "${attacker.name} cast ${spellName}.";
    String msg2 = "${attacker.name} healed ${damage} HP!";
    tasks.add(new AnnotateTask(gm,[msg1, msg2]));
    return tasks;
  }
}

class HerbItem extends BattleAction {
  
  Battler attacker;
  Battler defender;
  bool _healMore;
  
  HerbItem(Battler atk, Battler def) {
    attacker = atk;
    defender = def;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    
    var rng = new MATH.Random();
    
    int minDamage = 20;
    int maxDamage = 35;
    int range = maxDamage - minDamage;
    int damage = rng.nextInt(range) + minDamage + 1;
    print("Heal = ${damage}");
    attacker.decHP(-1 * damage);
    
    List<BattleTask> tasks = new List<BattleTask>();
    String msg1 = "${attacker.name} uses Herb.";
    String msg2 = "${attacker.name} healed ${damage} HP!";
    tasks.add(new AnnotateTask(gm,[msg1, msg2]));
    return tasks;
  }
}