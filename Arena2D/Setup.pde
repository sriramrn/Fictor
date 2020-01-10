void setup() {
  
  if (!setup) {
    setup = true;
    //unit conversions
    preySize = preySize/pixelwidth; //size in pixels
    drift_rate = drift_rate/(framerate*pixelwidth);
  }

  size(1200, 1200, P2D);
  frameRate(framerate);

  img = loadImage("arena.png");
  xlim = img.width/2;
  ylim = img.height/2;
  imageMode(CENTER);
  
  pseudoOrigin[0] = img.width/2-width/2;
  pseudoOrigin[1] = img.height/2-height/2;
  opx = img.width-pseudoOrigin[0]-preyLoc[0];
  opy = img.height-pseudoOrigin[1]-preyLoc[1];  
  px = opx;
  py = opy;
  if (includePrey) {       
    for (int i=0; i<prey.length; i++)
    {
      prey[i] = new Wanderer(opx,opy);
    } 
  } 
  
  textSize(16);
  
  oscP5 = new OscP5(this,2323);
  
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[1], 115200);
  arduino.pinMode(trig_pin, Arduino.OUTPUT); 
  arduino.digitalWrite(trig_pin, Arduino.LOW);
  
  if (save) {
    date = GenerateDate();
    swimWriter = createWriter(savePath+date+"/"+baseName+"/"+"swim.txt");
    coordWriter = createWriter(savePath+date+"/"+baseName+"/"+"coord.txt");
    driftWriter = createWriter(savePath+date+"/"+baseName+"/"+"drift.txt");
    preyWriter = createWriter(savePath+date+"/"+baseName+"/"+"prey.txt");
    timeWriter = createWriter(savePath+date+"/"+baseName+"/"+"time.txt");
  }
}
