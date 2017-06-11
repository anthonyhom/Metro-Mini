class Trace extends Metro{
  
  boolean active = true;
  
  Trace(Route route){
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