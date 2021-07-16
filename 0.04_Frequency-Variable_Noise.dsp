// -----------------------------------------------------------------------------

// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// NOISE WITH VARIABLE FREQUENCY
    // Change the seed value for generate a different noise
    // Change the freq value for a frequency based output value
    varnoise(freq,seed)  = ((seed) : (+ @(ma.SR/freq)~ *(1103515245))) /2147483647.0; 

process = varnoise(1,1457932343);

// -----------------------------------------------------------------------------
