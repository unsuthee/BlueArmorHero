part of DQ;
/**
Hero spells have different ranges than enemy spells.

    HURT does  5 - 12 damage
HURTMORE does 58 - 65 damage

SLEEP effectiveness depends on the enemy's SLEEP resist stat.  You're always
guaranteed one turn of attack, and after that turn it is a 1/3 chance that the
enemy will wake up.

STOPSPELL effectiveness depends on the enemy's STOPSPELL resist stat.  It never
loses its effect.
**/

class HeroHurtSpell extends BattleAction {
  
  Battler attacker;
  Battler defender;
  bool _isHurtMore;
  
  HeroHurtSpell(Battler atk, Battler def, {bool hurtMore:false}) {
    attacker = atk;
    defender = def;
    _isHurtMore = hurtMore;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    
    List<BattleTask> tasks = new List<BattleTask>();
    
    var rng = new MATH.Random();
    if (rng.nextInt(16) + 1 <= defender.HurtResist) {
      // this spell has no effect
      tasks.add(new AnnotateTask(gm,["Spell has no effect on ${defender.name}"]));
    }
    else {
      int minDamage;
      int maxDamage;
      if (_isHurtMore) {
        minDamage = 58;
        maxDamage = 65;
      }
      else {
        minDamage = 5;
        maxDamage = 12;
      }
      int range = maxDamage - minDamage;
      int damage = rng.nextInt(range) + minDamage + 1;
      defender.decHP(damage);
      
      bool isDead = (defender.HP <= 0);
      
      String spellName = (_isHurtMore)? "HurtMore": "Hurt";
      String msg1 = "${attacker.name} cast ${spellName}.";
      String msg2 = "${defender.name} took ${damage}!";
      tasks.add(new AnnotateTask(gm,[msg1]));
      tasks.add(new BlinkMonsterTask(gm, menu, dead:isDead));
      tasks.add(new AnnotateTask(gm,[msg2]));
    }
    return tasks;
  }
}

class MonsterHurtSpell extends BattleAction {
  
  Battler attacker;
  Battler defender;
  bool _isHurtMore;
  
  MonsterHurtSpell(Battler atk, Battler def, {bool hurtMore:false}) {
    attacker = atk;
    defender = def;
    _isHurtMore = hurtMore;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    
    var rng = new MATH.Random();
    
    int minDamage;
    int maxDamage;
    if (defender.HasMagicArmor) {
      if (_isHurtMore) {
        minDamage = 20;
        maxDamage = 30;
      }
      else {
        minDamage = 2;
        maxDamage = 6;
      }
    }
    else {
      if (_isHurtMore) {
        minDamage = 30;
        maxDamage = 45;
      }
      else {
        minDamage = 3;
        maxDamage = 10;
      }
    }
    int range = maxDamage - minDamage;
    int damage = rng.nextInt(range) + minDamage + 1;
    defender.decHP(damage);
    
    List<BattleTask> tasks = new List<BattleTask>();
    String spellName = (_isHurtMore)? "HurtMore": "Hurt";
    String msg1 = "${attacker.name} cast ${spellName}.";
    String msg2 = "${defender.name} took ${damage}!";
    tasks.add(new AnnotateTask(gm,[msg1]));
    tasks.add(new ShakingScreenTask(gm, menu));
    tasks.add(new AnnotateTask(gm,[msg2]));
    return tasks;
  }
}