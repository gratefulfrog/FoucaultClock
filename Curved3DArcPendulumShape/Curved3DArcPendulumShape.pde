final int windowWidth   = 1000,
          windowHeight  = 1000;

final int nbAngleSteps          = 60,
          pendulumStrokeWeight  = 6,
          diskStrokeWeight      = 2,
          angleErrorCompensator = -5;  // used to handle rounding error on angle of pendulum

// pendulum realism parameters
final float thetaMax = radians(30),
            L        = 3.15,
            G        = 9.8;  

// pendulum & disk motion params            
final float pendulumLength    = 750,
            pendulumMaxAngle = thetaMax,
            radiusDisk       = pendulumLength * sin(pendulumMaxAngle),
            angleInc         = radians(180.0/nbAngleSteps),
            radiansEpsilon   = 0.0005;

final color red   = color(255,0,0),
            green = color(0,255,0),
            blue  = color(0,0,255);

final color pendulumLineColor = green;

// timing for disk rotation
int       t0,
          ticksSinceChange = 0,
          count = 0;

float lastChangeTime = 0;

PShape    disk,
          pendulum;
                    
void settings(){
  size(windowWidth,windowHeight,P3D);
}
void setup(){
  shapeMode(CORNER);
  frameRate(100);
  
  disk = createShape(GROUP);
  arcDisk(disk);
  
  pendulum = pendulumLine();

  t0=millis();
}

PShape pendulumLine(){
  PShape s = createShape();
  s.beginShape(LINES);
  s.stroke(pendulumLineColor);
  s.strokeWeight(pendulumStrokeWeight);
  s.noFill();
  for (int i= 0; i< 2;i++){
    float x = 0,
          y = 0,
          z = pendulumLength*i;
  s.vertex(x,y,z);
  }
  s.endShape();
  return s;
}

PShape arcLine(float a, color c){
  final float oneDegRads = radians(1);
  PShape s = createShape();
  s.beginShape();
  s.stroke(c);
  s.strokeWeight(diskStrokeWeight);
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
  camera(// Camera postion: x,y,z
         width/2.,
         height/2.-mouseX*2,
         height/2.-mouseY*2,
         // camera target: x,y,z
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
  rotate(-currentAngleXYPlane);
  shape(disk); 
  popMatrix();
}

void  displayPendulum(float ang){
  pushMatrix();
  translate(0,0,-pendulumLength);
  rotateY(ang);
  shape(pendulum);
  popMatrix();
}

float thetaCur (float t){
  return thetaMax *sin(G*t/L);
}

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
  displayDisk(angleInc*count);
  float thetaC = thetaCur((millis()-t0)/1000.);
  displayPendulum(thetaC);
  popMatrix();
  cam();
  updateAngleCount(thetaC);
}