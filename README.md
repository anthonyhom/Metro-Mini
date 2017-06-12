# Metro-Mini
Final Project Term 2

---Project Description---

A mimic of the original Mini Metro game, Metro Mini is a take on simulating public transportation through random spawn events, user-drawn pathways, time constraints, and minimalistic graphic elements. Players are tasked with connecting neighboring stations and enabling passengers to travel from start to end

---Instructions---

Open and run "Game/Game.pde" in Processing.
Stations will spawn in random positions on the map. Connect the stations by dragging between them.
Passengers will appear at random stations with destinations in mind. Make sure the routes you draw enable them to reach their destinations.
Score, or the number of passengers who reach their station, is shown in upper right corner.
You can press the escape key or the spacebar to pause the game. Re-press the keys to resume back to the game. 

---Bugs---

Game will display a blank screen on launch (Restart the game).
Cars may not always move in the exact sequence the route is drawn.
Preceding lines may disappear after the drawn line. But cars were still able to move.
Game froze after a line was drawn.
Game froze when overlapping lines. 

---DevelopmentLog---

6/1/17
Jonathan and Anthony worked on processing the image of the map as our background image for the game.
6/2/17
Afterwards, Jonathan and Anthony proceeded with setting up the game. While Anthony was fixing the image processing of the map, Jonathan worked on adding stations, passengers, and a timer.
6/4/17
Passengers would spawn randomly at different stations. Route class was made. Map was updated. Jonathan updated how the passengers would spawn with stations as their current location and how they need to move to destination with a shared id. Anthony worked on the timer at which stations and passengers spawn and he created straight lines to connect each station. Bug encountered with disappearing lines. He also resized the pausing of the game. Tried implementing a* method into routes.
6/5/17
Jonathan merged the branch to the master. He wrote the addRoute() method to draw routes. But it was not drawing properly.
6/6/17
Jonathan started the Metro class and constructor to build the cars. He also started pathfinding to build the routes. Anthony added passengers to metros.
6/7/17
Connected Metro class and Route class to enable metros to travel across drawn line.
6/8/17
Added colors to the routes. Encountered freezing when trying to have metro move. But was fixed.
6/9/17
Wrote loading, unloading, and move method for metro. Also displayed how passengers would appear when traveling on the metro. 
6/10/17
Trying to attempt curved lines by using curve and curvevertex. Had to typecast some ints to float. -> Ignore the code. Created tracer class to leave points below so that it can draw the route in which the metro is traveling. Separated classes into different files.
6/11/17
Fixed display of lines. But metros were still moving in a different sequence to the route that is drawn. -> Robustified tracer class to follow path that metro takes. 


