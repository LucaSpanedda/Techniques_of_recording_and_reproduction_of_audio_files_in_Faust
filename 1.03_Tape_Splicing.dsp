// -----------------------------------------------------------------------------

// Declarations
declare name 		"Time Splicing";
declare version 	"0.1";
declare author 		"Luca Spanedda";


/*
TIME SPLICING:
WRITING AND READING WITH SCATTERING
ON A FIXED TABLE OF 1 SECOND (TAPE)
*/

// import Standard Faust library
// https://github.com/grame-cncm/faustlibraries/
import("stdfaust.lib");

// SCATTERING READER
scatteringreader(freqscattering,freqphasor) = hsp_phasor
with{
    // NOISE GENERATION
    random  = +(12345)~*(1103515245);
    noise   = random/2147483647.0;
    // IMPULSE GENERATION
    decimal(x)= x-int(x);
    phase = freqscattering/float(ma.SR) : (+ : decimal) ~ _;
    saw = phase-0.5;
    ifpos = (saw > 0);
    trig = ( ifpos - (ifpos@(1)) ) > 0;
    // SAH THE NOISE FUNCTION (with the impulse)
    sahrandom = (*(1 - trig) + noise * trig) ~ _;
    sehout = (sahrandom +1) / 2;
    // PHASOR HACKED
    inc = freqphasor/float(ma.SR);
    hsp_phasor = inc : (+ : ma.decimal)~(-(_<:(_,*(_,trig))):+(trig*sehout));
};

// TAPE-SPLICER max. lenght 1 second for every sample rate
tapesplicer(recstart,fscatter,fphasor) = rwtable(dimension,0.0,indexwrite,_,indexread)
with{
    record = recstart : int; 
    dimension = 192000;
    indexwrite = (+(1) : %(ma.SR : int)) ~ *(record);
    indexread = scatteringreader(fscatter,fphasor) : *(float(ma.SR)) : int;
};

process = tapesplicer(1,1,1) : _;

// ---------------------------------------------------------------------------------
