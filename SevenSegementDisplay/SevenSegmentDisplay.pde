class SevenSegmentDisplay {
  
  class Segment{
    float x1,x2,y1,y2,w,h;
    boolean illuminated = false;
    
    final int rectRoundingRadius = 5;
    
    color col = color(255,0,0);
    
    Segment(float x,float y, float ww, float hh){
      x1 = x;
      y1 = y;
      w = ww;
      h = hh;
      x2 = x + w;
      y2 = y + h;
    }
    
    void activate(boolean on){
      illuminated = on;
    }
    
    void display(){
      pushStyle();
      if (illuminated){
        noStroke();
        fill(col);
      }
      else {
        stroke(100);
        noFill();
      }
      rect(x1,y1,w,h,rectRoundingRadius);
      popStyle();
    }
  }
    
  Segment segVec[] = new Segment[7];  
  float w,h,swh;
  
  int value;
  
  ArrayList<Integer> onVec = new ArrayList<Integer>();
  
  SevenSegmentDisplay(float ww, float hh, float swhh){
    w = ww;
    h = hh;
    swh = swhh;
    
    // horizontal  
    segVec[0] =  new Segment(0,0,w,swh);
    segVec[1] =  new Segment(0,h/2.-swh/2.,w,swh);
    segVec[2] =  new Segment(0,h-swh,w,swh);
    
    // vertical
    segVec[3] =  new Segment(0,0,swh,h/2.0);
    segVec[4] =  new Segment(w-swh,0,swh,h/2.0);
    segVec[5] =  new Segment(0,h/2.,swh,h/2.0);
    segVec[6] =  new Segment(w-swh,h/2.0,swh,h/2.0);
    
    val(0);
  }
  
  void inc(){
    val((value+1)%10);
  }
  void dec(){
    val(value-1 < 0 ? 9 : value-1);
  }
  
  void val(int v){
    value = v;
    for (int i =0;i<segVec.length;i++){
      segVec[i].activate(false);
    }
    switch(v){
      case 0:
        for (int i =0;i<segVec.length;i++){
          segVec[i].activate(true);
        }  
        segVec[1].activate(false);
        break;
      case 1:
        segVec[4].activate(true);
        segVec[6].activate(true);
        break;
      case 2:
        segVec[0].activate(true);
        segVec[1].activate(true);
        segVec[2].activate(true);
        segVec[4].activate(true);
        segVec[5].activate(true);
        break;
      case 3:
        segVec[0].activate(true);
        segVec[1].activate(true);
        segVec[2].activate(true);
        segVec[4].activate(true);
        segVec[6].activate(true);
        break;
      case 4:
        //segVec[0].activate(true);
        segVec[1].activate(true);
        //segVec[2].activate(true);
        segVec[3].activate(true);
        segVec[4].activate(true);
        //segVec[5].activate(true);
        segVec[6].activate(true);
        break;
      case 5:
        segVec[0].activate(true);
        segVec[1].activate(true);
        segVec[2].activate(true);
        segVec[3].activate(true);
        //segVec[4].activate(true);
        //segVec[5].activate(true);
        segVec[6].activate(true);
        break;
      case 6:
        //segVec[0].activate(true);
        segVec[1].activate(true);
        segVec[2].activate(true);
        segVec[3].activate(true);
        //segVec[4].activate(true);
        segVec[5].activate(true);
        segVec[6].activate(true);
        break;
      case 7:
        segVec[0].activate(true);
        //segVec[1].activate(true);
        //segVec[2].activate(true);
        //segVec[3].activate(true);
        segVec[4].activate(true);
        //segVec[5].activate(true);
        segVec[6].activate(true);
        break;
      case 8:
        for (int i =0;i<segVec.length;i++){
          segVec[i].activate(true);
        }  
        break;
      case 9:
        segVec[0].activate(true);
        segVec[1].activate(true);
        //segVec[2].activate(true);
        segVec[3].activate(true);
        segVec[4].activate(true);
        //segVec[5].activate(true);
        segVec[6].activate(true);
        break;
      default:
        for (int i =0;i<segVec.length;i++){
            segVec[i].activate(false);
          }  
        break;
    }
  }
  void display(){
    for (int i =0;i<segVec.length;i++){
        if (!segVec[i].illuminated){
          segVec[i].display();
      }
    }
    for (int i =0;i<segVec.length;i++){
       if (segVec[i].illuminated){
         segVec[i].display();
       }
    }
  }
}

class Colon{
  float x1,y1,x2,y2,w;
  
  final int rectRoundingRadius = 5;
  
  color col = color(255,0,0);
  
  Colon(float ww){
    x1 = 0;
    y1 = 0;
    w = ww;
    x2 = x1 + w;
    y2 = y1 + w;
  }
  void doRect(){
    rect(0,0,w,w,rectRoundingRadius);
  }
  void display(){
    pushStyle();
    pushMatrix();
    noStroke();
    fill(col);
    doRect();
    translate(0,3*w);
    doRect();
    popMatrix();
    popStyle();
  }
}
  