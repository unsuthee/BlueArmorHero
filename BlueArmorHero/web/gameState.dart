part of DQ;

class GameState {
  
  // Attributes
  HeroStats _stats;
  HeroStats get Stats => _stats;
  
  String get heroName => _stats.name;
  int get heroHP => _stats.HP;
  int get heroMP => (_stats.Level < 3)? 0: _stats.MP;
  int get heroMaxHP => _stats.MaxHP;
  int get heroMaxMP => (_stats.Level < 3)? 0: _stats.MaxMP;
  int get heroLevel => _stats.Level;
  int get heroGold => _stats.Gold;
  int get heroSTR => _stats.STR;
  int get heroAGI => _stats.AGI;
  int get heroATK => _stats.ATK;
  int get heroDEF => _stats.DEF;
  int get heroEXP => _stats.EXP;
  int get heroNextLV => _stats.NextLV;
  
  String get heroWeapon => _stats.currentWeapon.name;
  String get heroArmor => _stats.currentArmor.name;
  String get heroShield => _stats.currentShield.name;

  // Equipments
  GameState() {
    _stats = new HeroStats("Suthee");
    AddItem(stats.ItemData["Wings"]);
    AddItem(stats.ItemData["Wings"]);
    AddItem(stats.ItemData["Herb"]);
    AddItem(stats.ItemData["Herb"]);
    AddItem(stats.ItemData["Herb"]);
    AddItem(stats.WeaponData["Erdrick's Sword"]);
    AddItem(stats.ArmorData["Erdrick's Armor"]);
    AddItem(stats.ShieldData["Silver Shield"]);
    _stats.Equip(stats.WeaponData["Erdrick's Sword"]);
    _stats.Equip(stats.ArmorData["Erdrick's Armor"]);
    _stats.Equip(stats.ShieldData["Silver Shield"]);
  }
      
  HeroBattler createHeroBattler() {
    return new HeroBattler(heroName, 
        STR:heroSTR, AGI:heroAGI, ATK:heroATK, DEF:heroDEF,
        Hp:heroHP, Mp:heroMP, MaxHp:heroMaxHP, MaxMp:heroMaxMP, XP:heroEXP);
  }
  
  List getBattleSpells() {
    List spells = [];
    for (String spell in stats.BattleSpellTable.keys) {
      if (stats.BattleSpellTable[spell][0] <= heroLevel) {
        spells.add(spell);
      }
    }
    return spells;
  }
  
  List getFieldSpell() {
    List spells = [];
    for (String spell in stats.FieldSpellTable.keys) {
      if (stats.FieldSpellTable[spell][0] <= heroLevel) {
        spells.add(spell);
      }
    }
    return spells;
  }
  
  // Items / Inventory
  int _inventoryCapacity = 8;
  int get InventoryCapacity => _inventoryCapacity;
  
  List<Item> _inventory = [];
  List<Item> get Inventory => _inventory;
  
  bool isInventoryFull() {
    return (_inventory.length >= _inventoryCapacity);
  }
  bool AddItem(Item item) {
    if (_inventory.length >= _inventoryCapacity) {
      return false;
    }
    _inventory.add(item);
  }
  void RemoveItem(Item item) {
    _inventory.remove(item);  
  }
  
  Map toJSON() {
    return {"Stat": _stats.toJSON(),
            "Inventory": ["Herb"]};
  }
}