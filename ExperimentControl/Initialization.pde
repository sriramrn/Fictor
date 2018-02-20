int CurrentTime = 0;
int acquisition = 0;


int[][] motifduration = segmentduration;
int gainindex = 0;
float randgain = 0.0;


int Trigger = 0;
int TrialDuration = 0;
int TriggerTime = -10000000; //Do not edit
int repeatcounter = 0;
int trialcounter =0;
int motifcounter = 0;
int curr_rep =0;
int prev_rep = 0;
Boolean new_rep = false;
int sumduration = 0;


int[][] MotifDuration = new int[motifduration.length][motifduration[0].length];
int[][] DurIncrement = new int[motifduration.length][motifduration[0].length];
float[][] fs = FlowSequence;
float speed = 0.0;
float randflow = 0.0;


//Delay line with FIFO buffer
int maxDelay = 1000; //maximum number of milliseconds to buffer delay
int bufferSize = ceil(maxDelay/frameinterval);
int defaultDelayIndex = ceil(feedbackDelay/frameinterval)-1;
int randelay = 0;
int delayIndex = 0;
float[] fifoBuffer = new float[bufferSize];
//Buffer update function
float[] updateFifoBuffer(float[] buffer, float value){
  float[] v = {value};
  float[] temp = shorten(buffer);
  float[] updatedBuffer = concat(v,temp);
  return updatedBuffer; 
}

//Bout clamp setup
boolean boutStart = false;
boolean boutEnd = false;
float boutThreshold = 0.3/pixelwidth;
int clampTime = 0;


//Smooth optic flow transitions
float speedTau = 250/frameinterval; //timecourse of transition in milliseconds
float prevSpeed = 0;
float minSpeed = 0.01;

float flowOvrdVal = flowOverrideValue/pixelwidth;

//Prevents trial structure calculation in void setup() from running twice 
boolean setup = false;

//Initialize data writer
String filepath;
PrintWriter[] DataWriter = new PrintWriter[6];
String[] Filenames = {"grating","time","gain","flow","movement","feedbackDelay"};
String[] Data = new String[6];
String date = "";

PrintWriter notes;
String time=(str(hour())+":"+str(minute())+":"+str(second()));

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

//Path generator, called each time a new cycle of acquisition begins
String GeneratePath(String Path, String Date, String Basename, int Acquisition)  {
  
  String datapath;
  String Acq = str(Acquisition);
   
  datapath = Path+"/"+Date+"/"+Basename+"/"+Acq+"/";
  return datapath;
}

//Smoothing function to imitate slow acceleration and deceleration
float LowpassFilter(float current_value, float previous_value, float tau)  {
  float alpha = 1.0/(tau+1);
  float swim = 0.0;
  swim = previous_value + alpha*(current_value-previous_value);
  return swim;
}

// Find if element is in an array and return true or false
boolean ifisin(int element, int[] array) {
  boolean found = false;
  for (int i=0; i<array.length; i++) {
    if (element == array[i]) {
      found = true;
      break;
    }  
  }
  return found;
}


float randompick(float[] bucket) {
  int index = int(random(bucket.length));
  float randomchoice = bucket[index];
  return randomchoice;
}

float arrayAvg(float[] arrayToAvg) {
  int len = arrayToAvg.length;
  float sum = 0;
  for (int i = 0; i<arrayToAvg.length; i++) {
    sum += arrayToAvg[i]; 
  }
  float avg = sum/len;
  return avg;
}


//Save and quit at the end
void keyPressed() {
    if (key == 's' || key == ESC)
  {
    for (int i = 0; i < DataWriter.length; i++) 
    {
      DataWriter[i].flush();
      DataWriter[i].close();
    }
    exit();
    
    notes.println();
    notes.println("Comments\t\t:\t");
    notes.flush();
    notes.close();
    String[] paramfile = {"C://Windows//System32//notepad.exe", path+"/"+date+"/"+basename+"/"+"params.txt"};
    open(paramfile);
  } 
}

