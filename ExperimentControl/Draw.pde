void draw() {

  frame.setTitle("fps: " + round(frameRate));     
  frame.setLocation(1750,0); 
  
  speed = fs[repeatcounter][motifcounter];
  scal = 1/(frameRate*per);

  CurrentTime = millis();
  trig_state = arduino.digitalRead(trig_pin);
  
  if (trig_state == Arduino.HIGH && trigswitch == 0) {
    
    Trigger = 1;
    trigswitch = 1;
    TriggerTime = CurrentTime;   
    acquisition++;
    
    if (end == false){
      println("current cycle = " + str(acquisition) + " out of " + str(cycles));
      println("Trial No: 1");}

  }
  else
  { Trigger=0; }  
  
  if (trig_state == Arduino.HIGH && trig_out_state ==0 ) {
    arduino.digitalWrite(trig_out, Arduino.HIGH);
    trig_out_state = 1;
  }
  
  if (trig_state == Arduino.LOW && trig_out_state == 1) {
    if(CurrentTime-TriggerTime >= trig_out_dur) {
      arduino.digitalWrite(trig_out, Arduino.LOW);
      trig_out_state = 0;
    }
  }

  //Get current movement value from the buffer (for no delay, set bufferSize = 1)
  arrayCopy(updateFifoBuffer(fifoBuffer,k),fifoBuffer);
  if (!delayRandomize) {
    delayIndex = defaultDelayIndex;
    k=fifoBuffer[delayIndex];
  }


  if (CurrentTime-TriggerTime <= TrialDuration && end != true)
  {
    //Gain sequence
    if (Repeat == true)
    {
      if (CurrentTime-TriggerTime >= DurIncrement[repeatcounter][motifcounter] + sumduration*trialcounter)
      {
        motifcounter += 1;
        randgain = randompick(gainBucket);
        randflow = randompick(flowBucket)/pixelwidth;
        randelay = ceil(randompick(delayBucket)/frameinterval)-1;
      }
      if (motifcounter == GainSequence[repeatcounter].length)
      {
        motifcounter = 0;
        repeatcounter += 1;
        curr_rep += 1;
        if (repeatcounter == GainSequence.length)
        {
          motifcounter = 0;
          repeatcounter = 0;
          trialcounter += 1;
        }
      }
      
      if (!gainRandomize) {
        gain = GainSequence[repeatcounter][motifcounter];
      }
      else {
        if (gainRandPattern[repeatcounter][motifcounter] == 1) {
          gain = randgain;
        }
        else {
          gain = GainSequence[repeatcounter][motifcounter];
        }
      }
      
      if (!flowRandomize) {
        speed = fs[repeatcounter][motifcounter];
      }
      else {
        if (flowRandPattern[repeatcounter][motifcounter] == 1) {
          speed = randflow;
        }
        else {
          speed = fs[repeatcounter][motifcounter];
        }
      }
      
      if (delayRandomize) {
        if (delayRandPattern[repeatcounter][motifcounter] == 1) {
          delayIndex = randelay;
        }
        else {
          delayIndex = defaultDelayIndex;
        }
        k = fifoBuffer[delayIndex];
      }
      
      
      if (boutClamp) {
        if (boutEnd && new_rep){
          boutStart = false;
          boutEnd = false;
        }        
        if (clampPattern[repeatcounter][motifcounter] == 1) {
          if (k >= boutThreshold && !boutStart) {
            boutStart = true;
          }
          if (k < boutThreshold && boutStart && !boutEnd) {
            boutEnd = true;
            clampTime = millis();
          }
          if (boutEnd && CurrentTime-clampTime >= clampAfter) {
            speed = 0;
          }
        }
      }
      
      
      if (interleave_sensory_replay) {
        if (loadPattern[repeatcounter][motifcounter] == 1 && ifisin(trialcounter,trialsToRecord)) {
          gain_replay = gain;
          flow_replay = speed;
          swim_replay = append(swim_replay,k);
        }
        if (replayPattern[repeatcounter][motifcounter] == 1 && ifisin(trialcounter,trialsToReplay)) {
          replay = true;
          resetBuffer = true;
          replay_count++;
          gain = gain_replay;
          speed = flow_replay;
          if (replay_count < swim_replay.length) {
            replay_k = swim_replay[replay_count];
          }
        }
      }      
      
      
    }
    
    
    if (smoothFlow) {
      speed = LowpassFilter(speed,prevSpeed,speedTau);
      if (speed <= minSpeed) {
        speed = 0;
      }
      prevSpeed = speed;
    }
    

    //*** Updates to k and speed must be made before this part of the loop. Otherwise, changes will take an extra frame to be displayed ***
    if (!OpenLoop && !replay)
    {
      xPos = xPos+((speed-(k*invert))*scal);
    }
    if (OpenLoop && !replay)
    {
      xPos = xPos+(speed*scal);
    }
    
    if (replay) {
      xPos = xPos+((speed-(replay_k*invert))*scal);
    }    
    
    Data[0] = str(copy_k); Data[1] = str(CurrentTime); Data[2] = str(gain);
    Data[3] = str(speed*pixelwidth); Data[4] = str(((float) raw_k)*movement_scaling);
    Data[5] = str(delayIndex);
    
    for (int i = 0; i < DataWriter.length; i++) 
    {
      DataWriter[i].println(Data[i]+',');
      DataWriter[i].flush();
    }
    
  }
  
  myshader.set("time", xPos);
  shader(myshader);
  rect(0,0,WindowWidth,WindowHeight);
  //resetShader();
  
  if (CurrentTime-TriggerTime >= TrialDuration && acquisition <= cycles) {
    
    motifcounter = 0;
    repeatcounter = 0;
    trialcounter = 0;
    Trigger = 0;
    trigswitch = 0;
    gainindex = 0;
    curr_rep = 0;

    flow_replay = 0;
    gain_replay = 0;
    replay_count = 0;
    swim_replay = new float[1];
    resetBuffer = false;
    
    filepath=GeneratePath(path,date,basename,acquisition);    
    for (int i = 0; i < DataWriter.length; i++) {
      DataWriter[i] = createWriter(filepath + Filenames[i] + ".txt");
    }
    
    if (acquisition == cycles && end_trig_state == 0 && end == false) {
      println("Experiment Complete!");
      arduino.digitalWrite(self_trig_out, Arduino.HIGH);
      end_trig_state = 1;
      end_trig_time = millis();
      end = true;
    }
   
  }
  
  if (end_trig_state == 1 && CurrentTime - end_trig_time >= trig_out_dur) {
    arduino.digitalWrite(self_trig_out, Arduino.LOW);
  }
  
  
  //Self trigger generation
  if (self_timed == true && acquisition <= cycles-1)  {
    
    if (frameCount == 1)  
    { init_time = millis(); }
    
    if (init == true && CurrentTime-init_time >= idel)  {
      arduino.digitalWrite(self_trig_out, Arduino.HIGH);
      self_trig_state = 1;
      self_trig_time = millis();
      init = false;    
    }
    
    if (init == false && Trigger == 0 && tdel_start ==false)  {
      init_time = millis()+sumduration*nrepeats;
      tdel_start = true;
    }
    
    if (init == false && tdel_start == true && CurrentTime-init_time >= tdel)  {
      arduino.digitalWrite(self_trig_out, Arduino.HIGH);
      self_trig_state = 1;
      self_trig_time = millis();
      tdel_start = false;    
    }
    
  }

   
  if (curr_rep-prev_rep > 0){
    new_rep = true;
    println("Trial No: " + str(curr_rep+1));
  }
  else {
    new_rep = false;
  }
  prev_rep = curr_rep; 
  
  if (new_rep && resetBuffer) {
    replay = false;
    flow_replay = 0;
    gain_replay = 0;
    replay_count = 0;
    swim_replay = new float[1];
  }
  
  if (trigger_on_repeats == true && new_rep == true && self_trig_state == 0) {
    arduino.digitalWrite(self_trig_out, Arduino.HIGH);
    self_trig_state = 1;
    self_trig_time = millis();
  }
    
  if (self_trig_state == 1 && CurrentTime-self_trig_time >= trig_out_dur)  {
    arduino.digitalWrite(self_trig_out, Arduino.LOW);
    self_trig_state = 0;    
  }

}
