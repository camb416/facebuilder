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
