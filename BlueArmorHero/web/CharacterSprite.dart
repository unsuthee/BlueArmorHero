part of DQ;

class CharacterSprite {
  
  var _animationSet = null;
  var _currentAnim = null;
  
  static int _duration = 500;
  
  //String get PositionStr => "${mapPx}:${mapPy}";
  static const String charSpriteDataJSON = '''
      {
      "Hero": {
        "WalkNorth": {
          "sprites": [[2,0],[3,0]]
        },
        "WalkSouth": {
          "sprites": [[0,0],[1,0]]
        },
        "WalkWest": {
          "sprites": [[6,0],[7,0]]
        },
        "WalkEast": {
          "sprites": [[4,0],[5,0]]
        }
      },

      "HeroWithPrincess": {
        "WalkNorth": {
          "sprites": [[10,0],[11,0]]
        },
        "WalkSouth": {
          "sprites": [[8,0],[9,0]]
        },
        "WalkWest": {
          "sprites": [[14,0],[15,0]]
        },
        "WalkEast": {
          "sprites": [[12,0],[13,0]]
        }
      },

      "Merchant": {      
        "WalkNorth": {
          "sprites": [[2,1],[3,1]]
        },
        "WalkSouth": {
          "sprites": [[0,1],[1,1]]
        },
        "WalkWest": {
          "sprites": [[6,1],[7,1]]
        },
        "WalkEast": {
          "sprites": [[4,1],[5,1]]
        }
      },
  
      "Soldier": {      
        "WalkNorth": {
          "sprites": [[10,1],[11,1]]
        },
        "WalkSouth": {
          "sprites": [[8,1],[9,1]]
        },
        "WalkWest": {
          "sprites": [[14,1],[15,1]]
        },
        "WalkEast": {
          "sprites": [[12,1],[13,1]]
        }
      },

      "Knight": {      
        "WalkNorth": {
          "sprites": [[2,2],[3,2]]
        },
        "WalkSouth": {
          "sprites": [[0,2],[1,2]]
        },
        "WalkWest": {
          "sprites": [[6,2],[7,2]]
        },
        "WalkEast": {
          "sprites": [[4,2],[5,2]]
        }
      },

      "Oldman": {      
        "WalkNorth": {
          "sprites": [[10,2],[11,2]]
        },
        "WalkSouth": {
          "sprites": [[8,2],[9,2]]
        },
        "WalkWest": {
          "sprites": [[14,2],[15,2]]
        },
        "WalkEast": {
          "sprites": [[12,2],[13,2]]
        }
      },

      "Man": {      
        "WalkNorth": {
          "sprites": [[2,3],[3,3]]
        },
        "WalkSouth": {
          "sprites": [[0,3],[1,3]]
        },
        "WalkWest": {
          "sprites": [[6,3],[7,3]]
        },
        "WalkEast": {
          "sprites": [[4,3],[5,3]]
        }
      },

      "Girl": {      
        "WalkNorth": {
          "sprites": [[10,3],[11,3]]
        },
        "WalkSouth": {
          "sprites": [[8,3],[9,3]]
        },
        "WalkWest": {
          "sprites": [[14,3],[15,3]]
        },
        "WalkEast": {
          "sprites": [[12,3],[13,3]]
        }
      },

      "Boy": {      
        "WalkNorth": {
          "sprites": [[2,4],[3,4]]
        },
        "WalkSouth": {
          "sprites": [[0,4],[1,4]]
        },
        "WalkWest": {
          "sprites": [[6,4],[7,4]]
        },
        "WalkEast": {
          "sprites": [[4,4],[5,4]]
        }
      },

      "Woman": {      
        "WalkNorth": {
          "sprites": [[10,4],[11,4]]
        },
        "WalkSouth": {
          "sprites": [[8,4],[9,4]]
        },
        "WalkWest": {
          "sprites": [[14,4],[15,4]]
        },
        "WalkEast": {
          "sprites": [[12,4],[13,4]]
        }
      },

      "Sage": {      
        "WalkNorth": {
          "sprites": [[2,5],[3,5]]
        },
        "WalkSouth": {
          "sprites": [[0,5],[1,5]]
        },
        "WalkWest": {
          "sprites": [[6,5],[7,5]]
        },
        "WalkEast": {
          "sprites": [[4,5],[5,5]]
        }
      },

      "King": {      
        "WalkNorth": {
          "sprites": [[10,5],[11,5]]
        },
        "WalkSouth": {
          "sprites": [[8,5],[9,5]]
        },
        "WalkWest": {
          "sprites": [[14,5],[15,5]]
        },
        "WalkEast": {
          "sprites": [[12,5],[13,5]]
        }
      },

      "Demon": {      
        "WalkNorth": {
          "sprites": [[2,6],[3,6]]
        },
        "WalkSouth": {
          "sprites": [[0,6],[1,6]]
        },
        "WalkWest": {
          "sprites": [[6,6],[7,6]]
        },
        "WalkEast": {
          "sprites": [[4,6],[5,6]]
        }
      },

      "HornSoldier": {      
        "WalkNorth": {
          "sprites": [[10,6],[11,6]]
        },
        "WalkSouth": {
          "sprites": [[8,6],[9,6]]
        },
        "WalkWest": {
          "sprites": [[14,6],[15,6]]
        },
        "WalkEast": {
          "sprites": [[12,6],[13,6]]
        }
      },

      "Adviser": {      
        "WalkNorth": {
          "sprites": [[2,7],[3,7]]
        },
        "WalkSouth": {
          "sprites": [[0,7],[1,7]]
        },
        "WalkWest": {
          "sprites": [[6,7],[7,7]]
        },
        "WalkEast": {
          "sprites": [[4,7],[5,7]]
        }
      },

      "Nan": {      
        "WalkNorth": {
          "sprites": [[10,7],[11,7]]
        },
        "WalkSouth": {
          "sprites": [[8,7],[9,7]]
        },
        "WalkWest": {
          "sprites": [[14,7],[15,7]]
        },
        "WalkEast": {
          "sprites": [[12,7],[13,7]]
        }
      },

      "Oldwoman": {      
        "WalkNorth": {
          "sprites": [[2,8],[3,8]]
        },
        "WalkSouth": {
          "sprites": [[0,8],[1,8]]
        },
        "WalkWest": {
          "sprites": [[6,8],[7,8]]
        },
        "WalkEast": {
          "sprites": [[4,8],[5,8]]
        }
      },

      "Fatman": {      
        "WalkNorth": {
          "sprites": [[10,8],[11,8]]
        },
        "WalkSouth": {
          "sprites": [[8,8],[9,8]]
        },
        "WalkWest": {
          "sprites": [[14,8],[15,8]]
        },
        "WalkEast": {
          "sprites": [[12,8],[13,8]]
        }
      },

      "Hunter": {      
        "WalkNorth": {
          "sprites": [[2,9],[3,9]]
        },
        "WalkSouth": {
          "sprites": [[0,9],[1,9]]
        },
        "WalkWest": {
          "sprites": [[6,9],[7,9]]
        },
        "WalkEast": {
          "sprites": [[4,9],[5,9]]
        }
      },

      "Princess": {      
        "WalkNorth": {
          "sprites": [[10,9],[11,9]]
        },
        "WalkSouth": {
          "sprites": [[8,9],[9,9]]
        },
        "WalkWest": {
          "sprites": [[14,9],[15,9]]
        },
        "WalkEast": {
          "sprites": [[12,9],[13,9]]
        }
      }
    }
    ''';
  
  static Map _spriteData = null;
  
  CharacterSprite(String characterName) {
    if (_spriteData == null) {
      _spriteData = JSON.parse(charSpriteDataJSON);
    }
    
    assert(_spriteData.containsKey(characterName));
    
    _animationSet = new Map<String,Animation>();
    setupAnimation(_spriteData[characterName]);
    assert(_animationSet != null);
    
    setAnimation(DEF.DIR_DOWN);
  }
  
  void setupAnimation(Map spriteData) {

    for (var id in spriteData.keys) {
      Animation anim = new Animation(name:id,loopBack:true);
      Map data = spriteData[id];
      for (var pos in data["sprites"]) {
        anim.AddSprite(new Sprite(sx:pos[0],sy:pos[1],src:"Characters"), _duration);  
      }
      _animationSet[id] = anim;
    }
  }

  void setAnimation(int direction) {
    switch (direction) {
      case DEF.DIR_LEFT:
        _currentAnim = _animationSet["WalkWest"];
        break;
      case DEF.DIR_UP:
        _currentAnim = _animationSet["WalkNorth"];
        break;
      case DEF.DIR_RIGHT:
        _currentAnim = _animationSet["WalkEast"];
        break;
      case DEF.DIR_DOWN:
        _currentAnim = _animationSet["WalkSouth"];
        break;
    }
  }
  
  void draw(CanvasRenderingContext2D ctx, {int px, int py, int size:DEF.TILE_SIZE}) {
    Sprite sp = _currentAnim.GetCurrentSprite();
    sp.draw(context:ctx,dx:px,dy:py,size:size);
  }
  
  void update(num delta) {
    _currentAnim.update(delta.toInt());
  }
}