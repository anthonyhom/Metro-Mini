GameClass game;
boolean mouseDrag, mousePress;

void setup() {
    size(1920, 1080);
    game = new GameClass(new Map("../Maps/Map-London.png"));
    //frameRate(30);
}

void draw() {
    background(0);
    image(game.map.image, 0, 0);
    textSize(32);
    text(game.proc + "", 90, 90);
    fill(0, 0, 0);
    if (! game.paused) {
        try {
            Thread.sleep(0);
            game.proc += 1;
        }
        catch (InterruptedException e) { }
    }
    game.run();
    for (Station station : game.stations) {
        image(station.image, station.x, station.y);
        if (mousePress) {
            if (mouseX > station.x - 45 && mouseX < station.x + 45 &&
                mouseY > station.y - 45 && mouseY < station.y + 45) {
                PImage ripple = loadImage(station.filename);
                ripple.resize(60, 60);
                image(ripple, station.x - 5, station.y - 5);
                fill(255);
            }
        }
    }
}

void mouseDragged() {
    mouseDrag = true;
}

void mousePressed() {
    mousePress = true;
}

void mouseReleased() {
    mouseDrag = false;
    mousePress = false;
}



class GameClass {

    ArrayList<Station> stations;
    boolean paused;
    int numStations, proc;
    Map map;
    String[] shapes = new String[] {"Circle", "Square", "Triangle"};

    GameClass() {
        this.numStations = 0;
        this.paused = false;
        this.proc = 0;
        this.stations = new ArrayList<Station>();
        int i = 2;
        while (i > 0) {
            if (addStation(new Station((int) random(0, 16) * 120, (int) random(0, 9) * 120, shapes[(int) random(0, 3)], numStations))) {
                i -= 1;
            }
        }
    }

    GameClass(Map map) {
        this.map = map;
        this.numStations = 0;
        this.paused = false;
        this.proc = 0;
        this.stations = new ArrayList<Station>();
        int i = 2;
        while (i > 0) {
            if (addStation(new Station((int) random(0, 16) * 120, (int) random(0, 9) * 120, shapes[(int) random(0, 3)], numStations))) {
                i -= 1;
            }
        }
    }

    boolean addStation(Station station) {
        if (map.image.get(station.x, station.y) == color(224)) {
            stations.add(station);
            numStations += 1;
            map.image.set(station.x, station.y, color(0));
            return true;
        }
        return false;
    }

    void run() {
        proc += 1;
        boolean b = false;
        if (proc % 1000 == 0 && ! b)
            b = addStation(new Station((int) random(0, 16) * 120, (int) random(0, 9) * 120, shapes[(int) random(0, 3)], numStations));
    }

}



class Map {

    PImage image;
    String filename;

    Map(String filename) {
        this.filename = filename;
        this.image = loadImage(filename);
    }

}



class Passenger {

    int patience;
    PImage image;

    Passenger() {
        this.patience = 10000;
    }

}



class Route {

}



class Station {

    int x, y, id;
    PImage image;
    String filename;

    Station(int x, int y, String shape, int id) {
        this.filename = "../Reference/Station-" + shape + ".png";
        this.image = loadImage(this.filename);
        this.x = x;
        this.y = y;
    }

}
