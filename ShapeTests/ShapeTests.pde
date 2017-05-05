final int windowWidth   = 1000,
          windowHeight  = 1000;

float thetaMax = radians(30);

final color red   = color(255,0,0),
            green = color(0,255,0),
            blue  = color(0,0,255);

final int nbAngleSteps = 60,
          pendulumStrokeWeight = 6,
          angleErrorCompensator = -5;

int       pAngle = 0,
          pAngleInc =  1,
          t0,
          ticksSinceChange = 0;
final float pendulumLength    = 750,
            pendulumMaxAngle = radians(30),
            radiusDisk       = pendulumLength * sin(pendulumMaxAngle),
            angleInc         = radians(180.0/nbAngleSteps),
            radiansEpsilon   = 0.0005;
PGraphics disk;

PShape arcL;
                    
void settings(){
  size(windowWidth,windowHeight,P3D);
}
void setup(){
  disk     = createGraphics(windowWidth,windowHeight,P3D);
  makeDisk(disk);
  imageMode(CENTER);
  arcL = createShape();
  arcLine(0,blue,arcL);
}


PShape arcLine(float a, color c, PShape s){
  //PShape s =  createShape();
  float oneDegRads = radians(1);
  s.beginShape();
  s.stroke(c);
  s.noFill();
  //s.rotateX(-PI/2.);
  s.rotateZ(a);
  for (float i= -thetaMax; i<= thetaMax;i+=oneDegRads){
    float x = -pendulumLength*sin(i),
          y = -pendulumLength*(1-cos(i));
  s.vertex(x,y,0);
  }
  s.endShape();
  return s;
}
void cam(){
  lights();
  camera(width/2.,
         height,
         100, //pendulumLength*.25,
         width/2.,
         height/2.,
         -00,
         0,
         1,
         0);
}

void displayDisk(float currentAngleXYPlane){
  pushMatrix();
  rotate(currentAngleXYPlane);
  image(disk,0,0);
  popMatrix();
}

void draw(){
  background(0);
  pushMatrix();      
  translate(width/2.0,height/2.0);
  displayDisk(0); //angleInc*count);
  //rotateZ(PI/6);
  shape(arcL);
  popMatrix();
  cam();
}

void makeDisk(PGraphics pg){
  pg.beginDraw();
  pg.pushMatrix();
  pg.translate(pg.width/2.,pg.height/2.);
  
  
  
  color cVec[] =  {red, 
                   red|green, 
                   green, 
                   green|blue, 
                   blue, 
                   red|blue};
  for (int i=0;i<nbAngleSteps;i++){
    //pg.rotate(angleInc);
    //pg.stroke(cVec[i%6]);
    PShape ss =  createShape();
    arcLine(i*angleInc,cVec[i%6], ss);
    
    pg.shape(ss);
    
  }
  
  pg.popMatrix();
  pg.endDraw();
}

  