class GameClass {

  ArrayList<Integer> colors;
  ArrayList<Route> routes;
  ArrayList<Station> stations;
  boolean paused;
  int numColors, numStations, proc;
  Map map;
  String[] shapes = new String[] {"Circle", "Square", "Triangle"};

  GameClass() {
    this.colors = new ArrayList<Integer>();
    colors.add(color(236, 52, 46));
    colors.add(color(0, 145, 60));
    colors.add(color(184, 51, 172));
    colors.add(color(40, 80, 172));
    colors.add(color(253, 99, 25));
    colors.add(color(250, 202, 10));
    colors.add(color(152, 101, 52));
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
    this.colors = new ArrayList<Integer>();
    colors.add(color(236, 52, 46));
    colors.add(color(0, 145, 60));
    colors.add(color(184, 51, 172));
    colors.add(color(40, 80, 172));
    colors.add(color(253, 99, 25));
    colors.add(color(250, 202, 10));
    colors.add(color(152, 101, 52));
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

  void addRoute(ArrayList<Station> stations) {
    if (colors.size() == 0)
        return;
    if (stations.size() <= 1)
        return;
    Route route = new Route(stations, colors.remove(0));
    route.metros.add(new Metro(route));
    routes.add(route);
    for (Station station : route.stations)
        station.routes.add(route);
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
    game.map.draw(width / 2, height / 2);
    for (Route route : routes)
      route.draw();
    boolean b = false;
    if (proc % 1000 == 0 && ! b)
      b = addStation(new Station((int) random(1, 16) * width / 16, (int) random(1, 9) * height / 9, shapes[(int) random(0, 3)], numStations));
    if (proc % 500 == 0) {
      int i = (int) random(0, stations.size()), j = i;
      while (j == i)
        j = (int) random(0, stations.size());
      stations.get(i).addPassenger(new Passenger(stations.get(i), stations.get(j)));
    }
    for (Route route : routes) {
      route.draw();
      for (Metro metro : route.metros) {
        metro.move();
        metro.draw();
      }
    }
    for (Station station : stations) {
      if (mousePress) {
        if (mouseX > station.x - 45 && mouseX < station.x + 45 &&
          mouseY > station.y - 45 && mouseY < station.y + 45) {
          PImage ripple = loadImage(station.filename);
          ripple.resize(60, 60);
          tint(255);
          imageMode(CENTER);
          image(ripple, station.x, station.y);
        }
      }
      if (station.selected && stationsToAdd.indexOf(station) == -1)
        stationsToAdd.add(station);
      if (mousePress) {
        if (mouseX > station.x - 45 && mouseX < station.x + 45 &&
            mouseY > station.y - 45 && mouseY < station.y + 45) {
          station.selected = true;
        }
      }
      if (mouseRelease)
        station.selected = false;
      station.draw();
      for (int i = 0, j = 45; i < station.passengers.size(); i += 1, j += 30)
        station.passengers.get(i).draw(station.x + j, station.y);
    }
  }

}
