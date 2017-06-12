import java.util.*;

public class QueueFrontier {

    Queue<Station> stations;

    public QueueFrontier() {
        stations = new LinkedList<Station>();
    }

    public void add(Station s) {
        stations.add(s);
    }

    public Station next() {
        return stations.remove();
    }

    public int size() {
        return stations.size();
    }

}
