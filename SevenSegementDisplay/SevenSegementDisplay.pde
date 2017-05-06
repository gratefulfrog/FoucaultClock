final int windowWidth   = 1000,
          windowHeight  = 1000;
          
final int showTime = 1000;

int lastShowChange = 0;

SevenSegmentDisplay l,r;
Colon colon;

void settings(){
  size(windowWidth,windowHeight);
}
void setup(){
  frameRate(100);
  l =  new SevenSegmentDisplay(250,500,50);
  r =  new SevenSegmentDisplay(250,500,50);
  colon = new Colon(50);
   lastShowChange = millis();
}

boolean timeUp(){
  int now = millis();
  if(now - lastShowChange >= showTime){
    lastShowChange = now;
    return true;
  }
  return false;
} 

void draw(){
  background(0);
  pushMatrix();
  translate(width/4.-l.w/2., height/2. - l.h/2.);
  l.display();
  popMatrix();
  pushMatrix();
  translate(width/2.-colon.w/2., height/2. - colon.w*2.);
  colon.display();
  popMatrix();
  pushMatrix();
  translate(3*width/4-r.w/2., height/2. - r.h/2.);
  r.display();
  popMatrix();
  
  //s.val(9);
  if (timeUp()){
    l.inc();
    r.dec();
  }
}