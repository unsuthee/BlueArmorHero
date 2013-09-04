part of DQ;

// http://www.gamefaqs.com/snes/564868-dragon-quest-i-and-ii/faqs/61640

class battleMenu extends Layer {
  
  Game _game = null;
  GameState _gameState = null;
  String _monster = null;
  String _background = null;
  
  bool _bgDirty = true;
  
  static const int dstPx = 192;
  static const int dstPy = 90;
  static const int srcWidth = 128;
  static const int srcHeight = 112;
  static const int dstWidth = srcWidth * 2;
  static const int dstHeight = srcHeight * 2;
  Rect bgRect = new Rect(dstPx-5, dstPy-5, dstWidth+10, dstHeight+10);
  
  // State
  static const String STATE_TEST = "Test_State";
  
  static const String STATE_BEGIN = "Begin_State";
  static const String STATE_FIRST_THINKING = "FirstThinking_State";
  static const String STATE_SECOND_THINKING = "SecondThinking_State";
  static const String STATE_PLAYER_WIN = "PlayerWin_State";
  static const String STATE_PLAYER_LOSE = "PlayerLose_State";
  static const String STATE_PLAYER_FLEE = "PlayerFlee_State";
  static const String STATE_MONS_FLEE = "MonsFlee_State";
  
  String _state = STATE_BEGIN;
  
  TextWriter2 _HpBarTextWriter = null;
  Rect HpbarBox = new Rect(32,32,122,160);
  
  int pad = 5;
  int gap = 1;
  
  HeroBattler _heroBattler = null;
  Battler _monsterBattler = null;
  HeroBattler get heroBattler => _heroBattler;
  Battler get monsBattler => _monsterBattler;
  
  List<Battler> _BattlersQueue = null;
  
  List<BattleTask> _tasks = [];
  
  var rng = new MATH.Random();
  
  battleMenu(Game game, {String background, String monster}) {
    _game = game;
    _gameState = game.gameState;
    _background = background;
    _monster = monster;
    
    _heroBattler = game.gameState.createHeroBattler();
    _monsterBattler = MonsterStats.createMonsterBattler(monster);
    
    _HpBarTextWriter = new TextWriter2(new Rect(  
        HpbarBox.left +pad+gap,
        HpbarBox.top+pad+gap,
        HpbarBox.width-pad-gap,
        HpbarBox.height-pad-gap));
    _HpBarTextWriter.AutoNewline = false;
    _HpBarTextWriter.color = DEF.COLOR_WHITE;
  }
  
  
  bool IsHeroStartFirst() {
    // HeroAgility * Random # < EnemyAgility * Random # * GroupFactor
    
    int heroOdd = rng.nextInt(255);
    int monsOdd = rng.nextInt(255);
    return (_heroBattler.Agility * heroOdd >= _monsterBattler.Agility * monsOdd * 0.25);
  }
  
  void dismiss() {
    _game.spriteCanvasCtx.clearRect(0,0,_game.spriteCanvas.width,_game.spriteCanvas.height); 
    _game.guiCanvasCtx.clearRect(0,0,_game.guiCanvas.width,_game.guiCanvas.height);
    _game.AddRequest(new PopRequest(_game));
    _game.AddRequest(new RedrawRequest(_game));
  }
 
  void clearBackground({num horzOffset:0}) {
    _game.spriteCanvasCtx.clearRect(bgRect.left+horzOffset, bgRect.top, bgRect.width, bgRect.height);
  }
  
  void drawBackground(CanvasRenderingContext2D ctx, {num horzOffset:0}) {
    ImageCache imgCache = new ImageCache();
    ImageElement img = imgCache.getImageElement(_background);
    
    assert(img != null);
    
    ctx.fillStyle = DEF.menuBorderColor;
    ctx.fillRect(bgRect.left+horzOffset, bgRect.top, bgRect.width, bgRect.height);
    ctx.drawImageScaled(img, dstPx+horzOffset, dstPy, img.width*2, img.height*2);
  }
  
  void drawMonster(CanvasRenderingContext2D ctx, {num horzOffset:0}) {
    ImageCache imgCache = new ImageCache();
    ImageElement img = imgCache.getImageElement(_monster);
    
    assert(img != null);
    
    num left = dstPx + (dstWidth >> 1) - img.width;
    num top = dstPy + dstHeight - (DEF.TILE_SIZE*2) - (img.height*2);
    ctx.drawImageScaled(img, left + horzOffset, top, img.width*2, img.height*2);
  }
  
  String formatNumber(int val) {
    if (val < 10) {// single digit
      return "  ${val}";
    }
    else if (val < 100) {
      return " ${val}";
    }
    else {
      return "${val}";
    }
  }
   
  void drawHPBar(CanvasRenderingContext2D ctx) {
    String heroName = _heroBattler.name;
    
    String statusMsg = "";
    if (_heroBattler.IsSleeping) {
      statusMsg += "#";
    }
    if (_heroBattler.IsStoping) {
      statusMsg += "@";
    }
    String msg = "${heroName} ;${statusMsg} " +
        ";HP:${formatNumber(_heroBattler.HP)} " +
        ";;MP:${formatNumber(_heroBattler.MP)} " +
        ";;Lv:${formatNumber(_gameState.heroLevel)}";
        
    _HpBarTextWriter.MessageToWrite = msg;
    ctx.clearRect(HpbarBox.left,HpbarBox.top,HpbarBox.width,HpbarBox.height); 
    ctx.fillStyle = DEF.menuBorderColor;
    ctx.fillRect( HpbarBox.left,HpbarBox.top,HpbarBox.width,HpbarBox.height);
    ctx.fillStyle = DEF.menuBGColor;
    ctx.fillRect( HpbarBox.left+pad, HpbarBox.top+pad, HpbarBox.width-pad-pad, HpbarBox.height-pad-pad);
    _HpBarTextWriter.WriteAll(ctx);
  }
  
  void draw(CanvasRenderingContext2D ctx) {
    
    if (_tasks.isNotEmpty) {
      if (!_tasks[0].isComplete()) {
        _tasks[0].draw(ctx);
      }
      return;
    }
    
    if (_bgDirty) {
      // background draw to the character canvas
      _game.spriteCanvasCtx.clearRect(bgRect.left, bgRect.top, bgRect.width, bgRect.height);
      drawBackground(_game.spriteCanvasCtx);
      if (_monsterBattler.HP > 0) {
        drawMonster(_game.spriteCanvasCtx);
      }
      _bgDirty = false;
    }
    
    switch(_state) {
      case STATE_BEGIN:
      {
        drawHPBar(_game.guiCanvasCtx);
        _state = STATE_FIRST_THINKING;
      }
      break;
      
      defaut:
        break;
    }
  }
  
  
  void PushCmdBox() {
    _game.AddRequest(new PushRequest(_game, new BattleCmdMenu(_game, this)));
  }
  
  void activate({Map<String,dynamic> args: null}) { 
    if (_state == STATE_FIRST_THINKING || _state == STATE_SECOND_THINKING) {
      if (args != null && args.containsKey("UserSelection")) {
        BattleAction action = args["UserSelection"];
        assert(action != null);
        _tasks.addAll(action.execute(_game, this));
        _state = (_state == STATE_FIRST_THINKING) ? STATE_SECOND_THINKING: STATE_BEGIN;
      }
    }
  }
  
  void deactivate({Map<String,dynamic> args: null}) {
  }

  void setDirty() {
    _bgDirty = true;  
  }
  
  void cleanup() {
  }
  
  bool IsSomeoneKO() {
    bool ko = false;
    if (_heroBattler.HP <= 0) {
      // Hero has lost the battle
      _state = STATE_PLAYER_LOSE;
      
      BattleTask tk = new AnnotateTask(_game,["You have lost the battle."]);
      _tasks.add(tk);
      
      ko = true;
    }
    else if (_monsterBattler.HP <= 0) {
      // Hero has won the battle
      _state = STATE_PLAYER_WIN;
      
      //_tasks.add(new BlinkMonsterTask(_game, this, dead: true));
      _tasks.add(new AnnotateTask(_game,["You have defeated ${_monsterBattler.name}."]));
      _tasks.add(new AnnotateTask(_game,["You have gained ${_monsterBattler.Exp} EXP and ${_monsterBattler.Gp} Gold."]));
      
      _game.gameState.Stats.HP = _heroBattler.HP;
      _game.gameState.Stats.MP = _heroBattler.MP;
      _game.gameState.Stats.Gold += _monsterBattler.Gp;
      
      // check if level up
      if (_game.gameState.Stats.IncrementEXP(_monsterBattler.Exp)) {
        List grows = _game.gameState.Stats.OnLevelUp();
        _tasks.add(new AnnotateTask(_game,["You have gained level ${_game.gameState.heroLevel}!"]));

        if (stats.SpellsTable.containsKey("${_game.gameState.heroLevel}")) {
          String spellName = stats.SpellsTable["${_game.gameState.heroLevel}"];
          _tasks.add(new AnnotateTask(_game,["Your have learned ${spellName}!"]));
        }
        
        if (grows[0] > 0)
          _tasks.add(new AnnotateTask(_game,["Your strength is incremented by ${grows[0]}."]));
        
        if (grows[1] > 0)
          _tasks.add(new AnnotateTask(_game,["Your agility is incremented by ${grows[1]}."]));
        
        if (grows[2] > 0)
          _tasks.add(new AnnotateTask(_game,["Your Max HP is incremented by ${grows[2]}."]));
        
        if (grows[3] > 0)
          _tasks.add(new AnnotateTask(_game,["Your Max MP is incremented by ${grows[3]}."]));
      }
      ko = true;
    }
    return ko;
  }
  
  bool IsSomeoneFlee() {
    if (_heroBattler.IsFlee) {
      _state = STATE_PLAYER_LOSE;
      return true;
    }
    else if (_monsterBattler.IsFlee) {
      _state = STATE_PLAYER_WIN;
      return true;
    }
    return false;
  }
  
  void update(num delta) {
    if (_tasks.isNotEmpty) {
      if (!_tasks[0].isComplete()) {
        _tasks[0].update(delta);
      }
      else {
        _tasks[0].end();
        _tasks.removeAt(0);
        if (_tasks.isNotEmpty) {
          _tasks[0].start();
        }
        else {
          drawHPBar(_game.guiCanvasCtx);
        }
      }
      return;
    }
    
    switch(_state) {
      case STATE_BEGIN:
      {
        // determine who will attack first
        if (IsHeroStartFirst()) {
          _BattlersQueue = [_heroBattler, _monsterBattler];
        }
        else {
          _BattlersQueue = [_monsterBattler, _heroBattler];
        }
      }
      break;

      case STATE_FIRST_THINKING:
      {
        if (IsSomeoneKO())
          break;
        
        if (IsSomeoneFlee())
          break;
        
        if (_BattlersQueue[0].IsSleeping) {
          // determine chance of sleeping
          if (rng.nextInt(100) < _BattlersQueue[0].sleepingChance) {
            // continue sleeping
            _BattlersQueue[0].sleepingChance = _BattlersQueue[0].sleepingChance ~/ 2;
            _tasks.add(new AnnotateTask(_game,["${_BattlersQueue[0].name} is sleeping!"]));
          }
          else {
            _tasks.add(new AnnotateTask(_game,["${_BattlersQueue[0].name} wakes up!"]));
          }
          _state = STATE_SECOND_THINKING;
        }
        else {
          if (_BattlersQueue[0].IsHero()) {
            PushCmdBox();
          }
          else {
            BattleAction action = _BattlersQueue[0].getAction(_BattlersQueue[0], _BattlersQueue[1]);
            _tasks.addAll(action.execute(_game, this));
            _state = STATE_SECOND_THINKING;
          }
        }
      }
      break;
      
      case STATE_SECOND_THINKING:
      {
        if (IsSomeoneKO())
          break;

        if (IsSomeoneFlee())
          break;
        
        if (_BattlersQueue[1].IsSleeping) {
          // determine chance of sleeping
          if (rng.nextInt(100) < _BattlersQueue[1].sleepingChance) {
            // continue sleeping
            _BattlersQueue[1].sleepingChance = _BattlersQueue[1].sleepingChance ~/ 2;
            _tasks.add(new AnnotateTask(_game,["${_BattlersQueue[1].name} is sleeping!"]));
          }
          else {
            _tasks.add(new AnnotateTask(_game,["${_BattlersQueue[1].name} wakes up!"]));
          }
          _state = STATE_SECOND_THINKING;
        }
        else {
          if (_BattlersQueue[1].IsHero()) {
            PushCmdBox();
          }
          else {
            BattleAction action = _BattlersQueue[1].getAction(_BattlersQueue[1], _BattlersQueue[0]);
            _tasks.addAll(action.execute(_game, this));
            _state = STATE_BEGIN;
          }
        }
      }
      break;
      case STATE_PLAYER_LOSE:
        dismiss();
        break;
        
      case STATE_PLAYER_WIN:
        dismiss();
        break;
      
      defaut:
        break;
    }
  }
 
  void OnKeyboardDown(KeyboardEvent e) {
    switch (e.keyCode)
    {
      case DEF.KEYBOARD_LEFT:
        break;
      case DEF.KEYBOARD_UP:
        break;
      case DEF.KEYBOARD_RIGHT:
        break;
      case DEF.KEYBOARD_DOWN:
        break;
      case DEF.KEYBOARD_PRIMARY:
        break;
      case DEF.KEYBOARD_SECONDARY:
        dismiss();
        break;
    }
  }
  
  void OnKeyboardUp(KeyboardEvent e) {
    switch (e.keyCode)
    {
      case DEF.KEYBOARD_LEFT:
        break;
      case DEF.KEYBOARD_UP:
        break;
      case DEF.KEYBOARD_RIGHT:
        break;
      case DEF.KEYBOARD_DOWN:
        break;
      case DEF.KEYBOARD_PRIMARY:
        break;
      case DEF.KEYBOARD_SECONDARY:
        break;
    }
  }
  
}