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
  game.run();
  if (! paused)
    this.game.proc += 1;
  else {
    fill(0, 10);
    rect(0, 0, 1920, 1080);
  }
  textSize(32);
  fill(0);
  text(game.proc + "", 90, 90);
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
    int i = 1;
    while (i > 0) {
      if (addStation(new Station((int) random(1, 16) * width / 16, (int) random(1, 9) * height / 9, shapes[(int) random(0, 3)], numStations))) {
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
    int i = 1;
    while (i > 0) {
      if (addStation(new Station((int) random(1, 16) * width / 16, (int) random(1, 9) * height / 9, shapes[(int) random(0, 3)], numStations))) {
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
    image(game.map.image, 0, 0);
    boolean b = false;
    if (proc % 1000 == 0 && ! b)
      b = addStation(new Station((int) random(1, 16) * width / 16, (int) random(1, 9) * height / 9, shapes[(int) random(0, 3)], numStations));
    if (proc % 50 == 0) {
      for (Station station : stations) {
        if (stations.indexOf(station) == (int) random (0, stations.size())) {
          station.addPassenger(new Passenger(stations.get((int) random(0, stations.size()))));
        }
      }
    }
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
      for (int i = 45, j = 0; i < station.passengers.size(); i += 1, j += 15)
        image(station.passengers.get(i).image, station.x + j, station.y);
    }
    image(new Passenger(stations.get(0)).image, 180, 180);
  }
}



class Map {

  PImage image;
  String filename;

  Map(String filename) {
    this.filename = filename;
    this.image = loadImage(this.filename);
  }
}



class Passenger {

  int patience;
  PImage image;
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
}



class Route {
}



class Station {

  ArrayList<Passenger> passengers;
  int x, y, id;
  PImage image;
  String filename, shape;

  Station(int x, int y, String shape, int id) {
    this.filename = "../Reference/Station-" + shape + ".png";
    this.image = loadImage(this.filename);
    this.passengers = new ArrayList<Passenger>();
    this.shape = shape;
    this.x = x;
    this.y = y;
  }

  public boolean addPassenger(Passenger passenger) {
    if (passenger.destination.id != id) {
      passengers.add(passenger);
      return true;
    }
    return false;
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
