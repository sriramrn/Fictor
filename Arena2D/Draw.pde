void draw() {
  
  //frame.setLocation(620,-100);
  
  currentTime = millis();  
  
  background(0);

  K = k;
  A = a;  
  
  if (!init && currentTime < init_delay) {
    K = 0;
    A = 0;
  }
  
  if (!init && currentTime >= init_delay) {
    init = true;
    init_time = millis();
    arduino.digitalWrite(trig_pin, Arduino.HIGH);    
  }
  if (init && millis()-init_time >= 50) {
    arduino.digitalWrite(trig_pin, Arduino.LOW);
  }
  
  if (drift && init) {
    if (!drift_init) {
      drift_count = 0;
      drift_dir = int(random(seed_size));
      drift_init = true;
    }
    if (drift_dir == 0) {yd += drift_rate; dRate = drift_rate;}
    if (drift_dir == 1) {yd -= drift_rate; dRate = drift_rate;}
    if (drift_dir == 2) {xd -= drift_rate; dRate = drift_rate;}
    if (drift_dir == 3) {xd += drift_rate; dRate = drift_rate;}    
    else {dRate = 0;} 
    drift_count++;
    if (drift_count >= max_drift) {drift_init = false;}    
  } 
  
  xd += K*sin(radians(angle%359));
  yd += K*cos(radians(angle%359));
  
  if (abs(xd) >= xlim-pad) {
    if (xd > 0) {xd = xlim-pad;}
    else {xd = -xlim+pad;}
  }
  if (abs(yd) >= ylim-pad) {
    if (yd > 0) {yd = ylim-pad;}
    else {yd = -ylim+pad;}
  }  
  
  angle += A;
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(angle%360));
  translate(xd,yd);
  image(img,0,0); 

  if (includePrey) {
    for (int i=0; i<prey.length; i++)
    {
      prey[i].move();
      px = prey[i].getX()-width/2;
      py = prey[i].getY()-height/2;
      dist = distance(px+width/2,py+height/2,opx,opy);
      if (dist >= preySpreadPix) {
        if (int(random(reInitSeedSize)) == 0) {
          prey[i] = new Wanderer(opx,opy);
        }
      }
      fill(0);
      stroke(150);
      ellipse(px, py, preySize, preySize);
    } 
  }
  popMatrix();

  if (mark_centre) {
    fill(255,0,0);
    ellipse(width/2,height/2,10,10);
    fill(0,168,255);
  }
  
  if (display_coords) {
    text("("+str(round(xd+xlim))+","+str(round(yd+ylim))+")", width/2, height/2+50);
  }
  //xd+xlim and yd+ylim are the x and y pixel coordinates of the fish
  
  if (save && init) {  
        
    swimWriter.println(str(K)+","+str(A));
    swimWriter.flush();
    
    coordWriter.println(str(xd+xlim)+","+str(yd+ylim));
    coordWriter.flush();
    
    driftWriter.println(str(dRate*framerate*pixelwidth)+","+str(drift_dir));
    driftWriter.flush();
    
    timeWriter.println(currentTime);
    timeWriter.flush();
    
    if (includePrey) {
      for (int i=0; i<prey.length; i++) {
        preyWriter.print("("+str(int(img.width-pseudoOrigin[0]-prey[i].getX()))+","+str(int(img.height-pseudoOrigin[1]-prey[i].getY()))+")");
      }
      preyWriter.println(" break");
      preyWriter.flush();
    }
  }
  
  
}
