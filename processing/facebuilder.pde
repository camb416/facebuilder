/*
 * facebuilder v0.1
 */

Dot e;
int pageMargin = 20;
int margin;
int numCols;
int numRows;
int dotRadius = 20;
Dot[] dots;

int dragState;
// -1 : not dragging (mouse not down)
//  0 : erasing
//  1 : painting


int prevNearDot;


void setup() {
  println("setup");
  size(640, 480);
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
  background(255);


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
  } 
  else {
    dragState = 1;
  }
}
void mouseReleased() {
  dragState = -1;
}
void keyPressed() {
  print(key);
  switch(key) {
  case 'p':
  case 'P':
    outputValues();
    break;
  }
}

int nearestDot() {
  float nearestVal = 9999;
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
        bytes[i] += pow(2,j);
      } 
      else {
      //  print("0");
      }
    }
    //println("");
   // println(val);
  }
  println("");
  for(int i=0;i<numRows;i++){
   println(bytes[i]); 
  }
}

class Dot {
  float x, y, r;
  boolean isActive;
  void setup() {
    isActive = false;
  }
  void update() {
  }
  void draw() {
    if (isActive) {
      noStroke();
      fill(0);
    } 
    else {
      stroke(0);
      fill(255);
    }
    ellipse(x, y, r, r);
  }
  boolean getActive() {
    return isActive;
  }
}

