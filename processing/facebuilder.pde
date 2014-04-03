
/*
 * facebuilder v0.3
 */

// -------------------------------------------
//               JAVASCRIPT INTERFACE
// -------------------------------------------

/**
 * this acts as a "header definition" for external javascript functions
 */
interface JavaScript {
  void logToConsole(String msg);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

// -------------------------------------------
//               MAIN SKETCH
// -------------------------------------------

Dot e;
int pageMargin = 20;
int margin;
int numCols;
int numRows;
int dotRadius = 20;
Dot[] dots;
int bgcolor = 0;

int dragState;
// -1 : not dragging (mouse not down)
//  0 : erasing
//  1 : painting


int prevNearDot;


void setup() {


  
  // println(javascript);

  size(240, 240);
  smooth();
  frameRate(60);
  margin = 5;
  numCols = 8;
  numRows = 8;
  dragState = -1;
  prevNearDot = -1;

  dots = new Dot[numRows*numCols];
  for (int i=0;i<numRows*numCols;i++) {
    dots[i] = new Dot();
    int colNum = i%numCols;
    int rowNum = floor(i/numCols);
    dots[i].x = colNum*dotRadius + colNum*margin+pageMargin; 
    dots[i].y = rowNum*dotRadius + rowNum*margin+pageMargin;
    dots[i].r = dotRadius;
  }
}
void draw() {

  update();


  for (int i=0;i<numRows*numCols;i++) {
    dots[i].update();
  }
  background(bgcolor);


  // pushMatrix();
  // translate(pageMargin, pageMargin);
  for (int i=0;i<numRows*numCols;i++) {
    dots[i].draw();
  }
  // popMatrix();

  int nearDot = nearestDot();

  if (nearDot>-1) {
    stroke(128);
    noFill();
    line(mouseX, mouseY, dots[nearDot].x, dots[nearDot].y);
  }
    for (int i=0;i<numRows*numCols;i++) {
    dots[i].drawFlash();
  }
}

void update() {
  int nearDot = nearestDot();
  if (nearDot>-1 && dragState!=-1) {
    if (dragState == 0) { 
      dots[nearDot].isActive = false;
    } 
    else { 
      dots[nearDot].isActive = true;
    }
    prevNearDot = nearDot;
  }
}

void mousePressed() {
  int nearDot = nearestDot();
  if(nearDot>-1){
  if (dots[nearDot].isActive) {
    dragState = 0;
    //println("erasing");
  } 
  else {
    dragState = 1;
  }
  }
  //if(javascript!=null) javascript.logToConsole("hello, world!");
}
void mouseReleased() {
  dragState = -1;
}
void keyPressed() {
  switch(key) {
  case 'p':
  case 'P':
    outputValues();
    break;
    case 'r':
    case 'R':
    setAll(false);
    break;
    case 'i':
    case 'I':
    invertAll();
    break;
  }
}

void invertAll(){
  for (int i=0;i<numRows*numCols;i++) {
     dots[i].isActive = !dots[i].isActive;
    }
}

void setAll(boolean val){
  
  for (int i=0;i<numRows*numCols;i++) {
     dots[i].isActive = (val);
    }
}

int nearestDot() {
  float nearestVal = margin+dotRadius;
  int nearestDot = -1;
  for (int i=0;i<numRows*numCols;i++) {
    float thisDist = dist(mouseX, mouseY, dots[i].x, dots[i].y);
    if (thisDist<nearestVal) {
      nearestDot = i;
      nearestVal = thisDist;
    }
  }
  return nearestDot;
}

void outputValues() {
  cpConsole(getChar());
}

String getChar(){
    int[] bytes = new int[numRows];

  for (int i=0;i<numRows;i++) {
    bytes[i] = 0;
    int val = 0;
    for (int j=0;j<numCols;j++) {
      if (dots[i*numCols+j].getActive()) {
        //print("1");
        bytes[i] += pow(2, j);
      } 
      else {
        //  print("0");
      }
    }
    //println("");
    // println(val);
  }

  String bytes_str = "";
  for (int i=0;i<numRows;i++) {
    //output bytes here
    //println(bytes[i]);
    bytes_str += hex(bytes[i], 2);
  }
  return bytes_str;
  
}

class Dot {
  float x, y, r;
  float curBrightness = 0.0;
  float destBrightness = 0.0f;
  boolean isActive;
  void setup() {
    isActive = false;
  }
  void update() {
    if (isActive) {
      destBrightness = 1.0;
    } 
    else {
      destBrightness = 0.0;
    }
    curBrightness += (destBrightness-curBrightness)/8.0;
  }
  void draw() {
// off state
    stroke(0);
    fill(32);
    //}
    ellipse(x, y, r+2, r+2);
    noStroke();
    fill(255,0,0);
    ellipse(x, y, (r)*curBrightness, (r)*curBrightness);
    fill(255,32,16);

    ellipse(x-2, y-2, (r/4)*curBrightness, (r/4)*curBrightness);
  }
  boolean getActive() {
    return isActive;
  }
  void drawFlash(){
   if(curBrightness>0.01 && curBrightness < 0.99 && curBrightness<destBrightness){
      noStroke();
      fill(255,255,255,32*(1.0-curBrightness));
      float flashR = (1.0-curBrightness)*50.0*r;
      ellipse(x,y,flashR,flashR);
   } 
   fill(255,0,0,128);
   noStroke();
   ellipse(x, y, (r)*curBrightness*1.2, (r)*curBrightness*1.2);
   fill(255,0,0,64);

   ellipse(x, y, (r)*curBrightness*1.4, (r)*curBrightness*1.4);
  }
}



// http://processingjs.org/articles/PomaxGuide.html
void drawText(String t) {
  background(#000033);
  // get the width for the text
  float twidth = textWidth(t);
  // place the text centered on the drawing area
  text(t, (width - twidth)/2, height/2);
  stop();
}
void changeBgColor(int r, int g, int b) {
  bgcolor = r;
}

