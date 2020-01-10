import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

int trig_pin = 12;
int init_delay = 10*1000;  //time in milliseconds to wait for first trigger
int ttl_dur = 50; //duration of ttl pulse in milliseconds

boolean init = false;
int init_time = 0;



