import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Game extends PApplet {

GameClass game;

public void setup() {
    
    game = new GameClass(new Map("../Maps/Map-London.png"));
}

public void draw() {
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
    for (Station station : game.stations)
        image(station.image, station.x, station.y);
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
        addStation(new Station((int) random(0, 16) * 120, (int) random(0, 9) * 120, shapes[(int) random(0, 3)], numStations));
        addStation(new Station((int) random(0, 16) * 120, (int) random(0, 9) * 120, shapes[(int) random(0, 3)], numStations));
    }

    GameClass(Map map) {
        this.map = map;
        this.numStations = 0;
        this.paused = false;
        this.proc = 0;
        this.stations = new ArrayList<Station>();
        addStation(new Station((int) random(0, 16) * 120, (int) random(0, 9) * 120, shapes[(int) random(0, 3)], numStations));
        addStation(new Station((int) random(0, 16) * 120, (int) random(0, 9) * 120, shapes[(int) random(0, 3)], numStations));
    }

    public boolean addStation(Station station) {
        if (map.image.get(station.x, station.y) == color(224)) {
            stations.add(station);
            numStations += 1;
            map.image.set(station.x, station.y, color(0));
            return true;
        }
        return false;
    }

    public void run() {
        proc += 1;
        boolean b = false;
        if (proc % 100 == 0 && ! b)
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

    Passenger(int patience) {
        this.patience = patience;
    }

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
  public void settings() {  size(1920, 1080); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
