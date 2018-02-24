//Experiment design
boolean OpenLoop = false;
boolean Repeat = true;    //Allow multiple repeats or not

//Sequence of gain changes to be followed if repeat == true
float[][] GainSequence = {{1,1}};

//Sequence of flow changes
float[][] FlowSequence = {{0,1}};
//*** smoothing timecourse can be set in the Initialization tab ***
boolean smoothFlow = false; //Smooth transition between two flow settings
                         
//Duration of a single repeat in seconds
int[][] segmentduration = {{5,2}};

//Randomization
boolean gainRandomize = false;
int[][] gainRandPattern = {{0,1}};
float[] gainBucket = {0.5,2.0};

boolean flowRandomize = true;
int[][] flowRandPattern = {{0,1}};
float[] flowBucket = {1.0,0.5,2.0};

//Override flow value at certain trials
boolean flowOverride = true;
int[] flowOverrideTrials = {7,16,22,36,43,57}; //index from 0
int[][] flowOverridePattern = {{0,1}};
int flowOverrideValue = 0; 

//*** Maximum value is 1000ms. Change if necessary in the Initialization tab ***
int feedbackDelay = 1; //in milliseconds (must be non-zero) (@ 11.76Hz 2P imaging, feedbackDelay = 256 gives 3 frames)
boolean delayRandomize = false;
int[][] delayRandPattern = {{0,1}};
float[] delayBucket = {1,1,1,1,1,1,200,400};

// Stop optic flow after a single bout to isolate calcium responses for each bout
//*** bout detection threshold can be set in the Initialization tab ***
boolean boutClamp = true;
int[][] clampPattern = {{0,1}};
float clampAfter = 1; //milliseconds after bout end to stop baseline flow

int nrepeats = 60;                   //Repeats of the gain sequence per trial
int cycles = 1;                       //Number of cycles of each trial

String Genotype = "Aldoca:GCaMP6s ; Nacre -/-";
String DPF = "7";

String path = "D:/ClosedLoopRaw";
String basename = "test";
