PImage img;
boolean setup = false;

int currentTime = 0;

float K = 0.0;
float A = 0.0;

int x = 0;
int y = 0;
float xd = 0.0;
float yd = 0.0;

int xlim = 0;
int ylim = 0;
int pad = 200;

float angle = 0.0;

boolean drift_init = false;
int max_drift = int(drift_dur*framerate);
int drift_dir = 0;
int drift_count = 0;
int seed_size = int(4/drift_prob);
float dRate = 0.0;

Wanderer[] prey = new Wanderer[preyNum];
int preySpreadPix = int(preySpread/pixelwidth);
float opx = 0.0;
float opy = 0.0;
float px = 0.0;
float py = 0.0;

PrintWriter swimWriter;
PrintWriter coordWriter;
PrintWriter driftWriter;
PrintWriter preyWriter;
PrintWriter timeWriter;
String date = "";
int[] pseudoOrigin = new int[2];
float dist = 0.0;
int reInitSeedSize = int(1/reInitProb);


String GenerateDate(){
  
  String year,month,day,Date;
  
  year = str(year()%1000);
  if (month() < 10)
  {month = str(0)+str(month());}
  else
  {month = str(month());}
  if (day() < 10)
  {day = str(0)+str(day());}
  else
  {day = str(day());}
  Date = year+month+day;
  
  return Date;
}


float LowpassFilter(float current_value, float previous_value, float tau)  {
  float alpha = 1.0/(tau+1);
  float swim = 0.0;
  swim = previous_value + alpha*(current_value-previous_value);
  return swim;
}

float distance(float x1, float y1, float x2, float y2) {
  return (float) Math.sqrt(Math.pow((x1-x2),2)+Math.pow((y1-y2),2));
} 
