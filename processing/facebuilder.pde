Dot e;
int pageMargin = 20;
int margin;
int numCols;
int numRows;
int dotRadius = 20;
Dot[] dots;


void setup() {
  size(640, 480);
  margin = 5;
  numCols = 8;
  numRows = 8;

  dots = new Dot[numRows*numCols];
  for (int i=0;i<numRows*numCols;i++) {
    dots[i] = new Dot();
    int colNum = i%numCols;
    int rowNum = i/numCols;
    dots[i].x = colNum*dotRadius + colNum*margin; 
    dots[i].y = rowNum*dotRadius+rowNum*margin;
    dots[i].r = dotRadius;
  }
}
void draw() {
  update();

  for (int i=0;i<numRows*numCols;i++) {
    dots[i].update();
  }

  pushMatrix();
  translate(pageMargin, pageMargin);
  for (int i=0;i<numRows*numCols;i++) {
    dots[i].draw();
  }
  popMatrix();
  
  int nearDot = nearestDot();
  if(nearDot>-1){
   stroke(0);
    noFill();
  line(mouseX,mouseY,dots[nearDot].x,dots[nearDot].y);
  }
}

void update(){
  
}

int nearestDot(){
  float nearestVal = 9999;
  int nearestDot = -1;
    for (int i=0;i<numRows*numCols;i++) {
   float thisDist = dist(mouseX,mouseY,dots[i].x,dots[i].y);
   if(thisDist<nearestVal){
     nearestDot = i;
     nearestVal = thisDist;
   }
  }
  return nearestDot;

}

class Dot {
  float x, y, r;
  void setup() {
  }
  void update() {
  }
  void draw() {
    noStroke();
    fill(255);
    ellipse(x, y, r, r);
  }
}

