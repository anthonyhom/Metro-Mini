import java.util.*;

GameClass game;
boolean mouseDrag, mousePress, mouseRelease, paused = false;
ArrayList<Station> stationsToAdd = new ArrayList<Station>();
int counter;

void setup() {
  fullScreen();
  game = new GameClass(new Map("../Maps/Map-London.png"));
  paused = false;
  //frameRate(30);
  counter = 0;
}

void draw() {
  if (! paused) game.run();
  if (! paused)
    this.game.proc += 1;
  else {
    fill(0, 10);
    rect(0, 0, 1920, 1080);
  }
  fill(0);
  textMode(CENTER);
  textSize(32);
  text(game.proc + "", 90, 90);
  text(counter + "", width - 90, 90);
}
// esc and spacebar pauses the game
void keyPressed() {
  if (key == 27) {
      key = 32;
  }
  if (key == 32) {
      paused = ! paused;
  }
  if (key == 96) {
      setup();
  }
}

void mouseDragged() {
  mouseDrag = true;
  mouseRelease = false;
}

void mousePressed() {
  mousePress = true;
  mouseRelease = false;
}

void mouseReleased() {
  mouseDrag = false;
  mousePress = false;
  mouseRelease = true;
  game.addRoute(stationsToAdd);
  stationsToAdd = new ArrayList<Station>();
  for (Station station : game.stations)
      station.selected = false;
}
