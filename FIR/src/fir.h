#include "types.h"
#include "ac_channel.h"
#include "mc_scverify.h"

#ifndef TYPE_T
#define TYPE_T int
#endif
typedef TYPE_T type_t;

#ifndef NUM_TAPS
#define NUM_TAPS 16
#endif

/* VERSION A: a single convolution of the filter */
// type_t CCS_BLOCK(fir)(type_t input, type_t taps[NUM_TAPS]);

/* VERSION B: a streaming filter processing NUM_SAMPLES samples */
void CCS_BLOCK(fir)(ac_channel<type_t> &in_channel, ac_channel<type_t> &out_channel, type_t taps[NUM_TAPS]);

#define NUM_SAMPLES 1024

void CCS_BLOCK(test)(ac_channel<type_t> &in_channel, ac_channel<type_t> &out_channel, type_t taps[NUM_TAPS]);
