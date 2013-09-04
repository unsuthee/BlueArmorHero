part of DQ;

/**
 * 

Hero: Certain groups of monsters have higher chances of blocking your running.
The more difficult an enemy is, it may belong to a group that is better at
blocking.

Group 1: #00 (Slime) - #19 (Druinlord)
Group 2: #20 (Drollmagi) - #29 (Werewolf)
Group 3: #30 (Green Dragon) - #34 (Blue Dragon)
Group 4: #35 (Stoneman) - #39 (Dragonlord second form)

So for instance, group 4 will block you much easier than group 1 will.  On top
of that is a test of agility.  The test goes like this:

If HeroAgility * Random # < EnemyAgility * Random # * GroupFactor, then the
enemy will block you.

Random # is a random number between 0 and 255.

GroupFactor depends on the group:

Group 1: 0.25
Group 2: 0.375
Group 3: 0.5
Group 4: 1.0

So you can see that enemies in group 1 are going to have a much lower product
than enemies in group 4, meaning that it will be more likely that your product
will be higher and that you will get away.


And yes, it is possible to run from the Dragonlord, although you will repeat
the same dialog and have to fight the first form again.  You can also run from
the Axe Knight in Hauksness, the Golem outside Cantlin, and the Green Dragon in
the Marsh Cave, but it will put you back a spot so that you can't just skip
them and get their prize.

Also worth noting is that if the monster is asleep, you can run away every
time.
 * 
 */
class HeroFleeAction extends BattleAction {
  
  Battler attacker;
  Battler defender;
  
  HeroFleeAction(Battler atk, Battler def) {
    attacker = atk;
    defender = def;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    bool canMonsBlock = false;
    
    if (!defender.IsSleeping) {
      var rng = new MATH.Random();
      int atkOdd = rng.nextInt(255);
      int defOdd = rng.nextInt(255);
      if (attacker.Agility * atkOdd < defender.Agility * defOdd * defender.GroupFactor) {
        canMonsBlock = true;
      }
    }
    
    List<BattleTask> tasks = new List<BattleTask>();
    String msg1;
    if (canMonsBlock) {
      msg1 = "${attacker.name} tried to run away but was blocked!";
    }
    else {
      msg1 = "${attacker.name} has ran away from the battle!";
      attacker.IsFlee = true;
    }
    
    tasks.add(new AnnotateTask(gm,[msg1]));
    return tasks;
  }
}

/**
 * Enemy: If your strength is two times the enemy's strength or more, there is a
25% chance the enemy will run when it's given a turn.  The enemy also makes
this check right upon encounter, so he may get a chance to run right away
regardless of initiative.
 */

class MonsterFleeAction extends BattleAction {
  
  Battler attacker;
  Battler defender;
  
  MonsterFleeAction(Battler atk, Battler def) {
    attacker = atk;
    defender = def;
  }
  
  List<BattleTask> execute(Game gm, battleMenu menu) {
    bool fleeSuccess = false;
    
    var rng = new MATH.Random();
    if (defender.Strength >= (attacker.Strength * 2)) {
      fleeSuccess = (rng.nextInt(100) < 25);  // 25% chance
    }
    
    List<BattleTask> tasks = new List<BattleTask>();
    String msg1;
    if (!fleeSuccess) {
      msg1 = "${attacker.name} tried to run away but was blocked!";
    }
    else {
      msg1 = "${attacker.name} has ran away from the battle!";
      attacker.IsFlee = true;
    }
    
    tasks.add(new AnnotateTask(gm,[msg1]));
    return tasks;
  }
}