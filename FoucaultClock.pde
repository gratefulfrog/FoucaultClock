
//FloatList corners;

ArrayList corners;
PGraphics  pg;

void setup(){
  size(1000,800,P3D);
  corners = new ArrayList();
  stroke(255);
  fill(255,0,0);
  background(0);
  frameRate(100);
  pg = createGraphics(1000, 800,P3D);
}

float K = 0.7,
      inc = radians(1.5),
      t=0,
      L=500,
      rt = 0,
      rtInc = radians(2.5),
      curX,
      curY,
      ccurX,
      ccurY;

boolean computed = false;

void draw(){
  if (!computed){
    computed=true;
    pushMatrix();
    translate(width/4.0,height/2.0-letterHeight/2.0);
    one(0,0);
    transSpace(letterWidth);
    zero(0,0);
    transSpace(2*letterWidth);
    zero(0,0);
    transSpace(2*letterWidth);
    zero(0,0);
    popMatrix();
    //println(lx,rx,uy,ly);
    background(0);
    
    camera(500.0,-200, 300.0, // eyeX, eyeY, eyeZ
       500.0, height/2.0, 20.0, // centerX, centerY, centerZ
      0.0, -1.0, 0.0);
    
  }
  pendule();
  //image(pg,0,0);
  //linear(width/2.,height/2.);
  foucault();
 }

void pendule(){
  //stroke(round(4*t)%256);
  float theta = K*cos(t);
  float x = 500+L*sin(theta),
        y = 100+L*cos(theta);
  //ccurX=x;
  //ccurY=y;
  t += inc;
  pg.beginDraw();
  pg.camera(500.0,-200, 300.0, // eyeX, eyeY, eyeZ
            500.0, height/2.0, 20.0, // centerX, centerY, centerZ
            0.0, -1.0, 0.0);
  pg.background(0);
  pg.stroke(255);
  pg.line (500,height/2.0,500,x,height/2.0,0);
  pg.endDraw();
  image(pg,0,0);  
}

float linear(float cx, float cy){
  float theta = K*cos(t);
  float x = cx+L*sin(theta),
        y = cy;
  curX=x;
  curY=y;
  if(drawIt()){
    fill(255,0,0);
    stroke(255,0,0);
  }
  else{
    fill(40,40,40);
    noStroke();
  }
  
  ellipse(x,y,5,5);
  
  t += inc;
  return theta/abs(theta);
}

int counter =0;
float lastSign = 1.0;
boolean rotated = false;

void foucault(){
  if (counter%2 ==0 && !rotated){
    rt+=rtInc;
    rotated = true;
  }
  pushMatrix();
  translate(width/2.0,height/2.0);
  rotate(rt);
    
  if (lastSign != linear(0,0)){
    lastSign = -lastSign;
    counter++;
    rotated = false;
  }
  //println(screenX(curX,curY,0),",",screenY(curX,curY,0));
  popMatrix();
}

float lx, //= width/2.-2*dim,
      rx, //= width/2.0,
      uy, //= height/2.-2*dim,
      ly; // = height/2.0;
      

boolean drawIt(){
  float sx = screenX(curX,curY,0),
        sy = screenY(curX,curY,0);
  for (int i=0;i<corners.size();i+=4){
    if (sx >= (float)corners.get(i+0) &&
        sx <= (float)corners.get(i+1) &&
        sy >= (float)corners.get(i+2) &&
        sy <= (float)corners.get(i+3)) {
          return true;
        }
  }
  return false;
}
  
  /*      
  return (sx >= lx &&
          sy >= uy &&
          sx <=rx  &&
          sy <= ly);
}
  */

 
 float letterHeight =  100,
       letterWidth  = 50;

void one(float cx, float cy){
  float h = letterHeight,
        w = letterWidth,
        top = cx ,
        left = cy;

  //pushStyle();
  pushMatrix();
  translate(top,left);
  fill(0,255,0);
  corners.add(screenX(0,0,0));
  corners.add(screenX(w,0,0));
  corners.add(screenY(0,0,0));
  corners.add(screenY(0,h,0));
  rect(0,0,w,h);
  popMatrix();
  //popStyle();
}

void zero(float cx, float cy){
  float h = letterHeight,
        w = 2*letterWidth,
        top = cx, // - w/2.0,
        left = cy; // - h/2.0;

  //pushStyle();
  pushMatrix();
  translate(top,left);
  fill(0,255,0);
  rect(0,0,w,h);
  float nh = h/2.0,
        nw = w/2.,
        nl = w/2. - nw/2.0,
        nt = h/2.0- nh/2.0;
  corners.add(screenX(0,0,0));
  corners.add(screenX(w,0,0));
  corners.add(screenY(0,0,0));
  corners.add(screenY(w,nt,0));

  corners.add(screenX(0,nt,0));
  corners.add(screenX(nl,nt,0));
  corners.add(screenY(0,nt,0));
  corners.add(screenY(nl,nt+nh,0));
  
  corners.add(screenX(nl+nw,nt,0));
  corners.add(screenX(w,nt,0));
  corners.add(screenY(nl+nw,nt,0));
  corners.add(screenY(nl+nw,nt+nh,0));
  
  corners.add(screenX(0,nt+nh,0));
  corners.add(screenX(w,nt+nh,0));
  corners.add(screenY(0,nt+nh,0));
  corners.add(screenY(w,h,0));
 
  translate(nl,nt);
  fill(0);
  
  rect(0,0,nw,nh);
  popMatrix();
  //popStyle();
}

void transSpace(float pw){
  translate(pw+ letterWidth,0);
}