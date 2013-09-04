part of DQ;

/**
 * There are two types of fire breath.  Only the Dragonlord's second form has the
stronger breath.  The rest of the enemies that have breath attacks only have
the weaker type of breath.

  Weak breath does 16 - 23 damage
Strong breath does 65 - 72 damage

The only thing that protects against fire breath is Erdrick's Armor, which
reduces the damage by 1/3.  So:

  Weak breath vs. Erdrick's Armor does 10 - 14 damage
Strong breath vs. Erdrick's Armor does 42 - 48 damage
 */

class FireBreathSpell extends BattleAction {
  
  Battler attacker;
  Battler defender;
  bool _isStrong;
  
  FireBreathSpell(Battler atk, Battler def, {bool isStrong:false}) {
    attacker = atk;
    defender = def;
    _isStrong = isStrong;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    
    var rng = new MATH.Random();
    int minDamage;
    int maxDamage;
    if (defender.HasMagicArmor) {
      if (_isStrong) {
        minDamage = 42;
        maxDamage = 48;
      }
      else {
        minDamage = 10;
        maxDamage = 14;
      }
    }
    else {
      if (_isStrong) {
        minDamage = 65;
        maxDamage = 72;
      }
      else {
        minDamage = 16;
        maxDamage = 23;
      }
    }
    int range = maxDamage - minDamage;
    int damage = rng.nextInt(range) + minDamage + 1;
    print("Damage = ${damage}");
    defender.decHP(damage);
    
    List<BattleTask> tasks = new List<BattleTask>();
    String spellName = (_isStrong)? "Strong FireBreath": "FireBreath";
    String msg1 = "${attacker.name} cast ${spellName}.";
    String msg2 = "${defender.name} took ${damage}!";
    tasks.add(new ShakingScreenTask(gm, menu));
    tasks.add(new AnnotateTask(gm,[msg1, msg2]));
    return tasks;
  }
}
