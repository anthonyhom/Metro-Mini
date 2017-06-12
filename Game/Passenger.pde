class Passenger {

    int patience;
    PImage image;
    ArrayList<Station> path;
    String filename, shape;
    Station current, destination;

    Passenger() {
        this.patience = 10000;
    }

    Passenger(Station destination) {
        this.destination = destination;
        this.filename = "../Reference/Passenger-" + this.destination.shape + ".png";
        this.image = loadImage(filename);
        this.patience = 10000;
    }

    Passenger(Station current, Station destination) {
        this.current = current;
        this.destination = destination;
        this.filename = "../Reference/Passenger-" + this.destination.shape + ".png";
        this.image = loadImage(filename);
        this.patience = 10000;
    }

    void findPath() {
        QueueFrontier q = new QueueFrontier();
        q.add(current);
        Station s = current;
        current.visited = true;
        while (q.size() > 0) {
            Station temp = s;
            s = q.next();
            s.previous = temp;
            if (s.id == destination.id) {
                while (s.previous != null) {
                    path.add(0, s);
                    s = s.previous;
                }
                for (Station station : game.stations)
                    station.visited = false;
                return;
            }
            s.visited = true;
            for (Route route : s.routes) {
                if (0 <= route.stations.indexOf(s) - 1 &&
                    route.stations.indexOf(s) - 1 < route.stations.size() &&
                    route.stations.get(route.stations.indexOf(s) - 1).visited == false)
                    q.add(route.stations.get(route.stations.indexOf(s) - 1));
                if (0 <= route.stations.indexOf(s) + 1 &&
                    route.stations.indexOf(s) + 1 < route.stations.size() &&
                    route.stations.get(route.stations.indexOf(s) + 1).visited == false)
                    q.add(route.stations.get(route.stations.indexOf(s) + 1));
            }
        }
    }

    void draw(int x, int y) {
        imageMode(CENTER);
        image(image, x, y);
    }

}
