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

PImage image;
GameClass game;

public void setup() {
    
    game = new GameClass();
    image = loadImage("../Maps/Map-London.png");
}

public void draw() {
    background(0);
    image(image, 0, 0);
    textSize(32);
    text(game.proc + "", 1920 / 2, 1080 / 2);
    fill(0, 0, 0);
}

public void update() {

}



class GameClass {

    int proc;
    boolean paused;

    GameClass() {
        this.proc = 0;
        this.paused = false;
    }

    public void play() {
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

    public void pause() {
        this.paused = true;
    }

    public int getProc() {
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
