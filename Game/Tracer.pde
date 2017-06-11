class Tracer extends Metro{
  
  boolean active = true;
  
  Tracer(Route route){
  super(route);
  beginShape(); 
  }
  
  void makePoint(){
   curveVertex(x,y);
   if ((dist(x,y,station.x,station.y) < 10)){
     endShape();
     active = false;
  }
  
}
}