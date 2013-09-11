var querystring = require("querystring"),
	fs = require("fs");

function music(response, request, query) {
	console.log("Request handler 'music' was called.");
	
	var params = query.split("&");
	console.log("param = " + params);
	
	var m = {};
	for (var i = 0; i<params.length; i++) {
		var p = params[i].split("=");
		m[p[0]] = p[1];
	}
	
	if ("id" in m) {
		console.log("Begin streaming the song " + m["id"]);
		// 
		
		// Website you wish to allow to connect
		response.setHeader('Access-Control-Allow-Origin', '*');

		// Request methods you wish to allow
		response.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

		// Request headers you wish to allow
		response.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

		// Set to true if you need the website to include cookies in the requests sent
		// to the API (e.g. in case you use sessions)
		response.setHeader('Access-Control-Allow-Credentials', true);
		
		var filename = "../BlueArmorHero/web/res/music/" + m["id"];
		var readStream = fs.createReadStream(filename);
	
		readStream.on('open', function() {
			console.log("open is called");
			response.writeHead(200, {"Content-Type": "audio/ogg"});
			readStream.pipe(response);
		});
	
		readStream.on('error', function(err) {
			response.end(err);
		});
	}	
	else {
		console.log("Invalid param");
		response.writeHead(200, {"Content-Type": "text/html"});
		response.end();
	}
}

exports.music = music;


