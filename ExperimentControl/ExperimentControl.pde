//Experiment design
boolean OpenLoop = false;
boolean Repeat = true;    //Allow multiple repeats or not

float movement_scaling = 1. ; //scaling factor for calibrating gain
//Sequence of gain changes to be followed if repeat == true
float[][] GainSequence = {{0,1},{0,1}};

//Sequence of flow changes
float[][] FlowSequence = {{0,1},{0,1}};
//*** smoothing timecourse can be set in the Initialization tab ***
boolean smoothFlow = false; //Smooth transition between two flow settings
                         
//Duration of a single repeat in seconds
int[][] segmentduration = {{5,2},{5,2}};

//Randomization
boolean gainRandomize = false;
int[][] gainRandPattern = {{0,1},{0,1}};
float[] gainBucket = {0.5,2.0};

boolean flowRandomize = false;
int[][] flowRandPattern = {{0,1},{0,1}};
float[] flowBucket = {1.0,0.5,2.0};

//Override flow value at certain trials
boolean flowOverride = false;
int[] flowOverrideTrials = {6, 12, 29, 36, 45, 53, 66, 70, 85, 95}; //index from 0
int[][] flowOverridePattern = {{0,1},{0,1}};
int flowOverrideValue = 0;
boolean overrideRandomize = false;
float[] overrideBucket = {0,0.5,2};

//Optogenetic stimulation
boolean optoStim = true;
int[] optoStimTrials = {4, 7, 11, 16, 23, 26, 30, 35, 41, 45, 54, 55, 60, 66, 71, 76, 84, 88, 92, 99}; //index from 0
float optoStimDelay = 5.0; // time (seconds) to wait from trial onset before triggering stimulation
float optoStimDuration = 2.0; // duration (seconds) of a stimulation pulse;

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

int[] subreps = {50,50};          //Repeats of each block before going to the next
int nrepeats = 1;                     //Repeats of the gain sequence per trial
int cycles = 1;                       //Number of cycles of each trial

String Genotype = "Ca8:ChR2-mCherry ; Nacre -/- ; ChR2+ve";
String DPF = "6";

//String path = "D:/ClosedLoopRaw/";
String path = "C:/Users/CIFF/Desktop/";

String basename = "test";

boolean boutTimeLog = false;
