final int windowWidth   = 1000,
          windowHeight  = 1000;

final int nbAngleSteps = 60,
          pendulumStrokeWeight = 6,
          angleErrorCompensator = -5;

int       pAngle = 0,
          pAngleInc =  1,
          t0,
          ticksSinceChange = 0;
          
final float thetaMax = radians(30),
            L = 3.15,
            G = 9.8;  
            
final float pendulumLength    = 750,
            pendulumMaxAngle = radians(30),
            radiusDisk       = pendulumLength * sin(pendulumMaxAngle),
            angleInc         = radians(180.0/nbAngleSteps),
            radiansEpsilon   = 0.0005;

final color red   = color(255,0,0),
            green = color(0,255,0),
            blue  = color(0,0,255);

color pendulumLineColor;

PShape    disk;
PGraphics pendulum;
                    
void settings(){
  size(windowWidth,windowHeight,P3D);
}
void setup(){
  shapeMode(CORNER);
  //imageMode(CENTER);
  frameRate(100);
  disk = createShape(GROUP);
  arcDisk(disk);
  
  pendulum = createGraphics(windowWidth,windowHeight,P3D);
  pendulumLineColor = green;
  makePendulum(pendulum);
  
  t0=millis();
}

PShape arcLine(float a, color c){
  final float oneDegRads = radians(1);
  PShape s = createShape();
  s.beginShape();
  s.stroke(c);
  s.strokeWeight(4);
  s.noFill();
  s.rotate(a);
  for (float i= -thetaMax; i<= thetaMax;i+=oneDegRads){
    float x = -pendulumLength*sin(i),
          y = 0,
          z = -pendulumLength*(1-cos(i));
  s.vertex(x,y,z);
  }
  s.endShape();
  return s;
}

void arcDisk(PShape group){
  final color cVec[] =  {red, 
                         red|green, 
                         green, 
                         green|blue, 
                         blue, 
                         red|blue};
  for (int i=0;i<nbAngleSteps;i++){
    group.addChild(arcLine(i*angleInc,cVec[i%6]));
  }
}  

void cam(){
  lights();
  camera(// Camera x,y,z
         width/2.,
         height,
         height/2.-mouseY,
         // camera target x,y,z
         width/2.,
         height/2.,
         0,
         // camera upwards display axis x|y|z
         0,
         0,
         1);
}

void displayDisk(float currentAngleXYPlane){
  pushMatrix();
  rotate(currentAngleXYPlane);
  shape(disk); //arcDisk();
  popMatrix();
}
/*
int count = 0,
    lastRotTime = 0,
    rotTimeOut =  1000;
    
float getCurrentXYAngle(){
  int curTime =  millis();
  if (curTime-lastRotTime >=rotTimeOut){
    println(curTime-lastRotTime);
    lastRotTime=curTime;
    count++;
    
  }
  return count*angleInc;
}
*/
void  displayPendulum(float ang){
  //rotateX(-PI/2.);
  //translate(0,0,0);//-pendulumLength);
  rotateY(ang);
  image(pendulum,0,0);
}

float thetaCur (float t){
  return thetaMax *sin(G*t/L);
}

int count = 0;
float lastChangeTime = 0;
void   updateAngleCount(float a){
  if (++ticksSinceChange>=0 && abs(a) >= pendulumMaxAngle-radiansEpsilon){
    ticksSinceChange=angleErrorCompensator;
    count++;
    float delta = millis()/1000. - lastChangeTime;
    lastChangeTime += delta;
    println("Pendulum half-period:",delta,"seconds");
  }
}
void draw(){
  background(0);
  pushMatrix();      
  translate(width/2.0,height/2.0);
  //displayDisk(getCurrentXYAngle());
  displayDisk(angleInc*count);
  float thetaC = thetaCur((millis()-t0)/1000.);
  //displayPendulum(thetaC);
  stroke(blue);
  strokeWeight(6);
  //translate(0,0,pendulumLength);
  //rotateY();
  image(pendulum,0,0);
  line(0,0,0,0,0,-pendulumLength);
  popMatrix();
  cam();
  updateAngleCount(thetaC);
}

void makePendulum(PGraphics pg){
  // 2D drawing of the pendulum downwards!
  pg.beginDraw();
  pg.stroke(pendulumLineColor);
  pg.strokeWeight(pendulumStrokeWeight);
  //pg.pushMatrix();
  //pg.translate(pg.width/2.,pg.height/2.,0);  
  //pg.line(0,0,0,0,0,pendulumLength);
  pg.line(0,0,0,0,0,-pendulumLength);
  //pg.popMatrix();
  pg.endDraw();
}