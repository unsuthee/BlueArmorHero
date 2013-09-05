part of DQ;

class Item {
  
  String _name;
  String get name => _name;
  
  bool _isEquip;
  bool get IsEquip => _isEquip;
  
  int _cost;
  int get cost => _cost;
  
  int power() => 0;
  int defence() => 0;
  
  Item(String name, {int cost:0}) {
    _name = name;
    _isEquip = false;
    _cost = cost;
  }
  
  void Equip() {
  }
  
  void UnEquip() {
  }

  void Use() {
    
  }
  
  String getType() {
    return "Item";
  }
  
  bool compare(Item other) {
    if (getType() != other.getType()) 
      return false;
    return (name == other.name);
  }
}

class Weapon extends Item {
  
  int _pow;
  int get pow => _pow;
  
  int power() => _pow;
  
  Weapon(String name, {int cost:0, int pow:0}): super(name,cost:cost) {
    _pow = pow;
  }

  String getType() {
    return "Weapon";
  }
  
  void Equip() {
    _isEquip = true;
  }

  void UnEquip() {
    _isEquip = false;
  }
}

class Armor extends Item {

  int _def;
  int get def => _def;
  
  int defence() => _def;
  
  Armor(String name, {int cost:0, int def:0}): super(name,cost:cost) {
    _def = def;
  }
  
  String getType() {
    return "Armor";
  }
  
  void Equip() {
    _isEquip = true;
  }

  void UnEquip() {
    _isEquip = false;
  }
}

class Shield extends Item {
  
  int _def;
  int get def => _def;
  
  int defence() => _def;
  
  Shield(String name, {int cost:0, int def:0}): super(name,cost:cost) {
    _def = def;
  }
  
  String getType() {
    return "Shield";
  }
  
  void Equip() {
    _isEquip = true;
  }

  void UnEquip() {
    _isEquip = false;
  }
}