part of DQ;

typedef void OnActivateHandler({Map<String,dynamic> args});
typedef void OnPrimarySelectHandler(MsgBox self);

abstract class Layer {
  
  Layer() {
  }
  
  void activate({Map<String,dynamic> args: null}) {
  }
  
  void deactivate({Map<String,dynamic> args: null}) {
  }

  void setDirty() {
  }
  
  void cleanup() {
  }
  
  void draw(CanvasRenderingContext2D ctx) {
  }
  
  void update(num delta) {
  }
  
  void OnKeyboardDown(KeyboardEvent e) {
  }
  
  void OnKeyboardUp(KeyboardEvent e) {
  }
}