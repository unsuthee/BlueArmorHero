part of DQ;

class RadotomeTown extends MapData {
  
  var world = const [
              const [787, 788, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 790, 791, 792, 792, 793, 794, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 795, 555],
              const [797, 562, 550, 550, 550, 550, 550, 550, 557, 557, 557, 557, 801, 802, 792, 792, 802, 803, 557, 557, 557, 572, 572, 572, 572, 572, 572, 572, 572, 572, 797, 561],
              const [797, 562, 550, 550, 550, 550, 550, 550, 550, 557, 550, 557, 550, 806, 792, 792, 807, 550, 550, 557, 550, 787, 788, 789, 808, 788, 789, 789, 795, 809, 797, 561],
              const [797, 562, 550, 787, 788, 789, 789, 795, 555, 550, 550, 550, 550, 550, 792, 792, 550, 550, 550, 557, 550, 797, 810, 811, 812, 813, 814, 815, 797, 611, 797, 561],
              const [797, 562, 550, 797, 810, 811, 811, 797, 561, 550, 550, 550, 550, 550, 792, 792, 793, 550, 550, 550, 550, 797, 810, 811, 435, 810, 814, 458, 797, 611, 797, 561],
              const [797, 562, 550, 797, 819, 820, 820, 797, 561, 550, 550, 550, 550, 550, 792, 792, 802, 793, 550, 550, 550, 797, 810, 811, 821, 813, 814, 458, 797, 611, 797, 561],
              const [797, 562, 550, 797, 810, 811, 811, 797, 561, 550, 822, 793, 550, 550, 792, 792, 802, 807, 557, 550, 550, 823, 824, 794, 825, 789, 789, 789, 826, 561, 797, 561],
              const [797, 562, 550, 827, 790, 828, 794, 826, 561, 822, 802, 829, 793, 550, 792, 792, 830, 557, 557, 550, 550, 550, 831, 550, 550, 550, 550, 550, 550, 550, 797, 561],
              const [797, 562, 557, 550, 550, 792, 832, 550, 550, 833, 807, 834, 835, 550, 792, 792, 807, 557, 787, 788, 789, 789, 808, 788, 789, 789, 789, 795, 555, 550, 797, 561],
              const [797, 562, 557, 550, 550, 792, 550, 550, 822, 807, 836, 834, 833, 793, 792, 792, 550, 550, 797, 810, 837, 838, 797, 810, 811, 811, 811, 797, 561, 550, 797, 561],
              const [797, 562, 550, 550, 550, 792, 550, 822, 830, 836, 839, 836, 833, 807, 792, 792, 550, 550, 797, 810, 811, 811, 797, 810, 840, 841, 811, 797, 561, 550, 797, 561],
              const [797, 561, 550, 550, 550, 792, 550, 806, 830, 834, 836, 834, 835, 550, 792, 792, 550, 550, 797, 810, 811, 811, 797, 810, 811, 811, 811, 797, 561, 550, 797, 561],
              const [823, 562, 557, 550, 550, 792, 550, 550, 806, 793, 834, 822, 807, 550, 792, 792, 550, 550, 827, 790, 828, 794, 825, 790, 828, 794, 789, 826, 561, 557, 823, 561],
              const [557, 557, 550, 550, 550, 792, 550, 550, 550, 806, 842, 807, 550, 550, 792, 792, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 557, 557, 550],
              const [792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792],
              const [792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792, 792],
              const [557, 557, 550, 550, 550, 550, 550, 550, 550, 792, 550, 550, 550, 550, 557, 550, 792, 550, 550, 550, 557, 550, 550, 550, 550, 843, 844, 139, 140, 847, 557, 550],
              const [821, 556, 557, 550, 550, 550, 550, 550, 550, 792, 550, 550, 550, 557, 557, 550, 792, 550, 557, 557, 557, 557, 843, 843, 844, 139, 130, 131, 219, 140, 847, 843],
              const [797, 562, 550, 550, 550, 550, 550, 550, 550, 792, 550, 550, 557, 557, 550, 550, 792, 557, 557, 557, 550, 844, 139, 130, 130, 131, 97, 97, 97, 219, 130, 130],
              const [797, 561, 550, 550, 550, 550, 550, 821, 853, 792, 821, 555, 550, 550, 550, 550, 792, 550, 557, 550, 844, 139, 97, 197, 114, 114, 189, 97, 97, 97, 97, 97],
              const [797, 561, 787, 857, 858, 789, 808, 859, 790, 860, 861, 789, 789, 795, 555, 550, 792, 550, 550, 844, 139, 471, 114, 115, 864, 865, 168, 114, 189, 97, 97, 97],
              const [797, 561, 797, 867, 868, 811, 797, 810, 811, 811, 435, 810, 811, 797, 561, 550, 792, 550, 675, 139, 454, 864, 871, 871, 550, 572, 872, 873, 168, 189, 97, 97],
              const [797, 561, 797, 810, 811, 811, 823, 810, 794, 789, 789, 789, 789, 874, 561, 550, 792, 792, 792, 875, 864, 550, 550, 572, 572, 572, 572, 572, 873, 168, 189, 97],
              const [797, 561, 797, 810, 811, 811, 876, 811, 811, 811, 811, 811, 811, 797, 561, 550, 550, 550, 844, 458, 651, 550, 787, 788, 789, 808, 788, 795, 809, 557, 113, 97],
              const [797, 561, 797, 810, 794, 789, 879, 880, 828, 787, 857, 790, 828, 797, 561, 550, 550, 675, 139, 454, 651, 550, 823, 810, 811, 812, 810, 797, 562, 557, 113, 97],
              const [797, 561, 797, 810, 811, 811, 797, 810, 811, 797, 867, 811, 811, 797, 562, 550, 550, 844, 458, 864, 550, 550, 811, 811, 811, 435, 810, 797, 562, 881, 113, 97],
              const [797, 561, 797, 810, 811, 882, 797, 819, 820, 797, 810, 811, 811, 797, 562, 557, 675, 139, 466, 884, 550, 572, 821, 828, 811, 821, 810, 797, 562, 139, 131, 97],
              const [797, 561, 797, 810, 837, 838, 797, 810, 811, 797, 810, 837, 838, 797, 562, 557, 885, 113, 219, 140, 886, 572, 827, 789, 789, 825, 789, 826, 139, 436, 114, 114],
              const [797, 561, 827, 789, 789, 789, 825, 789, 789, 825, 789, 789, 789, 826, 561, 885, 139, 131, 97, 219, 140, 886, 888, 888, 888, 889, 139, 130, 131, 98, 864, 871],
              const [797, 561, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 675, 139, 131, 97, 97, 97, 219, 130, 130, 130, 130, 130, 131, 97, 197, 115, 651, 550],
              const [827, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 789, 790, 107, 97, 97, 97, 97, 97, 97, 97, 98, 864, 550, 550],
              const [550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 113, 97, 97, 97, 97, 97, 97, 97, 98, 651, 550, 550],
              ];
  
  int _maxPX;
  int _maxPY;
  int _srcTileSize = 16;
  int _defaultTileId = 550; // grass
  int _tilePerRow = 20;
  
  int getInitPosX() => 336;
  int getInitPosY() => 875;
  
  // -43:28 to -43:25 West Entrace
  Map<String,Trigger> getTriggeMap() {
    Map<String,Trigger> triggers = new Map<String,Trigger>();
    
    Trigger exitTownTrigger = new ExitTownTrigger("-43:28");
    triggers["-43:28"] = exitTownTrigger;
    triggers["-43:27"] = exitTownTrigger;
    triggers["-43:26"] = exitTownTrigger;
    triggers["-43:25"] = exitTownTrigger;
    
    triggers["25:28"] = exitTownTrigger;
    triggers["25:27"] = exitTownTrigger;
    triggers["25:26"] = exitTownTrigger;
    triggers["25:25"] = exitTownTrigger;

    triggers["-13:-6"] = exitTownTrigger;
    triggers["-12:-6"] = exitTownTrigger;
    triggers["-11:-6"] = exitTownTrigger;
    triggers["-10:-6"] = exitTownTrigger;
    triggers["-9:-6"] = exitTownTrigger;
    triggers["-8:-6"] = exitTownTrigger;
    triggers["-7:-6"] = exitTownTrigger;
    
    return triggers;
  }
  
  List<Thing> getNPC(Game gm) {
    
    void handleTalk(Game gm, HeroSprite talker, NPC talkee) {
      talkee.ResetToIdle();
      talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
      gm.AddRequest(new RedrawRequest(gm));
      gm.AddRequest(new PushRequest(gm, new MsgBox(gm, talkee.name)));  
    }
    
    List<Thing> npcs = new List<Thing>();
    
    String heroName = gm.gameState.heroName;
    
    npcs.add(new NPC(gm, "Merchant", name:"Merchant1", px:1090, py:1107, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Merchant", name:"Merchant2", px:491, py:544, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        List itmInfo = [stats.WeaponData["Bamboo Pole"],
                        stats.WeaponData["Club"],
                        stats.WeaponData["Copper Sword"],
                        stats.ArmorData["Clothes"],
                        stats.ArmorData["Leather Armor"],
                        stats.ShieldData["Small Shield"]];
        gm.AddRequest(new PushRequest(gm, new BuySellMenu(gm,"Weapon",itmInfo)));
      }));
    
    npcs.add(new NPC(gm, "Merchant", name:"Merchant3", px:1167, py:1212, direction:DEF.DIR_LEFT, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        List itmInfo = [stats.ItemData["Herb"],
                         stats.ItemData["Wings"],
                         stats.ItemData["Torch"]];
        gm.AddRequest(new PushRequest(gm, new BuySellMenu(gm,"Item",itmInfo)));
      }));
    
    npcs.add(new NPC(gm, "Knight", name:"Knight1", px:468, py:1234, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Knight", name:"Knight2", px:686, py:786, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Knight", name:"Knight3", px:979, py:992, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Oldman", name:"Oldman1", px:688, py:1281, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Oldman", name:"Oldman2", px:1072, py:734, direction:DEF.DIR_RIGHT, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Man", name:"Man1", px:591, py:899, behavior_type:NPC.BEHAVIOR_WALKING, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Man", name:"Man2", px:1086, py:1309, behavior_type:NPC.BEHAVIOR_WALKING, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Man", name:"Man3", px:979, py:739, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Girl", name:"Girl1", px:816, py:1142, direction:DEF.DIR_RIGHT, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Woman", name:"Woman1", px:691, py:1087, direction:DEF.DIR_LEFT, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        gm.AddRequest(new PushRequest(gm, new InnMenu(gm,2)));
      }));
    
    //npcs.add(new NPC(gm, "Woman", name:"Woman2", px:590, py:1278, direction:DEF.DIR_UP, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Nan", name:"Nan1", px:1134, py:544, direction:DEF.DIR_LEFT, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
      talkee.ResetToIdle();
      talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
      gm.AddRequest(new RedrawRequest(gm));
      
      List itmInfo = [stats.ItemData["Holy Water"],
                      stats.ItemData["Key"]];
      gm.AddRequest(new PushRequest(gm, new BuySellMenu(gm,"Item",itmInfo)));
    }));
    
    npcs.add(new NPC(gm, "Soldier", name:"Soldier1", px:1069, py:867, behavior_type:NPC.BEHAVIOR_WALKING, talkHandler:handleTalk));
    npcs.add(new NPC(gm, "Soldier", name:"Soldier2", px:1258, py:449, talkHandler:handleTalk));
    
    return npcs;
  }
  

  RadotomeTown() {
    _maxPX = world[0].length;
    _maxPY = world.length;
  }
  
  int getSrcTileSize() {
    return _srcTileSize;
  }
  
  String getSrcImageName() {
    return "TownImage";
  }
  
  int getTileIdByPos(int px, int py) {
    if (px >= 0 && px < _maxPX && py >= 0 && py < _maxPY) {
      return world[py][px];
    }
    return _defaultTileId;
  }
  
  int getImageSrcPx(int tileId) {
    return (tileId % _tilePerRow).toInt() * _srcTileSize;
  }
  
  int getImageSrcPy(int tileId) {
    return (tileId / _tilePerRow).toInt() * _srcTileSize;  
  }
  
}