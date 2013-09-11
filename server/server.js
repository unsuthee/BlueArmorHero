var http = require('http'),
	sys = require('sys');
	
var http = require("http");
var url = require("url");

function start(route, handle) {
	function onRequest(request, response) {
		var pathname = url.parse(request.url).pathname;
		console.log("Request for " + pathname + " received.");

		var query = url.parse(request.url).query;
		console.log("Query is " + query);
		
		route(handle, pathname, query, response, request);
	}
	http.createServer(onRequest).listen(8888);
	console.log("Server has started.");
}

exports.start = start;





