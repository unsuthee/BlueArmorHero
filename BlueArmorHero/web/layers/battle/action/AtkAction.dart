part of DQ;

class HeroAtkAction extends BattleAction {
  
  Battler attacker;
  Battler defender;
  
  HeroAtkAction(Battler atk, Battler def) {
    attacker = atk;
    defender = def;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    var rng = new MATH.Random();
    bool isExcellentMove = (rng.nextInt(attacker.CritChance) == 0);
    bool canDodge = (rng.nextInt(64) + 1 <= defender.SleepResist);
    
    List<BattleTask> tasks = new List<BattleTask>();
    
    String msg;
    if (canDodge) {
      msg = "${defender.name} has dodged your attack!";
      tasks.add(new AnnotateTask(gm,[msg]));
    }
    else {
      int minDamage;
      int maxDamage;
      if (isExcellentMove) {
        minDamage = attacker.Attack ~/ 2;
        maxDamage = attacker.Attack;
      }
      else {
        minDamage = (attacker.Attack - (defender.Agility ~/ 2)) ~/ 4;
        maxDamage = (attacker.Attack - (defender.Agility ~/ 2)) ~/ 2;;
      }
      minDamage = MATH.max(0, minDamage);
      maxDamage = MATH.max(0, maxDamage);

      int range = maxDamage - minDamage;
      assert(range >= 0);
      
      int damage;
      if (range == 0) {
        damage = minDamage;
      }
      else {
        damage = rng.nextInt(range) + minDamage + 1;  
      }
      if (damage == 0) {
        damage = rng.nextInt(2);
      }
      defender.decHP(damage);
      msg = "${defender.name} took ${damage}!";
      bool isDead = (defender.HP <= 0);
      tasks.add(new BlinkMonsterTask(gm, menu, dead:isDead));
      tasks.add(new AnnotateTask(gm,[msg]));
    }
    return tasks;
  }
}

class MonsterAtkAction extends BattleAction {
  
  Battler attacker;
  Battler defender;
  
  MonsterAtkAction(Battler atk, Battler def) {
    attacker = atk;
    defender = def;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    
    var rng = new MATH.Random();
    
    int minDamage;
    int maxDamage;
    int diff = attacker.Strength - defender.Defence;
    if (diff > 0) {
      minDamage = (attacker.Strength - (defender.Defence ~/ 2)) ~/ 4;
      maxDamage = (attacker.Strength - (defender.Defence ~/ 2)) ~/ 2;
    }
    else {
      minDamage = 0;
      maxDamage = (attacker.Strength + 4) ~/ 6;
    }
    minDamage = MATH.max(0, minDamage);
    maxDamage = MATH.max(0, maxDamage);

    int damage;
    int range = maxDamage - minDamage;
    assert(range >= 0);
    
    if (range == 0) {
      damage = minDamage;
    }
    else {
      damage = rng.nextInt(range) + minDamage + 1;  
    }
    
    defender.decHP(damage);
    
    List<BattleTask> tasks = new List<BattleTask>();
    tasks.add(new ShakingScreenTask(gm, menu));
    
    String msg = "${defender.name} took ${damage}!";
    tasks.add(new AnnotateTask(gm,[msg]));
    
    return tasks;
  }
}