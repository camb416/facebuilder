/**
 * Update the log with some text
 */
 function updateLog(text) {
 	var e = document.getElementById('log');
 	if(e) { e.innerHTML = text + "<br/>\n"; }}

/**
 * change the border width for the <canvas> element
 */
 function setBorderThickness(thickness) {
 	var val = (1 + Math.abs(thickness)) + "px";
 	document.getElementById('sketch').style.borderWidth = val; }


// from http://processingjs.org/articles/PomaxGuide.html
function saveChar(id) {
	pjs = Processing.getInstanceById(id);
	var text = document.getElementById('inputtext').value;
	var varName = document.getElementById('inputtext').value;
	var data = pjs.getChar(); 

	var data_str = "";
	console.log(varName + " : "+data);

	if(jsonData.length>1){
		jsonData += ",\n"
	}
	jsonData += '"'+varName+'"'  + ' : "'+data+'"';
		document.getElementById("outputarea").innerHTML = jsonHeader+jsonData+jsonFooter;
	

}

function invertAll(){
	pjs.invertAll();
}
function reset(){
	pjs.setAll(false);
}

function changeBgColor(id) {
	pjs = Processing.getInstanceById(id);
	var r = Math.random()*255;
	var g = Math.random()*255;
	var b = Math.random()*255;
	pjs.changeBgColor(r,g,b); 
}


var bound = false;

function bindJavascript(){
	pjs = Processing.getInstanceById('fbsketch');
	if(pjs!=null){
		pjs.bindJavascript(this);
		bound = true;
	}
	if(!bound) setTimeout(bindJavascript, 250);
}

var jsonHeader = "{\n";
var jsonFooter = "\n}";
var jsonData = "";
var pjs;
bindJavascript();

function logToConsole(msg){
	console.log(msg);

}

