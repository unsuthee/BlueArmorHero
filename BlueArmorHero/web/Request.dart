part of DQ;

abstract class Request {
  void execute();
}

class PushRequest extends Request {
  
  LayerManager _game = null;
  Layer _pushLayer = null;
  Map<String,String> _params = null;
  
  PushRequest(LayerManager gm, Layer newLayer, {Map<String,String> params: null}) {
    _game = gm;
    _pushLayer = newLayer;
    _params = params;
  }
  
  void execute() {
    _game.pushLayer(_pushLayer,pushParam:_params);
  }
}

class PopRequest extends Request {
  LayerManager _game = null;
  Map<String,dynamic> _activateParams = null;
  
  PopRequest(LayerManager gm, {Map<String,dynamic> activateParams:null}) {
    _game = gm;
    _activateParams = activateParams;
  }
  
  void execute() {
    _game.popLayer(activateParams:_activateParams);
  }
}

class RedrawRequest extends Request {
  LayerManager _game = null;
  
  RedrawRequest(Game gm) {
    _game = gm;
  }
  
  void execute() {
    _game.RedrawLayer(_game.getCanvasCtx());
  }
}
