PImage image;
GameClass game;

void setup() {
    size(1920, 1080);
    game = new GameClass();
    image = loadImage("../Maps/Map-London.png");
}

void draw() {
    background(0);
    image(image, 0, 0);
    textSize(32);
    text(game.proc + "", 1920 / 2, 1080 / 2);
    fill(0, 0, 0);
}

void update() {

}



class GameClass {

    int proc;
    boolean paused;

    GameClass() {
        this.proc = 0;
        this.paused = false;
    }

    void play() {
        this.paused = false;
        while (! this.paused) {
            try {
                Thread.sleep(10);
                this.proc += 1;
                redraw();
            }
            catch (InterruptedException e) { }
        }
    }

    void pause() {
        this.paused = true;
    }

    int getProc() {
        return this.proc;
    }

}



class Passenger {

    int patience;

    Passenger(int patience) {
        this.patience = patience;
    }

}



class Station {

    int x, y, id;
    String filename;

    Station(int x, int y, String shape, int id) {
        this.x = x;
        this.y = y;
    }

}
