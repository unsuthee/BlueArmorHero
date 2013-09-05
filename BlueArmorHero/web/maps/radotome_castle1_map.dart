part of DQ;

class RadotomeCastle1 extends MapData {
  
  var world = const [
                     const [550, 551, 552, 553, 553, 553, 553, 554, 555, 550, 550, 550, 550, 550, 550, 550, 551, 552, 553, 553, 553, 553, 554, 555, 551, 552, 554, 556, 557, 550, 550],
                     const [550, 558, 559, 560, 560, 560, 560, 558, 561, 557, 550, 557, 557, 550, 557, 550, 558, 559, 560, 560, 560, 560, 558, 561, 558, 559, 558, 562, 550, 550, 550],
                     const [550, 558, 559, 560, 560, 560, 560, 558, 561, 550, 550, 550, 550, 550, 550, 550, 558, 559, 560, 560, 560, 560, 558, 561, 563, 564, 563, 561, 550, 550, 550],
                     const [550, 558, 559, 560, 565, 560, 560, 566, 553, 553, 567, 568, 569, 570, 553, 553, 571, 559, 560, 565, 560, 560, 558, 561, 550, 550, 572, 572, 550, 550, 550],
                     const [550, 558, 559, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 558, 561, 572, 572, 572, 550, 550, 550, 550],
                     const [550, 558, 559, 560, 560, 560, 560, 551, 552, 553, 553, 573, 573, 553, 553, 553, 554, 574, 560, 560, 560, 560, 558, 561, 550, 550, 550, 550, 550, 550, 550],
                     const [551, 575, 553, 553, 553, 554, 574, 558, 559, 560, 560, 560, 560, 560, 560, 560, 576, 552, 567, 577, 570, 553, 578, 553, 567, 568, 570, 553, 554, 555, 550],
                     const [558, 559, 560, 560, 560, 558, 559, 558, 559, 560, 560, 579, 580, 560, 581, 560, 558, 559, 560, 582, 560, 560, 560, 560, 560, 560, 560, 560, 558, 561, 550],
                     const [558, 559, 583, 584, 560, 563, 559, 558, 559, 560, 560, 585, 586, 560, 560, 560, 558, 559, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 558, 561, 550],
                     const [558, 559, 560, 560, 560, 560, 560, 576, 552, 587, 574, 560, 560, 560, 588, 553, 589, 552, 553, 590, 591, 592, 590, 552, 553, 554, 574, 560, 558, 561, 550],
                     const [558, 559, 560, 560, 560, 593, 574, 558, 594, 595, 560, 579, 580, 560, 596, 597, 558, 559, 560, 558, 598, 599, 558, 559, 560, 558, 559, 560, 558, 561, 550],
                     const [576, 552, 553, 553, 553, 600, 559, 558, 594, 595, 560, 585, 586, 560, 596, 597, 558, 559, 560, 563, 601, 602, 563, 559, 560, 563, 559, 560, 558, 561, 550],
                     const [558, 603, 560, 560, 604, 558, 559, 558, 594, 605, 560, 560, 560, 560, 606, 597, 558, 559, 560, 560, 607, 608, 560, 560, 560, 560, 560, 560, 558, 561, 550],
                     const [558, 609, 610, 560, 604, 563, 559, 558, 611, 605, 560, 579, 580, 560, 606, 572, 558, 559, 612, 560, 613, 614, 560, 560, 560, 560, 560, 560, 558, 561, 550],
                     const [558, 603, 615, 560, 560, 577, 560, 558, 611, 616, 560, 585, 586, 560, 617, 572, 558, 559, 560, 560, 607, 608, 560, 560, 560, 593, 574, 560, 558, 561, 550],
                     const [558, 609, 610, 560, 560, 618, 574, 558, 619, 560, 620, 621, 621, 622, 560, 606, 558, 559, 560, 593, 574, 560, 593, 574, 560, 558, 559, 560, 558, 611, 550],
                     const [566, 623, 624, 553, 553, 571, 559, 563, 625, 626, 627, 628, 628, 629, 630, 617, 566, 553, 553, 578, 553, 553, 589, 552, 553, 571, 559, 570, 600, 611, 550],
                     const [550, 558, 631, 632, 633, 560, 560, 560, 560, 626, 634, 635, 636, 637, 630, 560, 560, 560, 560, 638, 638, 638, 558, 559, 560, 560, 560, 560, 558, 611, 550],
                     const [550, 558, 559, 560, 560, 560, 560, 560, 560, 626, 639, 640, 641, 642, 630, 560, 560, 560, 560, 560, 560, 560, 558, 643, 643, 643, 643, 643, 558, 611, 550],
                     const [550, 576, 552, 567, 574, 560, 570, 553, 554, 644, 645, 646, 647, 648, 630, 551, 649, 574, 560, 560, 560, 560, 558, 643, 643, 643, 643, 643, 558, 611, 550],
                     const [550, 558, 559, 560, 560, 560, 560, 560, 558, 559, 560, 560, 560, 560, 560, 558, 559, 560, 560, 560, 560, 560, 558, 559, 560, 560, 560, 560, 558, 611, 550],
                     const [550, 558, 559, 560, 560, 560, 560, 560, 566, 554, 574, 579, 580, 560, 551, 575, 553, 553, 553, 567, 574, 560, 558, 559, 560, 560, 560, 560, 558, 650, 651],
                     const [550, 558, 559, 560, 565, 560, 560, 560, 560, 558, 559, 585, 586, 560, 558, 559, 560, 560, 560, 560, 560, 560, 576, 553, 553, 553, 553, 553, 571, 458, 651],
                     const [550, 558, 559, 653, 653, 560, 560, 560, 560, 558, 559, 560, 560, 560, 558, 559, 560, 560, 560, 560, 560, 560, 558, 654, 655, 655, 655, 655, 656, 657, 651],
                     const [550, 558, 658, 659, 660, 661, 560, 565, 560, 558, 559, 579, 580, 560, 558, 559, 560, 551, 552, 553, 590, 552, 600, 113, 97, 97, 97, 97, 97, 98, 651],
                     const [550, 558, 665, 666, 667, 660, 630, 560, 560, 558, 559, 585, 586, 560, 558, 559, 560, 563, 559, 560, 668, 559, 558, 113, 97, 97, 97, 97, 97, 98, 651],
                     const [550, 558, 113, 97, 97, 98, 661, 560, 560, 576, 649, 574, 560, 570, 600, 559, 560, 560, 560, 560, 435, 559, 558, 113, 97, 97, 97, 97, 97, 98, 651],
                     const [650, 558, 113, 97, 97, 667, 660, 661, 560, 558, 559, 560, 560, 560, 558, 559, 560, 593, 574, 560, 593, 559, 558, 113, 97, 97, 97, 97, 97, 98, 651],
                     const [458, 566, 553, 553, 553, 553, 553, 553, 553, 578, 587, 670, 671, 588, 578, 553, 553, 578, 553, 553, 578, 553, 571, 113, 97, 97, 97, 97, 97, 98, 651],
                     const [672, 673, 674, 651, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 675, 676, 666, 97, 97, 97, 97, 97, 98, 677],
                     const [113, 97, 98, 651, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 675, 113, 97, 97, 97, 97, 97, 97, 98, 651]
                     ];
  
  int _maxPX;
  int _maxPY;
  int _srcTileSize = 16;
  int _defaultTileId = 550; // grass
  int _tilePerRow = 20;
  
// entrace position: 699:1293
  int getInitPosX() => 699;
  int getInitPosY() => 1293;
  
  static const List stairPos = const [767,638];
  
  static int stairTriggerPosX = 767;
  static int stairTriggerPosY = 638;  
  
  RadotomeCastle1() {
    _maxPX = world[0].length;
    _maxPY = world.length;
  }
  
  int getSrcTileSize() {
    return _srcTileSize;
  }
  
  String getSrcImageName() {
    return "TownImage";
  }
  
  List<Thing> getNPC(Game gm) {
    
    List<Thing> npcs = new List<Thing>();
    
    npcs.add(new NPC(gm, "Soldier", name:"Soldier1", px:658, py:1278, direction:DEF.DIR_RIGHT, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "*: Welcome to Radotome Castle!")));
      }));
    
    npcs.add(new NPC(gm, "Soldier", name:"Soldier2", px:751, py:1278, direction:DEF.DIR_LEFT, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "*: Welcome to Radotome Castle!")));
      }));
    
    npcs.add(new NPC(gm, "Soldier", name:"Soldier3", px:938, py:1010, behavior_type:NPC.BEHAVIOR_WALKING, direction:DEF.DIR_LEFT, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: When you enter a cave,;it's good to have a torch because caves are filled with the powers of the darkness.";
        String msg2 = "*: And, there are more monsters in caves than out in the countryside.";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1};${msg2}")));
      }));
    
    npcs.add(new NPC(gm, "Soldier", name:"Soldier4", px:783, py:607, direction:DEF.DIR_LEFT, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: When you want to rest from your travles, come back.";
        String msg2 = "*: The king will record your journey for you in the Imperial Scrolls of Honor.";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1};${msg2}")));
      }));
    
    npcs.add(new NPC(gm, "Soldier", name:"Soldier5", px:783, py:672, direction:DEF.DIR_LEFT, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: A record of your journey can be written in the Imperial Scrolls of Honor.";
        String msg2 = "*: When you return from a break, it can be resumed where you left off.";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1};${msg2}")));
      }));
    
    npcs.add(new NPC(gm, "Soldier", name:"Soldier6", px:914, py:537, behavior_type:NPC.BEHAVIOR_WALKING, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: A key is necessary to open this door.;Also, I hear that the key will break after just one use.";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1}")));
      }));
    
    npcs.add(new NPC(gm, "Oldman", name:"Oldman1", px:1007, py:1245, direction:DEF.DIR_LEFT, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: When the dragon of darkness spreads its wings,;it marks the arrival of the descendant of Erdrick.";
        String msg2 = "*: May the light shine upon the hero of legend, ${talker.name}!";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1};${msg2}")));
      }));
    
    npcs.add(new NPC(gm, "Girl", name:"Girl1", px:618, py:797, behavior_type:NPC.BEHAVIOR_WALKING, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: Oh, Princess Gwaelin...;Where could she be?;Could it be that she is dead?";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1}")));
      }));
    
    npcs.add(new NPC(gm, "Man", name:"Man1", px:751, py:860, behavior_type:NPC.BEHAVIOR_WALKING, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: This is Radotome castle.;Many people would gather here, since this place was a paradise.";
        String msg2 = "*:  Then all the demons appeared.;;...[sigh]...";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1};${msg2}")));
      }));
    
    npcs.add(new NPC(gm, "Girl", name:"Girl2", px:594, py:477, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: When I am together with my boyfriend...";
        String msg2 = "*: I forget about the darkness that continues to blanket our world.";
        String msg3 = "*: However, that is a lie... If the world is destroyed, he says that our love will be too.";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1};${msg2};${msg3}")));
      }));
    
    npcs.add(new NPC(gm, "Man", name:"Man2", px:624, py:477, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: My girlfriend and I will be together until the day we die.";
        String msg2 = "*: But will the day come that my feelings will be shattered by demons?";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1};${msg2}")));
      }));
    
    npcs.add(new NPC(gm, "Knight", name:"Knight1", px:400, py:668, direction:DEF.DIR_RIGHT, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: To gain experience and levels,;you must fight monsters";
        String msg2 = "*: When you do that noble ${talker.name},;you may rise to the next level, and you'll become stronger.";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1};${msg2}")));
      }));
    
    npcs.add(new NPC(gm, "Merchant", name:"Merchant1", px:431, py:1107, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: I'm a traveling merchant.;Many of my colleagues were killed by minions of the Dragonlord";
        String msg2 = "*: Because of this, I've collected mortifying and sorrowful memories of those times.";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1};${msg2}")));
      }));
    
    npcs.add(new NPC(gm, "Boy", name:"boy1", px:566, py:1217, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
      talkee.ResetToIdle();
      talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
      gm.AddRequest(new RedrawRequest(gm));
      
      String msg1 = "*: Did you hear?";
      String yesMsg = "*: I'm shocked!";
      String noMsg = "*: Rumor has it that there is a town that was destroyed by the demons.";
      
      gm.AddRequest(new PushRequest(gm, new YesNoMsgBox(gm,
          selfDismissOnFinish:false,
          initMsg:msg1,
          yesMsg:yesMsg,
          noMsg:noMsg)));
    }));
    
    npcs.add(new NPC(gm, "Sage", name:"Sage", px:989, py:752, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: How did you get here?";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1}")));
      }));
    
    npcs.add(new NPC(gm, "Merchant", name:"Merchant5", px:1136, py:449, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: How did you get here?";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1}")));
      }));
    
    npcs.add(new NPC(gm, "Woman", name:"Woman4", px:1009, py:832, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: How did you get here?";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1}")));
      }));
    
    npcs.add(new NPC(gm, "Soldier", name:"Soldier9", px:466, py:894, direction:DEF.DIR_UP, talkHandler:
      (Game gm, HeroSprite talker, NPC talkee) {
        talkee.ResetToIdle();
        talkee.characterSprite.setAnimation(DEF.OppositeDirection(talker.direction));
        gm.AddRequest(new RedrawRequest(gm));
        
        String msg1 = "*: How did you get here?";
        gm.AddRequest(new PushRequest(gm, new MsgBox(gm, "${msg1}")));
      }));
    
    return npcs;
  }

  Map<String,Trigger> getTriggeMap() {
    Map<String,Trigger> triggers = new Map<String,Trigger>();
    Trigger Castle2ndFloorEnterTrigger = new EnterTownTrigger("172:149", townName:"RadotomeCastle2");
    triggers["49:39"] = Castle2ndFloorEnterTrigger;
    
    Trigger exitTownTrigger = new ExitTownTrigger("43:28");
    AddTriggerByRange(triggers, new Rect(42,82,3,0), exitTownTrigger);
    AddTriggerByRange(triggers, new Rect(37,24,14,0), exitTownTrigger);
    
    return triggers;
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