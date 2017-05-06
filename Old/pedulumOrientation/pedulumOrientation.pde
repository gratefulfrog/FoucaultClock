final int windowWidth   = 1000,
          windowHeight  = 1000;

final color red   = color(255,0,0),
            green = color(0,255,0),
            blue  = color(0,0,255);

color pendulumLineColor;

final float pendulumLength    = 750;

PGraphics pendulum;

void settings(){
  size(windowWidth,windowHeight,P3D);
}
void setup(){
  pendulum = createGraphics(windowWidth,windowHeight,P3D);
  pendulumLineColor = green;
  makePendulum(pendulum);
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
void draw(){
  background(0);
  pushMatrix();      
  translate(width/2.0,height/2.0);
  rotateX(PI/2.);
  rotateZ(radians(30));
  image(pendulum,0,-pendulumLength);
  // stroke(blue);
  // strokeWeight(6);
  //line(0,0,0,0,0,-pendulumLength);
  popMatrix();
  
  cam();
  }

void makePendulum(PGraphics pg){
  // 3D drawing of the pendulum downwards!
  pg.beginDraw();
  pg.stroke(pendulumLineColor);
  pg.strokeWeight(6);
  //pg.translate(0,-pendulumLength);
  pg.line(0,0,0,pendulumLength);
  pg.endDraw();
}