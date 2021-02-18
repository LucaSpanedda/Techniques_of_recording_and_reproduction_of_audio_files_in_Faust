// -----------------------------------------------------------------------------

// Declarations
declare name 		"Classic Looper";
declare version 	"0.1";
declare author 		"Luca Spanedda";


/*
BASICS OF WRITING AND READING:
A CLASSIC LOOPER IMPLEMENTED WITH THE RWTABLE
*/

// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");


/* 
The rwtable function recalls a space in the memory
to access the writing and reading operations of an audio file in faust.
In this implementation we will use it for a looped write and read on a table.

The rwtable is followed and defined by 5 arguments,
which determine its functioning:

rwtable(1,2,3,4,5)

1 - Table Size: size of the memory space in samples we will write
2 - Value of the initial table content
3 - The write index (an int between 0 and n-1): Write the signal 
4 - _ : the 4th argument of rwtable corresponds to the input of the table
5 - The read index (an int between 0 and n-1): Read the signal = Output
*/

// classiclooper function:
//
// readspeed :
// define the speed of reading the table
// 1 = unaltered pitch, 2 = double speed, 0.5 = half speed.
//
// recvalue: 
// 1 = start recording, 0 = stop recording.
//
classiclooper(readspeed,recvalue) = rwtable(dimension,0.0,indexwrite,_,indexread)
// the function contains:
with{

    // The record function when it is at 0 does not record,
    // When it is at 1 it starts recording. 
    // (start count on indexwrite)
    // Int forces the number to come up with an integer.
    record = recvalue : int; 

    // Dimension is the size of the memory space to be recorded in samples,
    dimension = 48000; 

    // Indexwrite writes into the memory space.
    // Counting begins when the record equals 1.
    // Indexwrite counts until the dimention value is reached,
    // After which the count stops and restarts from the beginning, in loop.
    indexwrite = (+(1) : %(dimension)) ~ *(record);

    // Indexread reads from memory space.
    // We write a phasor that the task of pointing to 
    // the reading point of the table
    indexread = readspeed/float(ma.SR) : (+ : ma.decimal) ~ _ : 
    *(float(dimension)) : int;

};

// signal out (process)
// classiclooper(readspeed,recvalue)
process = classiclooper(1,0) <: _, _;

// -----------------------------------------------------------------------------