// Online latency plot during closed-loop experiment.
// Currently works only for experiments with uniform trial duration and inter trial interval

String bsf = "D:/ClosedLoopRaw/180622/test/0/boutStartTimes.txt";
int[] bs = new int[0];

int ntrials = 100; // number of trials in the experiment
int iti = 5000; // inter trial interval in milliseconds
int tdur = 2000; // trial duration in milliseconds

int[] fst = new int[ntrials]; // array of flow start times;
int[] latencies = new int[0];

int latency_threshold = 800; // draw a guide line to indicate a particular latency value

int update_after = 7000; // milliseconds to wait before reloading data
float sx,sy;

void setup() {
  
  String[] b = loadStrings(bsf);
  for (int i=0; i<b.length; i++) {
    bs = append(bs,int(b[i]));
  }
  
  for (int i=0; i<ntrials; i++) {
    fst[i] = (iti+tdur)*i+iti;
  }
        
  size(600,200);
  frameRate(10);
  
  sx = float(width)/ntrials;
  sy = float(height)/tdur;
  
}

void draw() {
  
  background(255);
   
  bs = new int[0];
  String[] b = loadStrings(bsf);
    
  for (int i=0; i<b.length; i++) {
    bs = append(bs,int(b[i]));
  }
  
  latencies = getLatency(bs, fst, tdur, iti);
  plotLatency(latencies, sx, sy);
  

  line(0,height-latency_threshold*sy,width,height-latency_threshold*sy);
  
  delay(update_after);
  
}


int getTrialNumber(int time, int trial_duration, int inter_trial_interval) {
  
  int total_dur = trial_duration+inter_trial_interval;
  int tnum = floor(time / total_dur); 
  
  return tnum;
}

int[] getLatency(int[] bout_start, int[] flow_start, int trial_duration, int inter_trial_interval) {
  
  int t,l;
  int[] latency = new int[0];
  
  for (int i=0; i<bout_start.length; i++) {
    t = getTrialNumber(bout_start[i], trial_duration, inter_trial_interval);
    l = bout_start[i] - flow_start[t];
    
    if (l >= 0) { 
      latency = append(latency,l);
    }
  }
  
  return latency;
}


void plotLatency(int[] latency_list, float scale_x, float scale_y) {
  
  for(int i=0; i<latency_list.length; i++) {
    fill(0);
    rect((i+1)*scale_x, height-latency_list[i]*scale_y, 5,5);
  }

}
