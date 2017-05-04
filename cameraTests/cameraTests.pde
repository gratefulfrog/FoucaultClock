final float thetaMax = radians(30),
            L = 3.2,//4,
            G = 9.8,
            maxEyeZ = 80*(height/2.0) / tan(PI/6.0);
            
PShape s;

int   t0,
      lastT;

float eyeZ;

boolean lastSign = false;

void setup() {
  size(1000, 800, P3D);  
  fill(0,255,255);
  stroke(0);
  eyeZ = maxEyeZ;
  shapeMode(CORNER);
  s = loadShape("pendulum_flat_y_axis.obj");
  t0 = millis();
  lastT=millis();
  frameRate(100);
}

float thetaCur (float t){
  return thetaMax *sin(G*t/L);
}

boolean positive(float f){
  return f >= 0;
}

void draw() {
  background(0);
  //ortho();
  lights();
  camera(// camera position:
        width/2.0, 
        4000, 
        eyeZ,
        // Camera pointing at position:
        width/2.0, 
        4000, 
        0, 
        // axis which is vertically upwards
         0,   // X
         1,   // Y
         0);  // Z
  
  int curT = millis();
  float thetaC = thetaCur((curT-t0)/1000.);
  if (positive(thetaC) != lastSign){
    println("Measured Period:",(curT-lastT)/1000., "seconds");
    lastSign = ! lastSign;
    lastT = curT;
  }

  pushMatrix();
  translate(width/2.0,0,0);
  rotateZ(thetaC);
  shape(s,0,0);
  popMatrix();
}