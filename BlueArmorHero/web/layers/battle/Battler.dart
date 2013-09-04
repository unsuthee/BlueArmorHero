part of DQ;

typedef BattleAction OnGetActionHandler(Battler atk, Battler def);

class Battler {
  
  String _name;
  String get name => _name;
  
  int _STR;
  int get Strength => _STR;
  
  int _ATK;
  int get Attack => _ATK;
  
  int _DEF;
  int get Defence => _DEF;
  
  int _AGI;
  int get Agility => _AGI;
  
  int _CriticalHitChance = 32;
  int get CritChance => _CriticalHitChance;
  
  int _DodgeChance;
  int get DodgeChance => _DodgeChance;
  
  int _HURT_RESIST;
  int _STOP_RESIST;
  int _SLEEP_RESIST;
  int get HurtResist => _HURT_RESIST;
  int get StopResist => _STOP_RESIST;
  int get SleepResist => _SLEEP_RESIST;
  
  int _EXP;
  int get Exp => _EXP;
  void set Exp(int v) {
    _EXP = v;
  }
  
  int _GP;
  int get Gp => _GP;
  
  bool _HasMagicArmor;
  bool get HasMagicArmor => _HasMagicArmor;
  
  num _GroupFactor;
  num get GroupFactor => _GroupFactor;
  
  bool _isDragonLord;
  bool get IsDragonLord => _isDragonLord;
  
  bool _isGolem;
  bool get IsGolem => _isGolem;
  
  bool _isSleeping;
  bool get IsSleeping => _isSleeping;
  void set IsSleeping(bool v) {
    _isSleeping = v;
    if (_isSleeping) {
      sleepingChance = 100;
    }
  }
  
  int sleepingChance = 100;
  
  bool _isStoping;
  bool get IsStoping => _isStoping;
  void set IsStoping(bool v) {
    _isStoping = v;
  }
  
  OnGetActionHandler _onGetActionHandler = null;
  void set GetActionHandler(OnGetActionHandler handler) {
    _onGetActionHandler = handler;
  }
  
  bool IsHero() => false;
  
  bool _isFlee = false;
  bool get IsFlee => _isFlee;
  void set IsFlee(bool v) { 
    _isFlee = v;
  }
  
  int _HP;
  int _MP;
  int _MaxHP;
  int _MaxMP;
  int get HP => _HP;
  int get MP => _MP;
  int get MaxHP => _MaxHP;
  int get MaxMP => _MaxMP;
  
  void decHP(int v) {
    int remainHP = _HP - v;
    _HP = MATH.min(MATH.max(remainHP, 0),_MaxHP);
  }
  
  void decMP(int v) {
    int remainMP = _MP - v;
    _MP = MATH.min(MATH.max(remainMP, 0),_MaxMP);
  }
  
  Battler(String name, {int STR, int AGI, int Crit:0, int Dodge, int Exp, int Gp,
    int hurtResist,
    int stopResist,
    int sleepResist,
    num grpFactor,
    int Hp,
    int MaxHp:0,
    int Mp:0,
    int MaxMp:0,
    int ATK:0,
    int DEF:0,
    bool magicArmor:false,
    bool golem:false,
    bool dragonLord:false,
    OnGetActionHandler getActionHandler:null}) {
    
    _name = name;
    _STR = STR;
    _AGI = AGI;
    _CriticalHitChance = Crit;
    _DodgeChance = Dodge;
    _EXP = Exp;
    _GP = Gp;
    
    if (ATK <= 0)
      _ATK = STR;
    else
      _ATK = ATK;
    
    if (DEF <= 0)
      _DEF = AGI;
    else
      _DEF = DEF;
    
    _HP = Hp;
    _MP = Mp;
    
    if (MaxHp == 0) 
      _MaxHP = _HP;
    else 
      _MaxHP = MaxHp;
    
    if (MaxMp == 0)
      _MaxMP = _MP;
    else
      _MaxMP = MaxMp;
    
    _HURT_RESIST = hurtResist;
    _STOP_RESIST = stopResist;
    _SLEEP_RESIST = sleepResist;
    
    _GroupFactor = grpFactor;
    _HasMagicArmor = magicArmor;
    _isGolem = golem;
    _isDragonLord = dragonLord;
    
    _isSleeping = false;
    _isStoping = false;
    
    _onGetActionHandler = getActionHandler;
  }
  
  BattleAction getAction(Battler atk, Battler def) {
    if (_onGetActionHandler != null) {
      return _onGetActionHandler(atk,def);
    }
    else {
      // atk only
      return new MonsterAtkAction(atk,def);
    }
  }
}

class HeroBattler extends Battler {
  
  HeroBattler(String name, {int STR, int AGI, int ATK:0, int DEF:0,
    int Hp,
    int MaxHp,
    int Mp,
    int MaxMp, 
    int XP,
    bool magicArmor:false}): 
        super(name,STR:STR,AGI:AGI,Crit:32,Dodge:0,Exp:XP,Gp:0,
              hurtResist:0,stopResist:0,sleepResist:0,
              grpFactor:1.0,
              ATK:ATK,
              DEF:DEF,
              Hp:Hp,
              MaxHp:MaxHp,
              Mp:Mp,
              MaxMp:MaxMp, 
              magicArmor:magicArmor,
              golem:false,
              dragonLord:false,
              getActionHandler:null) {
  }
  
  bool IsHero() => true;
  
  BattleAction getAction(Battler atk, Battler def) {
    return null;
  }
}