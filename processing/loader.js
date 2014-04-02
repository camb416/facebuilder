var pjs;
var canvasid = "sketch";
var sourcedir = "";
var sourcefiles = ["facebuilder.pde"];
var sourcecode = "";

// IE Unfriendly xhr Method
function ajaxget(url) {
	var xhr = new window.XMLHttpRequest();
	if (xhr) {
		xhr.open("GET", url, false);
		xhr.send(null);
		return xhr.responseText; }
	else { return false; }}

function loadSourceCode() {
	if(sourcecode == "") {
		for (var j=0, fl=sourcefiles.length; j<fl; j++) {
			var sourcefile = sourcefiles[j];
			if (sourcefile) { sourcecode += ajaxget(sourcedir + sourcefile) + ";\n"; }}}}

function loadPJS() {
	loadSourceCode();
	var canvas = document.getElementById(canvasid);
	Processing.addInstance(new Processing(canvas, sourcecode));
	pjs = Processing.getInstanceById(canvasid);
	pjs.setJavaScript(this); }

setTimeout("loadPJS()", 1000);

