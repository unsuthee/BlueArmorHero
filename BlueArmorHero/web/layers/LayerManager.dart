part of DQ;

abstract class LayerManager extends Layer {
  List<Layer> _layers = [new NullLayer()];
  List<String> _bookmarks = ["Null"];
  
  List<Request> _requests = [];
  List<Layer> get layers => _layers;
  
  List<Request> get requests => _requests;
  
  CanvasRenderingContext2D getCanvasCtx();
  CanvasRenderingContext2D getGuiCanvasCtx();
  
  LayerManager() {
  }
  
  void AddRequest(Request req) {
    _requests.add(req);    
  }
  
  Layer pushLayer(Layer layer, {String bookmarkName:"", Map<String,String> pushParam: null}) {
    assert(bookmarkName != "Null"); // Null is a reserved name
    
    _layers.last.deactivate();
    layer.activate(args:pushParam);
    _layers.add(layer);
    _bookmarks.add(bookmarkName);
    return layer;
  }

  Layer popLayer({Map<String,dynamic> activateParams: null}) {
    Layer layer = _layers.removeLast();
    _bookmarks.removeLast();
    
    layer.deactivate();
    layer.cleanup();
    if (_layers.isNotEmpty) {
      _layers.last.activate(args:activateParams);  
    }
    return layer;
  }
  
  Layer popLayerUntil(String bookmarkName, {Map<String,dynamic> activateParams: null}) {
    Layer layer = null;
    while (_layers.isNotEmpty && _bookmarks.last != bookmarkName) {
      layer = _layers.removeLast();    
      layer.deactivate();
      layer.cleanup();
      _layers.last.activate(args:activateParams); 
    }
    return layer;
  }
  
  void RedrawLayer(CanvasRenderingContext2D ctx) {
    for (Layer layer in _layers) {
      layer.setDirty();
      layer.draw(ctx);
    }
  }
}
