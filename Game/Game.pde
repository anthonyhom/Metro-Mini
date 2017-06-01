PImage img;

void setup() {
    size(1920, 1080);
    img = loadImage("../Maps/map_00.png");
}

void draw() {
    background(0);
    image(img, 0, 0);
}

class Passenger {

    int patience;

    Passenger(int patience) {
        this.patience = patience;
    }

}

class Station {
    
}
