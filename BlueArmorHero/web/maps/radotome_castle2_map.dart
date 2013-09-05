part of DQ;

class RadotomeCastle2 extends MapData {
  
  var world = const [
                     const [551, 679, 553, 553, 681, 553, 553, 681, 553, 553, 681, 553, 553, 553, 554],
                     const [558, 684, 685, 685, 686, 685, 685, 686, 685, 685, 686, 685, 685, 685, 558],
                     const [558, 559, 688, 689, 690, 690, 690, 690, 690, 690, 690, 691, 688, 560, 558],
                     const [558, 559, 688, 693, 694, 695, 696, 697, 694, 695, 696, 698, 688, 560, 558],
                     const [558, 559, 688, 693, 699, 700, 701, 697, 699, 700, 701, 698, 688, 560, 558],
                     const [558, 559, 688, 693, 697, 697, 697, 697, 697, 697, 697, 698, 688, 560, 558],
                     const [558, 559, 688, 693, 697, 697, 697, 697, 697, 697, 697, 698, 688, 560, 558],
                     const [558, 559, 688, 693, 697, 697, 697, 697, 697, 697, 697, 698, 688, 560, 558],
                     const [558, 559, 688, 693, 697, 697, 697, 697, 697, 697, 697, 698, 688, 560, 558],
                     const [558, 559, 688, 702, 703, 703, 704, 697, 705, 703, 703, 706, 688, 560, 558],
                     const [558, 559, 688, 688, 688, 688, 693, 697, 698, 688, 688, 688, 688, 560, 558],
                     const [558, 559, 560, 560, 560, 707, 693, 697, 698, 707, 560, 560, 560, 560, 558],
                     const [558, 559, 560, 560, 560, 708, 693, 697, 698, 708, 560, 560, 560, 560, 558],
                     const [558, 559, 560, 560, 560, 626, 693, 697, 698, 630, 560, 560, 560, 560, 558],
                     const [576, 679, 553, 553, 553, 712, 713, 714, 715, 716, 553, 553, 553, 553, 600],
                     const [558, 684, 685, 685, 685, 718, 719, 720, 721, 722, 685, 685, 685, 685, 558],
                     const [558, 559, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 558],
                     const [558, 559, 560, 560, 560, 560, 560, 723, 560, 560, 560, 560, 560, 560, 558],
                     const [566, 553, 553, 553, 553, 553, 553, 553, 553, 553, 553, 553, 553, 553, 571],
                     const [726, 685, 685, 685, 685, 685, 685, 685, 685, 685, 685, 685, 685, 685, 727],
                     const [728, 728, 728, 728, 728, 728, 728, 728, 728, 728, 728, 728, 728, 728, 728]
                     ];
  
  int _maxPX;
  int _maxPY;
  int _srcTileSize = 16;
  int _defaultTileId = 728; // black spot
  int _tilePerRow = 20;
 
  int getInitPosX() => 497;
  int getInitPosY() => 575;
  
  RadotomeCastle2() {
    _maxPX = world[0].length;
    _maxPY = world.length;
  }
  
  Map<String,Trigger> getTriggeMap() {
    Map<String,Trigger> triggers = new Map<String,Trigger>();
    triggers["35:59"] = new ExitTownTrigger("35:59");
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
    
    // King Lorik
    String msg = "King Lorik: Descendant of Erdrick, listen now to my words." +
        "It is told that in ages past Erdrick fought demons with a Ball of Light." +
        "Then came the Dragonlord who stole the precious globe and hid it in the darkness." +
        "Now, Hero, thou must help us recover the Ball of Light and restore peace to our land." +
        "The Dragonlord must be defeated." +
        "Take now whatever thou may find in these Treasure Chests to aid thee in thy quest." +
        "Then speak with the guards, for they have much knowledge that may aid thee." +
        "May the light shine upon thee, Hero.";
    npcs.add(new NPC( gm, "King", name:"King Lorik", px:496, py:538, 
                      talkHandler:(Game gm, HeroSprite talker, NPC talkee) {
                        talkee.ResetToIdle();
                        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
                        gm.AddRequest(new RedrawRequest(gm));
                        gm.AddRequest(new PushRequest(gm, new MsgBox(gm,msg)));  
                      }));
    
    npcs.add(new NPC(gm, "Adviser", name:"Adviser", px:437, py:576, 
        behavior_type:NPC.BEHAVIOR_WALKING,
        talkHandler:(Game gm, HeroSprite talker, NPC talkee) {
          talkee.ResetToIdle();
          talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
          gm.AddRequest(new RedrawRequest(gm));
          
          String msg = "*: ${heroName} do you know about Pricess Gwaelin?";
          String msgYes = "*:${heroName} please go forth and rescue Princess Gwaelin!";
          String msgNo =  "Princess Gwaelin is the only beloved daughter of the King." +
            "So when the Queen passed away, Princess Gwaelin helped support the King's broken heart..." +
            "Then, half a year ago, the Princess was kidnapped by demons!" +
            "The King doesn't ever speak about that." + 
            "But, I know he is suffering from the depths of his heart." + 
            msgYes;
          
          gm.AddRequest(new PushRequest(gm, new YesNoMsgBox(gm, initMsg:msg, yesMsg:msgYes, noMsg:msgNo)));
        }));
    
    npcs.add(new NPC(gm, "Soldier", name:"Soldier1", px:528, py:800, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
      talkee.ResetToIdle();
      talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
      gm.AddRequest(new RedrawRequest(gm));
      
      String msg1 = "*: Save up your money,;so that you can buy more expensive weapons are armor.";
      String msg2 = "*: If you do that,;you will become stronger.";
      gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1};${msg2}")));  
    }));
    
    npcs.add(new NPC(gm, "Soldier", name:"Soldier2", px:594, py:800, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
      talkee.ResetToIdle();
      talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
      gm.AddRequest(new RedrawRequest(gm));
      
      String msg1 = "*: You should listen to people's stories, for they will often provide you with some good information.";
      gm.AddRequest(new PushRequest(gm, new MsgBox(gm, msg1)));  
    }));
    
    npcs.add(new TreasureChest(gm,px:533,py:640));
    npcs.add(new TreasureChest(gm,px:565,py:640));
    npcs.add(new TreasureChest(gm,px:597,py:640));
    
    return npcs;
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