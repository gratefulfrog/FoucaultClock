
PShape s;

float eyeZ;
float inc = -1;

final int boxW = 200;
final float pointOneDegree = radians(0.1),
      maxEyeZ = 80*(height/2.0) / tan(PI/6.0);
float rot = 0,
      t=0;
int   t0,
      lastT;

boolean lastSign = false;

final float thetaMax = radians(30),
            L = 3.2,//4,
            G = 9.8;

void setup() {
  size(1000, 800, P3D);  
  fill(0,255,255);
  stroke(0);
  eyeZ = maxEyeZ;
  shapeMode(CORNER);
  s = loadShape("pendulum_flat.obj");
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
  
  lights();
 
 
  //pushMatrix();
  //translate(width/2., 10); //height/2.,0);
  //rotateX(PI/2.);
  //translate(0,0,-height/2.); 
  //rotateX(rot);
  int curT = millis();
  float thetaC = thetaCur((curT-t0)/1000.);
  if (positive(thetaC) != lastSign){
    println("Measured Period:",(curT-lastT)/1000., "seconds");
    lastSign = ! lastSign;
    lastT = curT;
  }
  //rotateY(thetaC);
  //t+=0.02;
  //rotateZ(rot);
  
  //translate(0,0,-4000); //height); 
  
  //translate(0,-4000,0);
  //rotateY(rot);
  //shape(s,0,0);
  //box(boxW);
  translate(width/2.0,0,0);
  rotateZ(PI/2.);
  shape(s,0,0);
  //
  /*
  inc = eyeZ >= maxEyeZ ? -1 
                                           : eyeZ <= boxW ? +1 
                                                         : inc;
  eyeZ += inc;
  */
  rot += pointOneDegree;
 // popMatrix();
  //camera(// camera position:
    //     /*mouseX, */ width/2.0, 
      //   height, 
        // eyeZ,
         // Camera pointing at position:
      //   /*mouseX, */width/2.0, 
  //       height, 
   //      0, 
         // axis which is vertically upwards
   //      0,   // X
    //     1,   // Y
    //     0);  // Z
  
}