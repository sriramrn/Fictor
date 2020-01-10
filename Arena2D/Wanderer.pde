// wanderer class from https://processing.org/discourse/beta/num_1234642792.html

class Wanderer
{
 float x;
 float y;
 float wander_theta;
 float wander_radius;
 
 
 float max_wander_offset = 0.35;
 float max_wander_radius = 1.0;
 
 Wanderer(float _x, float _y)
 {
   x = _x;
   y = _y;
   
   wander_theta = random(TWO_PI);
   wander_radius = random(max_wander_radius);
 }
 
 void stayInsideCanvas()
 {
   // call wanderer.stayInsideCanvas() to wrap around the edges
   x %= width;
   y %= height;   
 }
 
 void move()
 {
   float wander_offset = random(-max_wander_offset, max_wander_offset);
   wander_theta += wander_offset;
   
   x += cos(wander_theta);
   y += sin(wander_theta);
 }
 
 float getX()
 {
   return x;
 }
 
 float getY()
 {
   return y;
 }
} 
