/* 
 * dart document.cookie lib
 *
 * ported from
 * http://www.quirksmode.org/js/cookies.html
 *
 */
part of DQ;

class Cookie {
  static _readCookie() {
    var cookie = new Map();
    var c = document.cookie;
    print('Readed Cookie:${c}');
    c.split(';').forEach((t) {
      var k = t.indexOf('=');
      if (k > 0)
      {
        cookie[Uri.decodeComponent(t.substring(0, k))] = Uri.decodeComponent(t.substring(k + 1));
      }
    });
    return cookie;
  }

  static _writeCookie(Map m) {
  }

  static void setCookie(String name, String value, int days) {
    var t = _readCookie();
    t[name] = Uri.encodeComponent(value);

    DateTime now = new DateTime.now();
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(now.millisecondsSinceEpoch + days*24*60*60*1000);
    t['expires'] = date.toString();
    
    String sb = "${name}=${t[name]}; expires=${t['expires']}; path=/";
    document.cookie = sb;
    print("cookie now:${document.cookie}");
  }

  static String getCookie(String name) {
    var t = _readCookie();
    if (t.containsKey(name))
      return t[name];
    return null;
  }
}
