class Map {

  PImage image;
  String filename;

  Map(String filename) {
    this.filename = filename;
    this.image = loadImage(this.filename);
  }

  void draw(int x, int y) {
    imageMode(CENTER);
    image(image, x, y);
  }

}