class Tracer extends Metro {

  byte traversal = 0;
  boolean active = true;

  Tracer(Route route) {
    super(route);
    noFill();
    beginShape();
  }

  void makePoint() {
    curveVertex(x, y);
    if (dist(x, y, next.x, next.y) < 10) {
      getNext();
      endShape();
      if (traversal == 0) {
        traversal++;
        beginShape();
      } else
        active = false;
    }
  }

  void move() {
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