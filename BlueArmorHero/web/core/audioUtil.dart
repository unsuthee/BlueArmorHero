/**
 * The original code is taken from https://github.com/dart-lang/dart-samples
 */

part of DQ;

typedef void OnLoadCallback(List<AudioBuffer> bufferList);

class BufferLoader {
  AudioContext audioCtx;
  List<String> urlList;
  OnLoadCallback callback;
  int _loadCount = 0;
  List<AudioBuffer> _bufferList;

  BufferLoader(this.audioCtx, this.urlList, this.callback) {
    _bufferList = new List<AudioBuffer>(urlList.length);
  }

  void load() {
    for (var i = 0; i < urlList.length; i++) {
      _loadBuffer(urlList[i], i);
    }
  }

  void _loadBuffer(String url, int index) {
    // Load the buffer asynchronously.
    var request = new HttpRequest();
    request.open("GET", url, async: true);
    request.responseType = "arraybuffer";
    //request.onLoad.listen((e) => _onLoad(request, url, index));
    request.onLoad.listen((Event e) {
      _onLoad(request, url, index);
    });
    
    // Don't use alert in real life ;)
    request.onError.listen((e) => window.alert("BufferLoader: XHR error"));

    request.send();
  }

  void _onLoad(HttpRequest request, String url, int index) {
    // Asynchronously decode the audio file data in request.response.
    audioCtx.decodeAudioData(request.response).then((AudioBuffer buffer) {
      if (buffer == null) {

        // Don't use alert in real life ;)
        window.alert("Error decoding file data: $url");

        return;
      }
      _bufferList[index] = buffer;
      if (++_loadCount == urlList.length) callback(_bufferList);
    });
  }
}

typedef void readyCallback();

class ApplicationContext {
  // Keep track of all loaded buffers.
  Map<String, AudioBuffer> buffers;

  // Page-wide AudioContext.
  AudioContext audioCtx;
  
  readyCallback _callback;
  
  var buffersToLoad = {
    "Castle"    : "${DEF.MusicPathname}03.ogg",
    "Village"   : "${DEF.MusicPathname}04.ogg",
    "World"     : "${DEF.MusicPathname}05.ogg",
    "Battle"    : "${DEF.MusicPathname}06.ogg",
    "Victory"   : "${DEF.MusicPathname}18.ogg"
  };
  
  ApplicationContext({readyCallback:null}) {
    _callback = readyCallback;
    buffers = new Map<String, AudioBuffer>();
    audioCtx = new AudioContext();
    _loadBuffers();
  }

  // Loads all sound samples into the buffers object.
  void _loadBuffers() {
    List<String> names = buffersToLoad.keys.toList();
    List<String> paths = buffersToLoad.values.toList();
    var bufferLoader = new BufferLoader(audioCtx, paths, (List<AudioBuffer> bufferList) {
      for (var i = 0; i < bufferList.length; i++) {
        AudioBuffer buffer = bufferList[i];
        String name = names[i];
        buffers[name] = buffer;
      }
      if (_callback != null) {
        _callback();
      }
    });
    bufferLoader.load();
  }
}

class MyAudioPlayer {
  bool _playing = false;
  ApplicationContext appCtx;
  AudioBufferSourceNode _source = null;

  String _currentSong = "";
  String get CurrentSong => _currentSong;
  
  MyAudioPlayer(this.appCtx) {
  }

  void play(String song, {bool loop:true}) {
    if (appCtx == null) {
      return;
    }
    
    if (!appCtx.buffers.containsKey(song)) {
      return;
    }
    
    _currentSong = song;
    
    // Create the source.
    _source = appCtx.audioCtx.createBufferSource();
    _source.buffer = appCtx.buffers[song];

    // Connect everything.
    _source.connectNode(appCtx.audioCtx.destination, 0, 0);

    // Play!
    _source.start(0);
    _source.loop = loop;
  }

  void stop() {
    if (appCtx == null) {
      return;
    }
    
    if (_source != null) {
      _source.stop(0);
    }
  }

  void toggle() {
    _playing ? stop() : play(_currentSong);
    _playing = !_playing;
  }
}
