import oscP5.*;
import netP5.*;

OscP5 oscP5;

//Initialize swim variables for closed-loop

float gain = 1.0;

double raw_k = 0.0; float k = 0.0; float prev_k = 0.0; 
float copy_k = 0.0; float prev_copy_k; 

int windowWidth = 4;
float[] slidingWindow = new float[windowWidth];

float tailsamplinginterval = 20; //milliseconds (after accounting for sliding window averaging) 

float timecourse = 10; float tau = timecourse/tailsamplinginterval;

int invert = 1; //-1 or 1        

int current_event_time = 0;
int prev_event_time = 0;

//Read values from Bonsai
void oscEvent(OscMessage theOscMessage) {
 
  current_event_time = millis();
  tailsamplinginterval = current_event_time - prev_event_time;
  prev_event_time = current_event_time;
  tau = timecourse/tailsamplinginterval;
  
  raw_k = theOscMessage.get(0).doubleValue(); //Unpack the UDP message
  k = (float) raw_k;
  
  arrayCopy(updateFifoBuffer(slidingWindow,k),slidingWindow);
  k = arrayAvg(slidingWindow);
 
  k = LowpassFilter(k*movement_scaling,prev_k,tau);
  prev_k = k;
  k = k*gain/pixelwidth;
  
  copy_k = LowpassFilter(((float) raw_k)*movement_scaling, prev_copy_k, tau);
  prev_copy_k = copy_k;
  
}
