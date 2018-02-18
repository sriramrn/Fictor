PShader myshader;

int WindowWidth = 1000;
int WindowHeight = 500;

//Screen constants

//PC display
//float pixelwidth=.027; //centimetres

//Acer c120 projector
//float pixelwidth=.0044; //centimetres

//tfp401a projector with nikon 50mm f1.8 projection lens
//float pixelwidth=.05; //centimetres

//tfp401a projector with f = 75mm projection lens
float pixelwidth=.032; //centimetres

//Grating parameters 
float xPos = 0.0;   
float Width = 1.0; // period in cm
float per = Width/pixelwidth; //period in pixels
float offset = 0.0;
float th = (PI)+offset;   //orientation in radians (0,1.5708,3.148)
float c = 0.5;     //contrast
Boolean square = true;  

float framerate = 120.0; //Refresh rate in Hz
float frameinterval = 1000.0/framerate;

//Flow speed calibration
float scal = 1/(framerate*per);

