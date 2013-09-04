part of DQ;

class MonsterStats {
  
  static const List MonsterZone = const [ const [3,  3,  2,  2,  3,  5,  4,  5],
                                          const [3,  2,  1,  2,  3,  3,  4,  5],
                                          const [4,  1,  0,  0,  1,  3,  4,  5],
                                          const [5,  1,  1, 12,  9,  6,  6,  6],
                                          const [5,  5,  4, 12, 12,  7,  7,  7],
                                          const [10,  9,  8, 12, 12, 12, 8,  7],
                                          const [10, 10, 11, 12, 13, 13,  9,  8],
                                          const [11, 11, 12, 13, 13, 12,  9,  9]];
  
  static int getZoneByPos(int x, int y) {
    if (x >=0 && y >= 0 && y < MonsterZone.length && x < MonsterZone[0].length) {
      return MonsterZone[y][x];
    }
    return 0;
  }
  
  static const List MonsterByZone = const [ const ["M_Slimer", "M_RedSlimer", "M_Slimer", "M_RedSlimer", "M_Slimer"],
                                            const ["M_RedSlimer", "M_Slimer", "M_RedSlimer", "M_Drakeer", "M_RedSlimer"],
                                            const ["M_Slimer", "M_Ghost", "M_Drakeer", "M_Ghost", "M_RedSlimer"], 
                                            const ["M_RedSlimer", "M_RedSlimer", "M_Drakeer", "M_Ghost", "M_Magician"],
                                            const ["M_Ghost", "M_Magician", "M_Magidrakeer", "M_Magidrakeer", "M_Scorpionr"],
                                            const ["M_Ghost", "M_Magician", "M_Magidrakeer", "M_Scorpionr", "M_Skeletonr"],
                                            const ["M_Magidrakeer", "M_Scorpionr", "M_Skeletonr", "M_Warlockr", "M_Wolfr"],
                                            const ["M_Skeletonr", "M_Warlockr", "M_MetalScorpionr", "M_Wolfr", "M_Wolfr"]];
  
  static List getMonsterByZone(int zoneId) {
    if (zoneId >= 0 && zoneId < MonsterByZone.length) {
      return MonsterByZone[zoneId];
    }
    return MonsterByZone[0];
  }
  
  /**
   * 
Zone  1: 
Zone  2: 
Zone  3: 
Zone  4: 
Zone  5: 
Zone  6: 
Zone  7: 
Zone  8: Metal Scorpion, Wraith, Wolflord, Wolflord, Goldman
Zone  9: Wraith, Wyvern, Wolflord, Wyvern, Goldman
Zone 10: Wyvern, Rogue Scorpion, Wraith Knight, Knight, Demon Knight
Zone 11: Wraith Knight, Knight, Magiwyvern, Demon Knight, Metal Slime
Zone 12: Knight, Magiwyvern, Demon Knight, Werewolf, Starwyvern
Zone 13: Werewolf, Green Dragon, Starwyvern, Starwyvern, Wizard
Zone 14: Poltergeist, Droll, Drakeema, Skeleton, Warlock
Zone 15: Specter, Wolflord, Druinlord, Drollmagi, Wraith Knight
Zone 16: Werewolf, Green Dragon, Starwyvern, Wizard, Axe Knight
Zone 17: Wizard, Axe Knight, Blue Dragon, Blue Dragon, Stoneman
Zone 18: Wizard, Stoneman, Armored Knight, Armored Knight, Red Dragon
Zone 19: Ghost, Magician, Scorpion, Druin, Druin
   * 
   */
  
  // Todo: Move to somewhere else
  static Battler createMonsterBattler(String name) {
    switch(name) {
      case "M_Slimer":
        return new Battler("Slime", 
            STR:5, 
            AGI:3, 
            Dodge:1, 
            Exp: 1, 
            Gp: 1,
            Hp:3, 
            Mp:0,
            hurtResist: 0, 
            stopResist: 15, 
            sleepResist: 0, 
            grpFactor: 0.25);
         
      case "M_RedSlimer":
        return new Battler("Red Slime", 
            STR:7, 
            AGI:3, 
            Dodge:1, 
            Exp: 1, 
            Gp: 2,
            Hp:4, 
            Mp:0,
            hurtResist: 0, 
            stopResist: 15, 
            sleepResist: 0, 
            grpFactor: 0.25);
         
      case "M_Drakeer":
        return new Battler("Drakee", 
            STR:9, 
            AGI:6, 
            Dodge:1, 
            Exp: 2, 
            Gp: 2,
            Hp:5, // 5-6 
            Mp:0,
            hurtResist: 0, 
            stopResist: 15, 
            sleepResist: 0, 
            grpFactor: 0.25);
         
      case "M_Ghost":
        return new Battler("Ghost", 
            STR:11, 
            AGI:8, 
            Hp:6, //6-7 
            sleepResist: 0, 
            stopResist: 15, 
            hurtResist: 0, 
            Dodge:4, 
            Exp: 3, 
            Gp: 3, // 3 - 4
            grpFactor: 0.25);

      case "M_Magician":
        return new Battler("Magician", 
            STR:11, 
            AGI:12, 
            Hp:10, //10-13 
            sleepResist: 0, 
            stopResist: 0, 
            hurtResist: 0, 
            Dodge:1, 
            Exp: 4, 
            Gp: 9, // 9 -11
            grpFactor: 0.25,
            getActionHandler:(Battler atk, Battler def) {
              if (!atk.IsStoping) {
                var rng = new MATH.Random();
                if (rng.nextInt(100) < 50) {
                  return new MonsterHurtSpell(atk,def);
                }
              }
              return new MonsterAtkAction(atk,def);
            });

      case "M_Magidrakeer":
        return new Battler("Magidrakee", 
            STR:14, 
            AGI:14, 
            Hp:12, //12-15
            sleepResist: 0, 
            stopResist: 0, 
            hurtResist: 0, 
            Dodge:1, 
            Exp: 5, 
            Gp: 9, // 9 -11
            grpFactor: 0.25,
            getActionHandler:(Battler atk, Battler def) {
              if (!atk.IsStoping) {
                var rng = new MATH.Random();
                if (rng.nextInt(100) < 50) {
                  return new MonsterHurtSpell(atk,def);
                }
              }
              return new MonsterAtkAction(atk,def);
            });
        
      case "M_Scorpionr":
        return new Battler("Scorpion", 
            STR:18, 
            AGI:16, 
            Hp:16, //16-20 
            sleepResist: 0, 
            stopResist: 15, 
            hurtResist: 0, 
            Dodge:1, 
            Exp: 6, 
            Gp: 12, // 12-15
            grpFactor: 0.25);
        
      case "M_Skeletonr":
        return new Battler("Skeleton", 
            STR:28, 
            AGI:22, 
            Hp:23, //23-30 
            sleepResist: 0, 
            stopResist: 15, 
            hurtResist: 0, 
            Dodge:4, 
            Exp: 11, 
            Gp: 22, // 22-29
            grpFactor: 0.25);
         
      case "M_Wolfr":
        return new Battler("Wolf", 
            STR:40, 
            AGI:30, 
            Hp:26, //-34 
            sleepResist: 1, 
            stopResist: 15, 
            hurtResist: 0, 
            Dodge:2, 
            Exp: 16, 
            Gp: 37, // -49
            grpFactor: 0.25);
         
      case "M_Warlockr":
        return new Battler("Warlock", 
            STR:28, 
            AGI:22, 
            Hp: 23, //-30 
            sleepResist: 3, 
            stopResist: 1, 
            hurtResist: 0, 
            Dodge:2, 
            Exp: 13, 
            Gp: 26, // -34
            grpFactor: 0.25,
            getActionHandler:(Battler atk, Battler def) {
              if (atk.IsStoping) {
                return new MonsterAtkAction(atk,def);
              }
              var rng = new MATH.Random();
              if (!def.IsSleeping) {
                if (rng.nextInt(100) < 25) {
                  return new SleepSpell(atk,def);
                }
                if (rng.nextInt(100) < 50) {
                  return new MonsterHurtSpell(atk,def);
                }
                else {
                  return new MonsterAtkAction(atk,def);
                }
              }
            });
              
      default:
        return null;
    }
  }
}