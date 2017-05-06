
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

PGraphics disk,
          pendulum;
          
void settings(){
  size(windowWidth,windowHeight,P3D);
}
void setup(){
  pendulumLineColor = green;
  disk     = createGraphics(windowWidth,windowHeight,P3D);
  pendulum = createGraphics(windowWidth,windowHeight,P3D);
  makeDisk(disk);
  makePendulum(pendulum);
  imageMode(CENTER);
  t0=millis();
}

float thetaCur (float t){
  return thetaMax *sin(G*t/L);
}

void cam(){
  lights();
  camera(width/2.,
         height,
         500, //pendulumLength*.25,
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

void  displayPendulum(float ang){
  rotateX(-PI/2.);
  translate(0,-pendulumLength,0);
  rotateZ(ang);
  image(pendulum,0,0);
}

void draw(){
  background(0);
  // center the axes...
  pushMatrix();      
  translate(width/2.0,height/2.0);

  displayDisk(angleInc*count);
  float thetaC = thetaCur((millis()-t0)/1000.);
  displayPendulum(thetaC); 
  
  // return to normal axes
  popMatrix();
  
  cam();
  updateAngleCount(thetaC);
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
    pg.rotate(angleInc);
    pg.stroke(cVec[i%6]);
    //PShape s = pg.createShape();
    //arcLine(s,cVec[i%6]);
    pg.line(-radiusDisk,0,radiusDisk,0);
  }
  pg.popMatrix();
  pg.endDraw();
}

void makePendulum(PGraphics pg){
  // 2D drawing of the pendulum downwards!
  pg.beginDraw();
  pg.stroke(pendulumLineColor);
  pg.strokeWeight(pendulumStrokeWeight);
  pg.pushMatrix();
  pg.translate(pg.width/2.,pg.height/2.);  
  pg.line(0,0,0,pendulumLength);
  pg.popMatrix();
  pg.endDraw();
}