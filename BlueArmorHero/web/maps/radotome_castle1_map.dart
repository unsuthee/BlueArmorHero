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
  
  int getInitPosX() => 767;
  int getInitPosY() => 638;
  
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
  
  // entrace position: 699:1293
  
  //Solidier : Welcome to Radotome Castle! 644:1278 , 751:1278
  // 938:1010 Sol : When you enter a cave,;it's good to have a torch because caves are filled with the powers of the darkness.
  // *: And, there are more monsters in caves than out in the countryside.
  // 1021:1245 old man: When the dragon of darkness spreads its wings,;it marks the arrival of the descendant of Erdrick.
  // *: May the light shine upon the hero of legend, ${heroname}!"
  // 618:797 girl : Oh, Princess Gwaelin...;Where could she be?;Could it be that she is dead?"
  // 751:860 bman: This is Radotome castle.;Many people would gather here, since this place was a paradise.
  // Then all the demons appeared.;;...[sigh]..."
  // 431:1107 Merchant: I'm a traveling merchant.;Many of my colleagues were killed by minions of the Dragonlord";
  // Because of this, I've collected mortifying and sorrowful memories of those times.
  // 566:1217 kid: Did you hear?
  // yes: I'm shocked!
  // no: Rumor has it that there is a town that was destroyed by the demons.
  
  // 386:670 Knight: TO gain experience and levels,;you must fight monsters;
  // When you do that noble {heroname},;you may rise to the next level, and you'll become stronger.
  // 914:537 sol: A key is necessary to open this door.
  // Also, I hear that the key will break after just one use.
  
  // 624:477 man: My girlfriend and I will be together until the day we die.
  // But will the day come that my feelings will be shattered by demons?
  // 594:477 girl: When I am together with my boyfriend...
  // I forget about the darkness that continues to blanket our world.
  // However, that is a lie... If the world is destroyed, he says that our love will be too.
  
  // 799:607 sol: when you want to rest from your travles, come back.
  // The king will record your journey for you in the Imperial Scrolls of Honor.
  
  // 796:672 Sol: A record of your journey can be written in the Imperial Scrolls of Honor.
  // When you return from a break, it can be resumed where you left off.
  
  // Chancelor: 989:752
  // woman: 1009:832
  // merchant: 1136:432
  // sol: 466:894
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