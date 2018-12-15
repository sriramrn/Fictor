//Experiment design
boolean OpenLoop = true;
boolean Repeat = false;    //Allow multiple repeats or not

float movement_scaling = 1.0 ; //scaling factor for calibrating gain
//Sequence of gain changes to be followed if repeat == true
float[][] GainSequence = {{0,1},{0,1}};

//Sequence of flow changes
float[][] FlowSequence = {{1,1},{0,1}};
//*** smoothing timecourse can be set in the Initialization tab ***
boolean smoothFlow = false; //Smooth transition between two flow settings
                         
//Duration of a single repeat in seconds
int[][] segmentduration = {{5,2},{7,2}};

//Randomization
boolean gainRandomize = false;
int[][] gainRandPattern = {{0,1},{0,1}};
float[] gainBucket = {0.5,2.0};

boolean flowRandomize = false;
int[][] flowRandPattern = {{0,1},{0,1}};
float[] flowBucket = {1.0,0.5,2.0};

//Override flow value at certain trials
boolean flowOverride = true;
int[] flowOverrideTrials = {5, 19, 24, 31, 44, 52, 68, 78, 87, 96, 104, 115}; //index from 0
int[][] flowOverridePattern = {{0,1},{0,1}};
int flowOverrideValue = 0; 

//*** Maximum value is 1000ms. Change if necessary in the Initialization tab ***
int feedbackDelay = 1; //in milliseconds (must be non-zero) (@ 11.76Hz 2P imaging, feedbackDelay = 256 gives 3 frames)
boolean delayRandomize = false;
int[][] delayRandPattern = {{0,1},{0,1}};
float[] delayBucket = {1,1,1,1,1,1,200,400};

// Stop optic flow after a single bout to isolate calcium responses for each bout
//*** bout detection threshold can be set in the Initialization tab ***
boolean boutClamp = false;
int[][] clampPattern = {{0,1},{0,1}};
float clampAfter = 1; //milliseconds after bout end to stop baseline flow

int[] subreps = {60,60};             //Repeats of each block before going to the next
int nrepeats = 1;                    //Repeats of the gain sequence per trial
int cycles = 1;                      //Number of cycles of each trial

String Genotype = "Aldoca:GCaMP6s ; Nacre -/-";
String DPF = "7";

String path = "D:/ClosedLoopRaw/";
String basename = "F1_Cal";

boolean boutTimeLog = false;
