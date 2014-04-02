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
function drawSomeText(id) {
	var pjs = Processing.getInstanceById(id);
	var text = document.getElementById('inputtext').value;
	pjs.drawText(text); 
}


function changeBgColor(id) {
	var pjs = Processing.getInstanceById(id);
	var r = Math.random()*255;
	var g = Math.random()*255;
	var b = Math.random()*255;
	pjs.changeBgColor(r,g,b); 
}


var bound = false;

function bindJavascript(){
	var pjs = Processing.getInstanceById('fbsketch');
	if(pjs!=null){
		pjs.bindJavascript(this);
		bound = true;
	}
	if(!bound) setTimeout(bindJavascript, 250);
}
bindJavascript();

function logToConsole(msg){
	console.log(msg);
}