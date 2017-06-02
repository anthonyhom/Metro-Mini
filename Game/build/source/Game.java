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
boolean mouseDrag, mousePress, paused = false;

public void setup() {
    
    game = new GameClass(new Map("../Maps/Map-London.png"));
    paused = false;
    //frameRate(30);
}

public void draw() {
    background(0);
    image(game.map.image, 0, 0);
    textSize(32);
    fill(0);
    text(game.proc + "", 90, 90);
    game.run();
    if (! paused)
        this.game.proc += 1;
    else {
        fill(0, 10);
        rect(0, 0, 1920, 1080);
    }
}

public void keyPressed() {
    if (key == 27) {
        key = 32;
    }
    if (key == 32) {
        paused = ! paused;
    }
}

public void mouseDragged() {
    mouseDrag = true;
}

public void mousePressed() {
    mousePress = true;
}

public void mouseReleased() {
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
            if (addStation(new Station((int) random(1, 16) * 120, (int) random(1, 9) * 120, shapes[(int) random(0, 3)], numStations))) {
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
            if (addStation(new Station((int) random(1, 16) * 120, (int) random(1, 9) * 120, shapes[(int) random(0, 3)], numStations))) {
                i -= 1;
            }
        }
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
        boolean b = false;
        if (proc % 1000 == 0 && ! b)
            b = addStation(new Station((int) random(1, 16) * 120, (int) random(1, 9) * 120, shapes[(int) random(0, 3)], numStations));
        for (Station station : game.stations) {
            if (mousePress) {
                if (mouseX > station.x - 45 && mouseX < station.x + 45 &&
                    mouseY > station.y - 45 && mouseY < station.y + 45) {
                    PImage ripple = loadImage(station.filename);
                    ripple.resize(60, 60);
                    image(ripple, station.x - 7, station.y - 7);
                }
            }
            if (mouseDrag) {
                //if (mouseX > station.x - 45 && mouseX < station.x + 45 &&
                //    mouseY > station.y - 45 && mouseY < station.y + 45) {
                    stroke(0);
                    line(mouseX, mouseY, station.x + 22, station.y + 22);
                //}
            }
            image(station.image, station.x, station.y);
        }
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
