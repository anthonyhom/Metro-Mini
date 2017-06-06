import java.util.*;

GameClass game;
boolean mouseDrag, mousePress, paused = false;

void setup() {
  size(1920, 1080);
  game = new GameClass(new Map("../Maps/Map-London.png"));
  paused = false;
  //frameRate(30);
}

void draw() {
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

void keyPressed() {
  if (key == 27) {
    key = 32;
  }
  if (key == 32) {
    paused = ! paused;
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

  ArrayList<Route> routes;
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
    this.routes = new ArrayList<Route>();
    this.stations = new ArrayList<Station>();
    int i = 1;
    while (i > 0) {
      if (addStation(new Station((int) random(1, 16) * width / 16, (int) random(1, 9) * height / 9, shapes[(int) random(0, 3)], numStations))) {
        i -= 1;
      }
    }
  }

  void addRoute(ArrayList<Station> stations, int Color) {
    Route route = new Route(stations, Color);
    routes.add(route);
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
    game.map.draw(0, 0);
    if (proc % 2000 == 0) {
      ArrayList<Station> a = new ArrayList<Station>();
      for (Station station : stations) a.add(station);
      addRoute(a, (int) random(0, 256));
    }
    if (routes.size() > 0) {
    for (Route route : routes)
      route.draw();
  }
    boolean b = false;
    if (proc % 1000 == 0 && ! b)
      b = addStation(new Station((int) random(1, 16) * width / 16, (int) random(1, 9) * height / 9, shapes[(int) random(0, 3)], numStations));
    if (proc % 500 == 0) {
      int i = (int) random(0, stations.size()), j = i;
      while (j == i)
        j = (int) random(0, stations.size());
      stations.get(i).addPassenger(new Passenger(stations.get(i), stations.get(j)));
    }
    for (Station station : game.stations) {
      if (mousePress) {
        if (mouseX > station.x - 45 && mouseX < station.x + 45 &&
          mouseY > station.y - 45 && mouseY < station.y + 45) {
          PImage ripple = loadImage(station.filename);
          ripple.resize(60, 60);
          tint(255);
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
      for (int i = 0, j = 60; i < station.passengers.size(); i += 1, j += 35)
        station.passengers.get(i).draw(station.x + j, station.y);
    }
  }

}



class Map {

  PImage image;
  String filename;

  Map(String filename) {
    this.filename = filename;
    this.image = loadImage(this.filename);
  }

  void draw(int x, int y) {
    image(image, x, y);
  }

}



class Passenger {

  int patience;
  PImage image;
  Route route;
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

  void draw(int x, int y) {
    image(image, x, y);
  }

}




class Route {

  ArrayList<Station> stations;
  int Color;

  Route(ArrayList<Station> stations, int Color) {
    this.Color = Color;
    this.stations = stations;
  }

  void draw() {
    for (int i = 0; i < stations.size() - 1; i += 1) {
      stroke(Color);
      strokeWeight(10);
      line(stations.get(i).x , stations.get(i).y, stations.get(i + 1).x, stations.get(i + 1).y);
    }
  }

  /*
   ArrayList<Station> getPath(GameClass game,Station current, Station destination){
    sequence = new Arraylist<Station>();
    ArrayList<Station> q = new ArrayList<Station>();
    q.add(current);
    while(q.size() > 0){
      ArrayList<Station> temp = game.stations;
      Station s = temp.remove(0);
      if (s.x == destination.x && s.y == destination.y){
        q.add(s);
        while(s.get(current - 1) != null){
          destination.set(station.x, station.y, s.get(Passenger,current - 1));
          s = s.get(Passenger.current - 1);
        }

      }
    }
  }
  */
}

class Path {}

class Station {

  ArrayList<Passenger> passengers;
  int x, y, id;
  PImage image;
  String filename, shape;

  Station(int x, int y, String shape, int id) {
    this.filename = "../Reference/Station-" + shape + ".png";
    this.id = id;
    this.image = loadImage(this.filename);
    this.passengers = new ArrayList<Passenger>();
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

}
