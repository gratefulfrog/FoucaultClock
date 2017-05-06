final int windowWidth   = 1500,
          windowHeight  = 1000;
          
final int showTime = 200;

int lastShowChange = 0;

SevenSegmentDisplay l,r,sl,sr;
Colon colon;

void settings(){
  size(windowWidth,windowHeight);
}
void setup(){
  frameRate(100);
  l =  new SevenSegmentDisplay(250,500,50);
  r =  new SevenSegmentDisplay(250,500,50);
  sl =  new SevenSegmentDisplay(50,100,10);
  sr =  new SevenSegmentDisplay(50,100,10);
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
void displaySeconds(int num, float x){
  sl.val(num/10);
  sr.val(num%10);
  pushMatrix();
  translate(x/2.-3*sl.w/2., 5*height/6. - sl.h/2.);
  sl.display();
  popMatrix();
  pushMatrix();
  translate(x/2. + 1*sr.w/2., 5*height/6. - sr.h/2.);
  sr.display();
  popMatrix();
}

void display2Digits(int num, float x){
  l.val(num/10);
  r.val(num%10);
  pushMatrix();
  translate(x/4.-l.w/2., height/2. - l.h/2.);
  l.display();
  popMatrix();
  pushMatrix();
  translate(3*x/4-r.w/2., height/2. - r.h/2.);
  r.display();
  popMatrix();
}

void draw(){
  background(0);
  display2Digits(hour(),width/2.-colon.w);
  pushMatrix();
  translate(width/2.-colon.w/2., height/2. - colon.w*2.);
  colon.display();
  popMatrix();
  pushMatrix();
  translate(width/2.+colon.w,0);
  display2Digits(minute(),width/2.-colon.w);
  popMatrix();
  displaySeconds(second(),width);
}