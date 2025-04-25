#include "types.h"
#include "ac_channel.h"
#include "mc_scverify.h"

#ifndef TYPE_T
#define TYPE_T my_float_t
#endif
typedef TYPE_T type_t;

#ifndef NUM_TAPS
#define NUM_TAPS 16
#endif

type_t CCS_BLOCK(fir)(type_t input, type_t taps[NUM_TAPS]);

#define NUM_SAMPLES 16

void test(ac_channel<type_t> &in_channel, ac_channel<type_t> &out_channel, type_t taps[NUM_TAPS]);
