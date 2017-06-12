class Station {

  ArrayList<Passenger> passengers;
  ArrayList<Route> routes;
  boolean selected;
  int x, y, id;
  PImage image;
  String filename, shape;

  Station(int x, int y, String shape, int id) {
    this.filename = "../Reference/Station-" + shape + ".png";
    this.id = id;
    this.image = loadImage(this.filename);
    this.passengers = new ArrayList<Passenger>();
    this.routes = new ArrayList<Route>();
    this.selected = false;
    this.shape = shape;
    this.x = x;
    this.y = y;
  }

  boolean addPassenger(Passenger passenger) {
    if (passenger.destination.id != id) {
      passengers.add(passenger);
      return true;
    }
    return false;
  }

  void draw() {
      imageMode(CENTER);
      image(image, x, y);
  }
}
