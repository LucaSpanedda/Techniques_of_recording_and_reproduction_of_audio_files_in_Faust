// ---------------------------------------------------------------------------------

// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

/*
TIME SPLICING:
WRITING AND READING WITH SCATTERING
ON A FIXED TABLE OF 1 SECOND (TAPE)
*/

// SCATTERING READER
scatteringreader(freqnoise,freqphasor,seed) = scatteringphasor
with{
    // Change the seed value for generate a different noise
    // Change the freqnoise value for a frequency based scattering
    // change the freqphasor for change the Hz of the scatteringphasor
    varnoise = ( (seed) : (+ @(ma.SR/freqnoise)~ *(1103515245)))/2147483647.0;
    scatteringphasor = (freqphasor/float(ma.SR)) : (+:ma.decimal)~ 
    (-(_<:(_,*(_,varnoise-varnoise@(1)))):+(varnoise-varnoise@(1)));
};

// TAPE-SPLICER max. lenght 1 second for every sample rate
tapesplicer(recstart,fscatter,fphasor,noiseseed) = 
rwtable(dimension,0.0,indexwrite,_,indexread)
with{
    record = recstart : int; 
    dimension = 192000;
    indexwrite = (+(1) : %(ma.SR : int)) ~ *(record);
    indexread = scatteringreader(fscatter,fphasor,noiseseed) : *(float(ma.SR)) : int;
};

process = tapesplicer(1,1,1,1457932343) <:_,_;

// ---------------------------------------------------------------------------------
