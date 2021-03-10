// ---------------------------------------------------------------------------------

// Declarations
declare name 		"One Windowed Grain";
declare version 	"1.0";
declare author 		"Luca Spanedda";


/*
BASICS OF WRITING AND READING:
A SINGLE GRAIN READ IMPLEMENTED WITH THE RWTABLE
WITH A WINDOW FUNCTION IMPLEMENTED WITH THE READ
*/

// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");


/* 
The rwtable function recalls a space in the memory
to access the writing and reading operations of an audio file in faust.
In this implementation we will use it for read a section of a file
recorded in the memory:
rwtable(1,2,3,4,5)
1 - Table Size: size of the memory space in samples we will write
2 - Value of the initial table content
3 - The write index (an int between 0 and n-1): Write the signal 
4 - _ : the 4th argument of rwtable corresponds to the input of the table
5 - The read index (an int between 0 and n-1): Read the signal = Output
*/


// one_grain function:
// (+ a sine window/envelope)
//
// samplerate :
// define here the current sample rate used.
//
// recstart : 
// 1 = start recording, 0 = stop recording.
//
// memorydimension :
// is the dimension in milliseconds of the memory that we are writing
//
// startinms : 
// is the starting point defined in milliseconds where we start our read
//
// graindimension :
// after we have choose a starting point in ms. for the read
// we can choose how much after the starting point we want to read
// from the memory recorded
// ex. 100 ms. will read the first 100 ms. after the starting point
//
// readspeed :
// define the speed of the section that we are reading from the memory
// 1 = unaltered pitch, 2 = double speed, 0.5 = half speed.
//
one_grain(samplerate,recstart,memorydimension,startinms,graindimension,readspeed) 
// = rwtable * the envelope used
= rwtable(dimensioninsamp,0.0,indexwrite,_,indexread)*sinenv 
// the function contains:
with{

// ------------ READ SECTION ------------

    // dimensionsamp define the samples of the ms. we choose
    // as dimension for the memory we are writing
    dimensioninsamp = (samplerate/1000)*memorydimension : int;
    // startpointinsamp define in ms. the starting point of
    // our reading from the memory
    startpointinsamp = (samplerate/1000)*startinms : int;
    // grainlenghtinsamp define in ms. the dimension of the section
    // of our reading from the memory (after the starting point)
    grainlenghtinsamp = (samplerate / 1000)*graindimension : int;
    // speed of the phasor = 1Hz / dimension of the section in samples
    // (the memory dimension become long 1Hz for the readspeed)
    speeddivsamplerate = readspeed/grainlenghtinsamp;
    // (int force the output to be an integer)

    // The record function when it is at 0 does not record,
    // When it is at 1 it starts recording. 
    // (start count on indexwrite)
    // Int forces the number to come up with an integer.
    record = recstart : int; 

    // Indexwrite writes into the memory space.
    // Counting begins when the record equals 1.
    // Indexwrite counts until the dimention value is reached,
    // After which the count stops and restarts from the beginning, in loop.
    indexwrite = (+(1) : %(dimensioninsamp)) ~ *(record);
    
    // subtraction : rescale when reach 1 (1 = int. number)
    decimale(x)= x-int(x);
    // accomulation of the value: speeddivsamplerate, at each sample
    // (and rescale when is an integer number: 1)
    phasor = speeddivsamplerate : (+ : decimale) ~ _;
    // phasor * the dimension of the memory 
    // (read in a defined time all the memory stored).
    // startpointsamp define the initial offset where we start our read (in samps)
    // in this way we can choose the section where we can start our reading
    // from the memory.
    // grainlenghtinsamps rescale (in samps) the value of phasor for the reading
    // in this way the phasor is not 0 to 1, but 0 to grainlenghtinsamp
    // (after the startpoint).
    indexread = startpointinsamp+(phasor : *(float(grainlenghtinsamp))) : int;


// ------------ ENVELOPE SECTION ------------

    // we define here the constant - pi
    pi = 6.2831853071795/2;
    // we use our phasor as a driver for the envelope:
    // here we rescale the phasor 0 to 1, in 0 to pi
    phasor_pi = phasor * pi;
    // and after we use it as a driver for a sine envelope
    sinenv = sin(phasor_pi);
    // after all we send it as control for the amplitude of the rwtable


};


// signal out (process)
// one_grain(samplerate,recstart,memorydimension,startinms,graindimension,readspeed)
process =  one_grain(48000,1,500,400,100,1) <: _, _;

// ---------------------------------------------------------------------------------
