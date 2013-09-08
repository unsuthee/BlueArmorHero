library DQ;

import 'dart:html';
import 'dart:json' as JSON;
import 'dart:math' as MATH;
import 'dart:async' as ASYNC;
import 'dart:web_audio';

part 'def.dart';
part 'core/imageCache.dart';
part 'core/sprite.dart';
part 'core/animation.dart';
part 'core/TextWriter.dart';
part 'core/TextWriter2.dart';
part 'core/CookieUtil.dart';
part 'core/audioUtil.dart';
part 'gameState.dart';
part 'layers/quest/mapLayer.dart';
part 'layers/quest/statusbar.dart';
part 'layers/quest/questMenu.dart';
part 'layers/quest/attributeMenu.dart';
part 'layers/quest/itemMenu.dart';
part 'layers/quest/equip_menu.dart';
part 'layers/quest/spell_menu.dart';
part 'layers/quest/itemUsageDecisionMenu.dart';
part 'layers/quest/BuySellMenu.dart';
part 'layers/quest/BuyItemListMenu.dart';
part 'layers/quest/SellItemListMenu.dart';
part 'layers/quest/InnMenu.dart';
part 'layers/quest/People/Thing.dart';
part 'layers/quest/People/TreasureChest.dart';
part 'layers/quest/People/HeroSprite.dart';
part 'layers/quest/People/NPC.dart';
part 'layers/quest/People/HeroStats.dart';
part 'layers/quest/action/questAction.dart';
part 'layers/quest/action/FieldHealSpellAction.dart';
part 'layers/quest/action/HerbItemAction.dart';
part 'layers/quest/action/OutsideSpellAction.dart';
part 'layers/quest/action/RadiantSpellAction.dart';
part 'layers/quest/action/RepelSpellAction.dart';
part 'layers/quest/action/ReturnSpellAction.dart';
part 'CharacterSprite.dart';
part 'stats.dart';
part 'maps/MapData.dart';
part 'maps/overworldMap.dart';
part 'maps/domdora_town_map.dart';
part 'maps/garai_town_map.dart';
part 'maps/maira_town_map.dart';
part 'maps/mercado_town1_map.dart';
part 'maps/mercado_town2_map.dart';
part 'maps/mercado_town3_map.dart';
part 'maps/radotome_castle1_map.dart';
part 'maps/radotome_castle2_map.dart';
part 'maps/radotome_castle3_map.dart';
part 'maps/radotome_town_map.dart';
part 'maps/rimuldar_town_map.dart';
part 'layers/layer.dart';
part 'layers/NullLayer.dart';
part 'layers/menu/msgbox.dart';
part 'layers/menu/YesNoMsgBox.dart';
part 'layers/menu/DecisionBox.dart';
part 'layers/battle/battleMenu.dart';
part 'layers/battle/battleCmdMenu.dart';
part 'layers/battle/battleSpellMenu.dart';
part 'layers/battle/battleItemMenu.dart';
part 'layers/battle/Battler.dart';
part 'layers/battle/action/battleAction.dart';
part 'layers/battle/action/AtkAction.dart';
part 'layers/battle/action/FleeAction.dart';
part 'layers/battle/action/HurtSpell.dart';
part 'layers/battle/action/HealSpell.dart';
part 'layers/battle/action/StopSpell.dart';
part 'layers/battle/action/SleepSpell.dart';
part 'layers/battle/action/FireBreathSpell.dart';
part 'layers/battle/task/BattleTask.dart';
part 'layers/battle/task/shakingScreenTask.dart';
part 'layers/battle/task/blinkMonsterTask.dart';
part 'layers/battle/task/annotateTask.dart';
part 'layers/LayerManager.dart';
part 'MonsStats.dart';
part 'Request.dart';
part 'trigger.dart';
part 'item.dart';

void main() {
  new Game();
}

class Game extends LayerManager {
  CanvasElement canvas;
  CanvasRenderingContext2D canvasCtx;
  CanvasElement bgCanvas;
  CanvasRenderingContext2D bgCanvasCtx;
  CanvasElement guiCanvas;
  CanvasRenderingContext2D guiCanvasCtx;
  CanvasElement spriteCanvas;
  CanvasRenderingContext2D spriteCanvasCtx;
  
  var _prevTime = 0.0;
  
  GameState _gameState = null;
  GameState get gameState => _gameState;
  
  statusBar _statusBar = null;
  questMenu _questMenu = null;
  attributeMenu _attrMenu = null;
  
  MyAudioPlayer _audioPlayer = null;
  MyAudioPlayer get AudioPlayer => _audioPlayer;
  
  Game() 
  {
    canvas = query("#canvas");
    canvasCtx = canvas.context2D;
    bgCanvas = query("#bg_canvas");
    bgCanvasCtx = bgCanvas.context2D;
    guiCanvas = query("#gui_canvas");
    guiCanvasCtx = guiCanvas.context2D;
    spriteCanvas = query("#sprite_canvas");
    spriteCanvasCtx = spriteCanvas.context2D;
    
    window.onKeyDown.listen(keyboardDownHandler);
    window.onKeyUp.listen(keyboardUpHandler);
    
    _gameState = new GameState();
    
    List imgLoadingTasks = LoadImages();
    ASYNC.Future.wait(imgLoadingTasks).then((_)=> LoadAudio());
  }
  
  void startNewGame()
  {
    pushLayer(new MapLayer(this, new overworldMap()));
    //pushLayer(new MapLayer(this, MapData.createMapByName("RadotomeTown")));
    //pushLayer(new MapLayer(this, new RadotomeCastle1()));
    //pushLayer(new MapLayer(this, new RadotomeCastle2()));
    
    window.requestAnimationFrame(tick);
  }

  void LoadAudio() {
    _audioPlayer = new MyAudioPlayer(new ApplicationContext(readyCallback:() {
      startNewGame();
    }));
  }
  
  List LoadImages() 
  {
    ImageCache imgCache = new ImageCache();

    Map data = {"Overworld" : {"width": 160, "height": 224, "src": "res/overworld.png"},
                "TownImage" : {"width": 320, "height": 816, "src": "res/town_tiles.png"},
                "Characters": {"width": 256, "height": 160, "src": "res/characters.png"},
                "Fonts"     : {"width": 451, "height": 163, "src": "res/fonts.png"},
                "TileSet"   : {"width": 180, "height": 100, "src": "res/DQRes2.png"},
                "Grass"     : {"width": 128, "height": 112, "src": "res/bg/bg1.png"},
                "Forest"    : {"width": 128, "height": 112, "src": "res/bg/bg2.png"},
                "Mountain"  : {"width": 128, "height": 112, "src": "res/bg/bg3.png"},
                "Dessert"   : {"width": 128, "height": 112, "src": "res/bg/bg4.png"},
                "Swarm"     : {"width": 128, "height": 112, "src": "res/bg/bg5.png"},
                "Dg1"       : {"width": 128, "height": 112, "src": "res/bg/bg6.png"},
                "Grave"     : {"width": 128, "height": 112, "src": "res/bg/bg7.png"},
                "Dg2"       : {"width": 128, "height": 112, "src": "res/bg/bg8.png"},
                "Ruin"      : {"width": 128, "height": 112, "src": "res/bg/bg9.png"},
                "Castle1"   : {"width": 128, "height": 112, "src": "res/bg/bg10.png"},
                "Dg3"       : {"width": 128, "height": 112, "src": "res/bg/bg11.png"},
                "Castle2"   : {"width": 128, "height": 112, "src": "res/bg/bg12.png"},
                "M_Slimer"  :   {"width": 15, "height": 15, "src": "res/mons/slimer.gif"},
                "M_RedSlimer":  {"width": 15, "height": 15, "src": "res/mons/redslimer.gif"},
                "M_Drakeer" :   {"width": 29, "height": 23, "src": "res/mons/drakeer.gif"},
                "M_Ghost"   :   {"width": 32, "height": 36, "src": "res/mons/ghostr.gif"},
                "M_Magician":   {"width": 46, "height": 40, "src": "res/mons/magicianr.gif"},
                "M_Magidrakeer":   {"width": 29, "height": 23, "src": "res/mons/magidrakeer.gif"},
                "M_Skeletonr":   {"width": 38, "height": 48, "src": "res/mons/skeletonr.gif"},
                "M_Warlockr":   {"width": 46, "height": 40, "src": "res/mons/warlockr.gif"},
                "M_Wolfr":          {"width": 53, "height": 46, "src": "res/mons/wolfr.gif"},
                "M_Scorpionr":      {"width": 40, "height": 41, "src": "res/mons/scorpionr.gif"},
                "M_MetalScorpionr": {"width": 40, "height": 41, "src": "res/mons/metalscorpionr.gif"}};
               
    var tasks = [];
    for(String name in data.keys) {
      Map info = data[name];
      ImageElement imgElement = new Element.tag('img'); 
      imgElement.width = info["width"];
      imgElement.height = info["height"];
      imgElement.src = info["src"];
      imgCache.setImageElement(name, imgElement);
      
      tasks.add(imgElement.onLoad.first);
    }
    
    return tasks;
  }
  
  CanvasRenderingContext2D getCanvasCtx() 
  {
    return canvasCtx;
  }
  
  CanvasRenderingContext2D getGuiCanvasCtx() 
  {
    return guiCanvasCtx;
  }
  
  void tick(num time)
  {
    num delta = time - _prevTime;
    _prevTime = time;
   
    if (_requests.isNotEmpty) {
      for(Request r in _requests) {
        r.execute();
      }
      _requests = []; // clean all
    }
    
    if (_layers.isEmpty) {
      return;  
    }
    _layers.last.update(delta);
    _layers.last.draw(canvasCtx);
  
    //print(time);
    window.requestAnimationFrame(tick);
  }
  
  void keyboardDownHandler(KeyboardEvent e)
  {
    _layers.last.OnKeyboardDown(e);  
  }
  
  void keyboardUpHandler(KeyboardEvent e)
  {
    _layers.last.OnKeyboardUp(e); 
  }
  
  void SaveGameState() {
  }
  
  void LoadGameState() {
  }
}
