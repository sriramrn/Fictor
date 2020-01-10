import oscP5.*;
import netP5.*;

OscP5 oscP5;

double raw_a = 0.0;
double raw_k = 0.0;

float k = 0; float prev_k = 0; float scal = -1.0;
float a = 0; float prev_a = 0; float acal = 1.0;

float tailsamplinginterval = 20; //milliseconds after accounting for sliding window averaging 
float timecourse = 20; float tau = timecourse/tailsamplinginterval;

int current_event_time = 0;
int prev_event_time = 0;

void oscEvent(OscMessage theOscMessage) {
  
  current_event_time = millis();
  tailsamplinginterval = current_event_time - prev_event_time;
  prev_event_time = current_event_time;
  tau = timecourse/tailsamplinginterval;

  raw_a = theOscMessage.get(0).doubleValue();
  raw_k = theOscMessage.get(1).doubleValue();
  
  k = (float) raw_k;
  a = (float) raw_a;
  
  k = LowpassFilter(k*scal,prev_k,tau);
  a = LowpassFilter(a*acal,prev_a,tau);
  prev_k = k;  
  prev_a = a;  
}
