part of DQ;

class stats {
  
  static Map<String,Weapon> WeaponData = {
    "Bamboo Pole"     : new Weapon("Bamboo Pole",cost:10,pow:2),
    "Club"            : new Weapon("Club",cost:60,pow:4),
    "Copper Sword"    : new Weapon("Copper Sword",cost:180,pow:10),
    "Hand axe"        : new Weapon("Hand axe",cost:560,pow:15),
    "Broad Sword"     : new Weapon("Broad Sword",cost:1500,pow:20),
    "Flame Sword"     : new Weapon("Flame Sword",cost:9800,pow:28),
    "Erdrick's Sword" : new Weapon("Erdrick's Sword",cost:0,pow:40),
    "Nothing"         : new Weapon("Nothing")
  };
  
  static Map<String,Shield> ShieldData = {
    "Small Shield"  : new Shield("Small Shield",cost:90,def:4),
    "Large Shield"  : new Shield("Large Shield Shield",cost:800,def:10),
    "Silver Shield" : new Shield("Silver Shield",cost:14800,def:25),
    "Nothing"       : new Shield("Nothing")
  };

  static Map<String,Armor> ArmorData = {
    "Clothes"         : new Armor("Clothes",cost:20,def:2),
    "Leather Armor"   : new Armor("Leather Armor",cost:70,def:4),
    "Chain Mail"      : new Armor("Chain Mail",cost:300,def:10),
    "Half Plate"      : new Armor("Half Plate",cost:1000,def:16),
    "Full Plate"      : new Armor("Full Plate",cost:3000,def:24),
    "Magic Armor"     : new Armor("Magic Armor",cost:7700,def:24),
    "Erdrick's Armor" : new Armor("Erdrick's Armor",cost:0,def:28),
    "Nothing"         : new Armor("Nothing")
  };
  
  static Map<String,Item> ItemData = {
    "Herb"  : new Item("Herb",cost:24),
    "Key"   : new Item("Key",cost:38),
    "Torch"  : new Item("Torch",cost:8),
    "Wings"  : new Item("Wings",cost:70),
    "Holy Water": new Item("Holy Water",cost:120)
  };
                                        
  static List<int> ExpTable = [0,0,7,23,47,110,
                   220,450,800,1300,2000,
                   2900,4000,5500,7500,10000,
                   13000,17000,21000,25000,29000,
                   33000,37000,41000,45000,49000,
                   53000,57000,61000,65000,65535];
  
  // Name, Lv learn, MP cost, description
  static Map<String,List> FieldSpellTable = {
    "Heal": [3, 4, "Replenishes lost Hit Points."],
    "Radiant": [9, 3, "Causes the Hero to shine, making a torch unnessary."], 
    "Outside": [12, 6, "Teleports the Hero to the outside of the dungeon."],
    "Return": [13, 8, "Teleports the Hero to Tantegel Castle. Must be outside."],
    "Repel": [15, 2, "Keeps monsters from attacking you"],
    "HealMore": [17, 10, "Same as HEAL, only stronger"]
  };
  
// Name, Lv learn, MP cost, description
  static Map<String,List> BattleSpellTable = {
     "Heal": [3, 4, "Replenishes lost Hit Points."],
     "Hurt": [4, 2, "Hurts fire at an enemy in battle."],
     "Sleep": [7, 2, "Puts an enemy to sleep in battle."],
     "Stop": [10, 2, "Prevents an enemy from using spells."],
     "HealMore": [17, 10, "Same as HEAL, only stronger"],
     "HurtMore": [19, 5, "Same as HURT, only stronger"]
  };
  
  static Map<String,String> SpellsTable = {
    "3": "Heal",
    "4": "Hurt",
    "7": "Sleep",
    "9": "Radiant",
    "10": "Stop",
    "12": "Outside",
    "13": "Return",
    "15": "Repel",
    "17": "HealMore",
    "19": "HurtMore"
  };
  
  // Name, effect
  static Map BattleItemTable = {
    "Herb": ["Restore 20-35 HP."],
    "Fairy Flute": ["A mysterious flute. Has some special effect when used."]
  };
  
  static List FieldItemTable = [
    "Herb",
    "Torch",
    "Fairy Water",
    "Wings",
    "Fairy Flute",
    "Silver Harp",
    "Rainbow Drop",
    "Erdrick's Tablet",
    "Gwaelin's Love"
  ];
 
  static const Terrans = const [ "o","o","o","o","o","o","o","o","o","o", 
                                 "o","o","o","o","g","f","h","m","s","x",
                                 "b","w","x","w","w","w","w","w","w","w",
                                 "g","g","x","g","g","g","g","s","s","g",
                                 "g","g","x","s","g","w","o","o","o","o",
                                 "o","o","o","o","o","o","o","o","o","o",
                                 "o","o","o","m","m","m","m","m","s","s",
                                 "s","s","s","s","s","s","s","s","x","s",
                                 "g","g","g","g","g","h","h","h","h","h",
                                 "h","h","f","f","f","f","f","x","x","m",
                                 "g","g","g","m","m","m","m","g","g","g",
                                 "g","g","w","w","w","w","m","g","g","g",
                                 "g","g","g","s","o","o","o","o","x","x",
                                 "g","g","g","g","g","g","g","g","g","g"];
     
  static String getOverworldTerranByTileId(int tileId) {
    
    String tile = "o";
    if (tileId >=0 && tileId < Terrans.length) {
      tile = Terrans[tileId];
    }
    switch(tile) {
      case "g":
      case "b":
        return "Grass";
      case "f":
        return "Forest";
      case "h":
        return "Mountain";
      case "s":
        return "Dessert";
      case "w":
        return "Swarm";
      default:
        return "Grass";
    }
  }
  
  static bool isPassableTerran(int tileId) {
    String tile = "o";
    if (tileId >=0 && tileId < Terrans.length) {
      tile = Terrans[tileId];
    }
    switch(tile) {
      case "g":
      case "b":
      case "f":
      case "h":
      case "s":
      case "w":
        return true;
      default:
        return false;
    }
  }
  
  static const VillageTerrans = const [
                                       1,1,0,0,0,0,1,0,1,1,1,1,1,1,0,1,0,1,0,0
                                       ,1,0,0,0,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1
                                       ,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                                       ,0,1,0,1,1,1,1,0,1,1,0,1,0,1,1,1,0,0,0,1
                                       ,0,0,0,0,1,0,0,0,0,0,0,0,1,1,0,0,0,1,1,1
                                       ,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1
                                       ,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1
                                       ,1,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,0
                                       ,0,1,1,1,0,0,0,1,1,0,1,0,0,0,1,0,0,0,0,1
                                       ,1,1,0,0,1,1,0,0,0,1,0,0,1,0,1,1,0,1,1,0
                                       ,0,0,1,1,0,0,0,1,1,1,0,0,0,0,0,0,1,1,0,1
                                       ,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                                       ,0,1,1,1,1,1,1,1,1,1,0,1,0,0,1,0,0,1,1,1
                                       ,1,1,1,0,1,0,0,0,1,1,0,1,1,0,0,1,0,1,1,0
                                       ,1,1,1,0,1,0,1,1,1,0,0,1,1,0,0,0,0,1,1,1
                                       ,0,0,0,1,0,0,0,1,1,0,1,1,1,1,0,0,1,1,0,1
                                       ,0,0,0,1,1,0,0,1,1,1,1,0,0,0,0,0,1,0,1,0
                                       ,1,1,1,0,1,0,0,1,1,1,1,0,0,0,0,0,0,0,1,1
                                       ,1,1,1,1,1,1,0,0,1,1,0,1,1,1,0,1,1,1,0,0
                                       ,0,0,0,0,0,0,0,0,0,1,1,0,1,1,1,1,0,1,1,1
                                       ,1,0,0,1,0,0,1,1,1,1,0,1,0,1,0,1,1,1,0,0
                                       ,0,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1
                                       ,1,1,0,0,1,1,1,1,1,1,1,0,1,1,1,0,0,0,1,1
                                       ,1,0,0,0,0,0,1,0,0,0,1,1,0,0,1,1,1,1,0,0
                                       ,0,0,1,0,1,0,0,0,0,1,1,0,1,1,1,1,0,0,1,0
                                       ,0,1,1,0,1,0,1,1,0,0,1,1,1,1,0,1,1,1,1,1
                                       ,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1
                                       ,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1,1,1,0
                                       ,0,0,1,1,1,1,1,1,0,0,1,1,0,1,0,1,1,1,1,0
                                       ,0,0,0,1,1,0,0,1,1,1,1,1,1,1,0,0,0,0,1,1
                                       ,1,1,1,1,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0
                                       ,0,0,0,1,1,0,0,1,1,1,0,1,1,1,1,1,1,1,1,1
                                       ,1,1,1,1,0,1,1,1,1,1,1,0,1,0,1,1,1,1,0,1
                                       ,1,0,1,1,1,1,1,1,1,1,0,0,1,1,1,0,1,0,1,1
                                       ,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,0,0,1
                                       ,1,1,0,0,0,0,0,1,1,0,0,1,1,1,0,1,1,1,1,1
                                       ,0,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,0
                                       ,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,0,0,0,0,1
                                       ,0,0,0,1,1,0,1,1,1,0,0,0,0,0,0,0,1,1,1,1
                                       ,0,0,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,1,1,0
                                       ,1,0,0,0,0,0,0,0,1,0,0,0,1,1,0,1,0,1,1,1
                                       ,1,1,0,1,1,1,1,1,0,0,0,0,1,0,0,0,0,1,1,1
                                       ,0,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                                       ,0,1,1,1,0,0,1,0,0,0,1,0,0,0,1,0,1,0,1,1
                                       ,1,1,0,1,0,1,0,1,0,0,1,1,0,0,0,1,1,1,1,0
                                       ,0,1,1,1,1,1,1,1,1,0,0,1,0,0,1,1,1,1,1,0
                                       ,1,1,1,0,1,0,0,1,0,1,0,1,0,1,1,1,0,1,1,1
                                       ,0,0,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                                       ,1,0,1,1,0,1,1,0,0,0,0,0,0,0,1,0,0,1,1,0
                                       ,0,0,0,0,1,0,0,0,0,1,1,1,1,1,1,0,1,1,1,0
                                       ,1,1,0,0,1,0,0,0,1,1,0,1,1,1,1,1,1,1,1,1];
  
  static bool isPassableVillageTerran(int tileId) {
    int tile = 0;
    if (tileId >=0 && tileId < Terrans.length) {
      tile = VillageTerrans[tileId];
    }
    return (tile == 0);
  }
}