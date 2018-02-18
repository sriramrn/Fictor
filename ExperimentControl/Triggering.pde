import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

//Trigger input
int trigswitch = 0;

int trig_pin = 7;
int trig_state = Arduino.LOW;

int trig_out = 12;
int trig_out_state = Arduino.LOW;
int trig_out_dur = 50;

boolean self_timed = true;
int self_trig_out = 8;
int self_trig_state = 0;
int self_trig_time = 0;

int init_delay = 10;  //time in seconds to wait for first trigger 
int trial_delay = 60; //interval in seconds between trials

boolean trigger_on_repeats = false; 
// This feature can be used to have a sequence of repeats that are triggered independently 
//eg: {{10,10,10},{10,10,10}} will trigger once at the start and once at the end of each {10,10,10} trial
//These will have separate 2P and behavior video files associated with them. Allowing short bursts of
//2P imaging to be carried out with gaps in between, thereby reducing the risk of tissue damage.
//Care must be taken to program cycle mode in ScanImage accordingly.


boolean tdel_start = false;
boolean init = true;
int init_time = 0;
int idel = init_delay*1000;
int tdel = trial_delay*1000;

int end_trig_state = 0;
int end_trig_time = 0;
Boolean end = false;

