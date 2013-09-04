part of DQ;

class HeroStats {
  
  HeroStats(String heroName) {
    _name = heroName;
    initAttributeByName(heroName);
    initEquipment();
  }

  void initAttributeByName(String heroName) {
    
    var rng = new MATH.Random();
    int group = rng.nextInt(16);
    
    // STR,AGI,Max HP, Max MP, Growth
    var initStats = {
      "0": [3,3,15,5,0],
      "1": [4,3,15,4,1],
      "2": [3,4,13,5,2],
      "3": [4,4,15,5,3],
      "4": [4,4,15,5,0],
      "5": [4,4,15,5,1],
      "6": [4,4,14,5,2],
      "7": [4,4,14,5,3],
      "8": [5,5,15,5,0],
      "9": [4,5,15,6,1],
      "10": [5,4,15,5,2],
      "11": [4,4,15,6,3],
      "12": [6,6,15,5,0],
      "13": [4,6,15,7,1],
      "14": [6,4,16,5,2],
      "15": [4,4,16,7,3]
    };
    
    var initVal = initStats[group.toString()];
    _HP = initVal[2];
    _MP = initVal[3];
    _MaxHP = initVal[2];
    _MaxMP = initVal[3];
    _STR = initVal[0];
    _AGI = initVal[1];
    _Level = 1;
    Gold = 0;
    _EXP = 0;
    _NextLV = 7;
    
    _growType = initVal[4];
  }
  
  // Equipments
  Weapon emptyWeapon = stats.WeaponData["Nothing"];
  Armor emptyArmor = stats.ArmorData["Nothing"];
  Shield emptyShield = stats.ShieldData["Nothing"];
  
  Weapon currentWeapon = null;
  Armor  currentArmor = null;
  Shield currentShield = null;
  void initEquipment() {
    currentWeapon = emptyWeapon;
    currentArmor = emptyArmor;
    currentShield = emptyShield;
  }
  
  Item Equip(Item item) {
    Item unequipItem = null;
    currentWeapon.UnEquip();
    switch(item.getType()) {
      case "Weapon":
        unequipItem = currentWeapon;
        currentWeapon = item;
        break;
      case "Armor":
        unequipItem = currentArmor;
        currentArmor = item;
        break;
      case "Shield":
        unequipItem = currentShield;
        currentShield = item;
        break;
    }
    currentWeapon.Equip();
    return unequipItem;
  }
 
  Item UnEquip(String type) {
    switch (type) {
      case "Weapon":
        currentWeapon.UnEquip();
        currentWeapon = emptyWeapon;
        break;
      case "Armor":
        currentArmor.UnEquip();
        currentArmor = emptyArmor;
        break;
      case "Shield":
        currentShield.UnEquip();
        currentShield = emptyShield;
        break;
    }
  }
  
  static Map additionalGrowth = {
    "1": [0, 0, 0, 0, 0, 0, 0, 0],
    "2": [1, 1, 0, 0, 7, 6, 0, 0],
    "3":[3,3,2,2,9,8,0,0],
    "4":[3,3,4,4,16,14,11,10],
    "5":[8,7,6,6,20,18,15,14],
    "6":[12,11,6,6,23,21,19,17],
    "7":[14,13,13,12,25,23,21,19],
    "8":[18,16,16,15,31,28,24,22],
    "9":[26,24,18,16,35,32,31,28],
    "10":[31,28,27,24,39,35,35,32],
    "11":[36,33,31,28,47,42,45,41],
    "12":[44,40,36,33,48,43,53,48],
    "13":[48,43,44,40,55,50,59,53],
    "14":[56,51,51,46,63,57,65,59],
    "15":[64,58,60,54,71,64,67,60],
    "16":[68,61,66,60,77,69,90,81],
    "17":[68,61,74,67,85,77,95,86],
    "18":[81,73,80,72,100,90,103,93],
    "19":[83,75,82,74,115,104,110,99],
    "20":[88,79,84,76,123,111,123,111],
    "21":[91,82,86,78,134,121,130,117],
    "22":[93,84,86,78,143,129,141,127],
    "23":[95,86,90,81,150,135,148,133],
    "24":[99,89,94,85,155,140,156,140],
    "25":[109,98,96,87,159,143,156,140],
    "26":[113,102,101,91,165,149,163,148],
    "27":[121,109,103,93,174,157,170,153],
    "28":[126,114,111,100,180,162,175,158],
    "29":[131,118,116,105,185,167,185,167],
    "30":[136,123,126,114,195,176,195,176] };
  
  // Return true if the level is up
  bool IncrementEXP(int value) {
    if (_Level >= 30) 
      return false;
    
    _EXP += value;
    _NextLV -= value;
    if (_EXP >= stats.ExpTable[Level+1]) {
      _Level += 1;
      OnLevelUp();
      if (_Level < 30) {
        _NextLV = stats.ExpTable[Level+1] - _EXP;
      }
      else {
        _NextLV = 0;
      }
      return true;
    }
    return false;
  }
  
  // call this upon level is up
  List OnLevelUp() {
    
    var growth;
    switch(_growType) {
      case 0: growth = [0,1,0,1]; break;
      case 1: growth = [1,0,1,0]; break;
      case 2: growth = [0,0,1,1]; break;
      case 3: growth = [1,1,0,0]; break;
    }

    List values = [0,0,0,0];
    String k = "${Level}";
    String prevLevel = "${Level-1}";
    assert(additionalGrowth.containsKey(prevLevel));
    
    if(additionalGrowth.containsKey(k)) {
      var gval = additionalGrowth[k];
      var prevGval = additionalGrowth[prevLevel];
      
      var indices = [growth[0],2+growth[1],4+growth[2],6+growth[3]];
      values = [gval[indices[0]]-prevGval[indices[0]],gval[indices[1]]-prevGval[indices[1]],gval[indices[2]]-prevGval[indices[2]],gval[indices[3]]-prevGval[indices[3]]];
      _STR  += values[0];
      _AGI  += values[1];
      _MaxHP += values[2];
      _MaxMP += values[3];
    }
    return values;
  }
  
  String _name;
  String get name => _name;
  
  int _growType;
  
  int _STR;
  int get STR => _STR;
  
  int _AGI;
  int get AGI => _AGI;
  
  int get ATK => STR + currentWeapon.pow;
  int get DEF => AGI + currentArmor.def + currentShield.def;
  
  int _EXP;
  int get EXP => _EXP;
  
  int _NextLV;
  int get NextLV => _NextLV;
  
  int _Level;
  int get Level => _Level;
  
  int _HP;
  int _MP;
  int _MaxHP;
  int _MaxMP;
  int get HP => _HP;
  int get MP => _MP;
  int get MaxHP => _MaxHP;
  int get MaxMP => _MaxMP;
  
  void set HP(int v) {
    _HP = v;
  }
  
  void set MP(int v) {
    _MP = v;
  }
  
  int Gold;
}