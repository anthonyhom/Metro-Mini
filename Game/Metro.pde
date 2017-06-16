class Metro {

  ArrayList<Metro> cars;
  ArrayList<Passenger> passengers;
  boolean selected;
  int direction, speed, timer, x, y;
  PImage image;
  Route route;
  Station next;

  Metro(Route route) {
    this.direction = 1;
    this.next = route.stations.get(1);
    this.passengers = new ArrayList<Passenger>(0);
    this.route = route;
    this.selected = false;
    this.speed = 3;
    this.timer = -1;
    this.x = route.stations.get(0).x;
    this.y = route.stations.get(0).y;
  }

  void load() {
      for (int i = 0; x == next.x && y == next.y && next.passengers.size() > 0 && i < next.passengers.size() && passengers.size() < 6; i += 1) {
          try {
              if (next.passengers.get(i).path.get(0).id == getNext().id ||
                  next.passengers.get(i).path.get(0).id == next.id) {
                  passengers.add(next.passengers.remove(i));
                  i -= 1;
              }
          }
          catch (IndexOutOfBoundsException e) { System.out.println("ArrayIndexOutOfBoundsException: load()"); };
      }
  }

  void unload() {
    int i = 0;
    while (x == next.x && y == next.y && i < passengers.size() && passengers.size() > 0) {
        if (next.id == passengers.get(i).destination.id) {
            passengers.remove(i);
            counter += 1;
        }
        else if (getNext().id != passengers.get(i).path.get(0).id) {
            passengers.get(i).path.remove(0);
            next.addPassenger(passengers.remove(i));
        }
        else {
            passengers.get(i).path.remove(0);
            i += 1;
        }
    }
}

  int direction() {
      if (route.stations.indexOf(next) == 0)
          return 1;
      if (route.stations.indexOf(next) == route.stations.size() - 1)
          return -1;
      return direction;
  }

  Station getNext() {
      if (route.stations.indexOf(next) == 0)
          direction = 1;
      if (route.stations.indexOf(next) == route.stations.size() - 1)
          direction = -1;
      timer = 100;
      try {
          return route.stations.get(route.stations.indexOf(next) + direction);
      }
      catch (IndexOutOfBoundsException e) { };
      return null;
  }

  void move() {
      unload();
      load();
      if (x == next.x && y == next.y)
      next = getNext();
      if (abs((x - speed) - next.x) < abs(x - next.x) && timer < 0)
      x -= speed;
      if (abs((x + speed) - next.x) < abs(x - next.x) && timer < 0)
      x += speed;
      if (abs((y - speed) - next.y) < abs(y - next.y) && timer < 0)
      y -= speed;
      if (abs((y + speed) - next.y) < abs(y - next.y) && timer < 0)
      y += speed;
      timer -= 1;
  }

  void draw() {
    fill(route.Color);
    rectMode(CENTER);
    rect(x, y, 60, 30);
    for (int i = 0, j = -24; i < 3 && i < passengers.size(); i += 1, j += 24)
    passengers.get(i).draw(x + j, y - 6);
    for (int k = 3, l = -24; k < 6 && k < passengers.size(); k += 1, l += 24)
    passengers.get(k).draw(x + l, y + 18);
    fill(0);
    textMode(CENTER);
    text(route.stations.indexOf(next), x, y);
  }

}