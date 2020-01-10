boolean mark_centre = true;
boolean display_coords = true;

boolean drift = false;
float drift_rate = 1.0;  //centimeters per second
float drift_dur = 5.0;   //seconds
float drift_prob = 0.2;

boolean includePrey = true;
int preyNum = 100;
float preySize = 0.02; //centimeters 
int[] preyLoc = {1723,1723};
float preySpread = 0.5;  //centimeters from preyLoc that the prey are allowed to wander
float reInitProb = 0.005;

float pixelwidth=.0044; //centimetres
int framerate = 60;

boolean save = false;
String savePath = "D:/Fictor2D/";
String baseName = "test";
