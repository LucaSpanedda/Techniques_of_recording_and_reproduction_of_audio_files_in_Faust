// NOISES BANK
// bank of various noises (range: -1. +1.) with different random numbers
//
    // RANDOM GEN
    random_01  = +(1457932343)~*(1103515245);
    random_02  = +(4953953202)~*(1103515245);
    random_03  = +(6982333648)~*(1103515245);
    random_04  = +(8960458042)~*(1103515245);
    random_05  = +(6646529113)~*(1103515245);
    random_06  = +(8675675809)~*(1103515245);
    random_07  = +(1124564344)~*(1103515245);
    random_08  = +(3357544443)~*(1103515245);
    random_09  = +(7082007592)~*(1103515245);
    random_10  = +(1543334567)~*(1103515245);
    random_11  = +(1134644243)~*(1103515245);
    random_12  = +(4467204921)~*(1103515245);
    random_13  = +(2234562113)~*(1103515245);
    random_14  = +(4430211233)~*(1103515245);
    random_15  = +(1997401113)~*(1103515245);
    random_16  = +(1144788420)~*(1103515245);
    random_17  = +(7439923755)~*(1103515245);
    random_18  = +(7577042243)~*(1103515245);
    random_19  = +(1926662181)~*(1103515245);
    random_20  = +(9195694583)~*(1103515245);
//
    // NOISE GEN
    noise_01   = random_01/2147483647.0;
    noise_02   = random_02/2147483647.0;
    noise_03   = random_03/2147483647.0;
    noise_04   = random_04/2147483647.0;
    noise_05   = random_05/2147483647.0;
    noise_06   = random_06/2147483647.0;
    noise_07   = random_07/2147483647.0;
    noise_08   = random_08/2147483647.0;
    noise_09   = random_09/2147483647.0;
    noise_10   = random_10/2147483647.0;
    noise_11   = random_11/2147483647.0;
    noise_12   = random_12/2147483647.0;
    noise_13   = random_13/2147483647.0;
    noise_14   = random_14/2147483647.0;
    noise_15   = random_15/2147483647.0;
    noise_16   = random_16/2147483647.0;
    noise_17   = random_17/2147483647.0;
    noise_18   = random_18/2147483647.0;
    noise_19   = random_19/2147483647.0;
    noise_20   = random_20/2147483647.0;
//
noisebank = 
noise_01,
noise_02,
noise_03,
noise_04,
noise_05,
noise_06,
noise_07,
noise_08,
noise_09,
noise_10,
noise_11,
noise_12,
noise_13,
noise_14,
noise_15,
noise_16,
noise_17,
noise_18,
noise_19,
noise_20;
//
process = noisebank;
