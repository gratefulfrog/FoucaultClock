
float eyeZ;
float inc = -1;

void setup() {
  size(1000, 800, P3D);
  fill(0,255,255);
  eyeZ = (height/2.0) / tan(PI/6.0);
}

void draw() {
  background(0);
  lights();
  camera(// camera position:
         mouseX, // width/2.0, 
         mouseY, //height/2.0, 
         eyeZ,
         // Camera pointing at position:
         mouseX, //width/2.0, 
         mouseY, //height/2.0, 
         0, 
         // axis which is vertically upwards
         0, 
         1, 
         0);
  translate(width/2, height/2, -100);
  stroke(0);
  //noFill();
  box(200);
  inc = eyeZ >= (height/2.0) / tan(PI/6.0) ? -1 
                                           : eyeZ <= 200 ? +1 
                                                         : inc;
  eyeZ += inc;
}