class Tracer extends Metro {
  
  boolean active = true;
  
  Tracer(Route route){
  super(route);
  noFill();
  beginShape(); 
 }
  void makePoint(){
   curveVertex(x,y);
   if (dist(x,y,next.x,next.y) < 100){
     endShape();
     active = false;
    }
    System.out.println("hello");
  }
  
    void move(){
    if (x == next.x && y == next.y)
      getNext();
      if (abs((x - speed) - next.x) < abs(x - next.x) && timer < 0)
      x -= speed;
      if (abs((x + speed) - next.x) < abs(x - next.x) && timer < 0)
      x += speed;
      if (abs((y - speed) - next.y) < abs(y - next.y) && timer < 0)
      y -= speed;
      if (abs((y + speed) - next.y) < abs(y - next.y) && timer < 0)
      y += speed;
      timer -= 1;
      makePoint();
  }
}