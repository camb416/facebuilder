
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
int bgcolor = 255;

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
  if (dots[nearestDot()].isActive) {
    dragState = 0;
    //println("erasing");
  } 
  else {
    dragState = 1;
  }
  if(javascript!=null) javascript.logToConsole("hello, world!");
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
    bytes_str += bytes[i]+"\n";
  }
  cpConsole(bytes_str);

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
    //if (isActive) {
    //  noStroke();
    //  fill(0);
    //} 
    //else {
    stroke(0);
    fill(255);

    //}
    ellipse(x, y, r, r);
    noStroke();
    fill(0);
    ellipse(x, y, (r)*curBrightness, (r)*curBrightness);
  }
  boolean getActive() {
    return isActive;
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

