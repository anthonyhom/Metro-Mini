class Passenger {

  int patience;
  PImage image;
  ArrayList<Station> path;
  String filename, shape;
  Station current, destination;

  Passenger() {
    this.patience = 10000;
  }

  Passenger(Station destination) {
    this.destination = destination;
    this.filename = "../Reference/Passenger-" + this.destination.shape + ".png";
    this.image = loadImage(filename);
  }

  Passenger(Station current, Station destination) {
    this.current = current;
    this.destination = destination;
    this.filename = "../Reference/Passenger-" + this.destination.shape + ".png";
    this.image = loadImage(filename);
  }

  /*
  void findPath() {
    ArrayList<Station> a = new ArrayList<Station>();
    Stack<Station> stack = new Stack();
    Station temp = current;
    stack.add(temp);
    while (stack.size() > 0) {
      temp = stack.pop();
      if (temp.id == destination.id) {
        a.add(temp);
        return;
      }
    }
  }
  */

  void draw(int x, int y) {
    imageMode(CENTER);
    image(image, x, y);
  }

}