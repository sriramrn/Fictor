void setup() {
  
  if (setup == false){  
    
    int tempcount = 0;
    for (int i=0; i<segmentduration.length; i++) {
      for (int j=0; j<subreps[i]; j++) {
        motifduration[tempcount] = segmentduration[i];
        tempcount++;
      }
    }    
    
    tempcount = 0;    
    for (int i=0; i<FlowSequence.length; i++) {
      for (int j=0; j<subreps[i]; j++) {
        fs[tempcount] = FlowSequence[i];
        tempcount++;
      }
    }

    tempcount = 0;    
    for (int i=0; i<GainSequence.length; i++) {
      for (int j=0; j<subreps[i]; j++) {
        gs[tempcount] = GainSequence[i];
        tempcount++;
      }
    }    
    
    for (int i=0; i<fs.length; i++){
      for (int ii=0; ii<fs[i].length; ii++){
        fs[i][ii] = fs[i][ii]/(pixelwidth);
      }
    }
    
    int[][] MotifDuration = new int[motifduration.length][0];
    int[][] DurIncrement = new int[motifduration.length][0];
    for (int i=0; i<motifduration.length; i++) {
      MotifDuration[i] = new int[motifduration[i].length];
      DurIncrement[i] = new int[motifduration[i].length];
    }
 
    for(int i=0; i<motifduration.length; i++){
      for (int ii=0; ii<motifduration[i].length; ii++){
        sumduration = sumduration+motifduration[i][ii];
        MotifDuration[i][ii] = motifduration[i][ii]*1000;
        DurIncrement[i][ii] = sumduration*1000;
      }
    }
     
    sumduration=sumduration*1000;
    
    if (Repeat==true)
    {
      TrialDuration = sumduration*nrepeats;
    }
    else
    {
      TrialDuration = motifduration[0][0]*1000;
      cycles = 1;
    }
    
    date = GenerateDate();    
    filepath = GeneratePath(path,date,basename,acquisition);
    for (int i=0; i<DataWriter.length; i++) {
      DataWriter[i] = createWriter(filepath + Filenames[i] + ".txt");
    }
    
    //Save parameters
    notes = createWriter(path+"/"+date+"/"+basename+"/"+"params.txt");
    notes.println("Date\t\t\t:\t"+date);
    notes.println("Time\t\t\t:\t"+time);
    notes.println("Genotype\t\t:\t"+Genotype);
    notes.println("Days Post Fertilization\t:\t"+DPF);
    notes.println("Closed Loop\t\t:\t"+str(!OpenLoop));
    notes.println("CL Scaling Factor \t:\t"+str(movement_scaling));
    notes.println("Repeat\t\t\t:\t"+str(Repeat));
    notes.println("Number of Repeats\t:\t"+str(nrepeats));
    notes.println("Cycles\t\t\t:\t"+str(cycles));
    notes.println("Initialization Delay\t:\t"+str(init_delay));
    notes.println("Cycle Delay\t\t:\t"+str(trial_delay));
    
    notes.print("Gain Sequence\t\t:\t{");
    for(int i=0; i<GainSequence.length; i++){
      notes.print("{");
      for (int ii=0; ii<GainSequence[i].length; ii++){      
        notes.print(GainSequence[i][ii]);
        if (ii<GainSequence[i].length-1){notes.print(",");}
      }
      notes.print("}");
      if (i==GainSequence.length-1){notes.print("}");}
    }
    notes.println();
    
    notes.print("Flow Sequence\t\t:\t{");
    for(int i=0; i<FlowSequence.length; i++){
      notes.print("{");
      for (int ii=0; ii<FlowSequence[i].length; ii++){      
        notes.print(FlowSequence[i][ii]*pixelwidth);
        if (ii<FlowSequence[i].length-1){notes.print(",");}
      }
      notes.print("}");
      if (i==FlowSequence.length-1){notes.print("}");}
    }
    notes.println();
    
    notes.print("Segment Duration\t:\t{");    
    for(int i=0; i<segmentduration.length; i++){
      notes.print("{");
      for (int ii=0; ii<segmentduration[i].length; ii++){      
        notes.print(segmentduration[i][ii]);
        if (ii<segmentduration[i].length-1){notes.print(",");}
      }
      notes.print("}");
      if (i==segmentduration.length-1){notes.print("}");}
    }
    notes.println();
    
    notes.println("Smooth Flow Transition\t:\t"+str(smoothFlow));
    
    notes.println("Gain Randomize\t\t:\t"+str(gainRandomize));
    if (gainRandomize) {
      notes.print("Gain RandPattern\t:\t{");
      for (int i=0; i<gainRandPattern.length; i++){
        notes.print("{");
        for (int  ii=0; ii<gainRandPattern[i].length; ii++){
          notes.print(gainRandPattern[i][ii]);
          if (ii<gainRandPattern[i].length-1){notes.print(",");}
        }
        notes.print("}");
        if (i==gainRandPattern.length-1){notes.print("}");}
      }
      notes.println();

      notes.print("Gain Seed\t\t:\t{");
      for (int i=0; i<flowBucket.length; i++){
          notes.print(flowBucket[i]);
          if (i<flowBucket.length-1){notes.print(",");}
        }
      notes.print("}");
      notes.println();
      
    }
    else {
      notes.println("Gain RandPattern\t:\tN.A.");
      notes.println("Gain Seed\t\t:\tN.A.");
    }
    
    notes.println("Flow Randomize\t\t:\t"+str(flowRandomize));
    if (flowRandomize) {
      notes.print("Flow RandPattern\t:\t{");
      for (int i=0; i<flowRandPattern.length; i++){
        notes.print("{");
        for (int  ii=0; ii<flowRandPattern[i].length; ii++){
          notes.print(flowRandPattern[i][ii]);
          if (ii<flowRandPattern[i].length-1){notes.print(",");}
        }
        notes.print("}");
        if (i==flowRandPattern.length-1){notes.print("}");}
      }
      notes.println();
      
      notes.print("Flow Seed\t\t:\t{");
      for (int i=0; i<flowBucket.length; i++){
          notes.print(flowBucket[i]);
          if (i<flowBucket.length-1){notes.print(",");}
        }
      notes.print("}");
      notes.println();
      
    }
    else {
      notes.println("Flow RandPattern\t:\tN.A.");
      notes.println("Flow Seed\t\t:\tN.A.");
    }
    
    notes.println("Feedback Delay\t\t:\t"+str(feedbackDelay));
    notes.println("Delay Randomize\t\t:\t"+str(delayRandomize));
    if (delayRandomize) {
      notes.print("Delay RandPattern\t:\t{");
      for (int i=0; i<delayRandPattern.length; i++){
        notes.print("{");
        for (int  ii=0; ii<delayRandPattern[i].length; ii++){
          notes.print(delayRandPattern[i][ii]);
          if (ii<delayRandPattern[i].length-1){notes.print(",");}
        }
        notes.print("}");
        if (i==delayRandPattern.length-1){notes.print("}");}
      }
      notes.println();
      
      notes.print("Delay Seed\t\t:\t{");
      for (int i=0; i<flowBucket.length; i++){
          notes.print(flowBucket[i]);
          if (i<flowBucket.length-1){notes.print(",");}
        }
      notes.print("}");
      notes.println();
      
    }
    else {
      notes.println("Delay RandPattern\t:\tN.A.");  
      notes.println("Delay Seed\t\t:\tN.A.");
    }
    
    
    notes.println("Bout Clamp\t\t:\t"+str(boutClamp));
    if (boutClamp) {
      notes.print("Clamp Pattern\t\t:\t{");
      for (int i=0; i<clampPattern.length; i++){
        notes.print("{");
        for (int  ii=0; ii<clampPattern[i].length; ii++){
          notes.print(clampPattern[i][ii]);
          if (ii<clampPattern[i].length-1){notes.print(",");}
        }
        notes.print("}");
        if (i==clampPattern.length-1){notes.print("}");}
      }
      notes.println();
      notes.println("Clamp Delay\t\t:\t"+str(clampAfter));    
    }
    else {
      notes.println("Clamp Pattern\t\t:\tN.A.");
      notes.println("Clamp Delay\t\t:\tN.A.");
    }
    
    notes.flush();
    
    setup = true;
  }
  
  //Draw window
  frameRate(framerate);
  size(WindowWidth,WindowHeight,OPENGL);
  background(255, 255, 255);       
  noStroke();                
  fill(0, 0, 0);
  noCursor();
  
  myshader = loadShader("sine.frag");
  if (square==true){c=10;}  
  myshader.set("th", th);
  myshader.set("sper", per);
  myshader.set("contrast", c);

  //Setup UDP communication
  //Port number (2323) must match the port number used by the sender
  oscP5 = new OscP5(this,2323);
  
  //Arduino triggering (arduino must be running standard firmata at a baud rate of 115200)
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[1], 115200);
  
  arduino.pinMode(trig_pin, Arduino.INPUT); 
  
  arduino.pinMode(trig_out, Arduino.OUTPUT);
  arduino.digitalWrite(trig_out, Arduino.LOW);
  
  arduino.pinMode(self_trig_out, Arduino.OUTPUT);
  arduino.digitalWrite(self_trig_out, Arduino.LOW);
  
}

