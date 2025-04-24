#include "fir.h"

type_t CCS_BLOCK(fir)(type_t input, type_t taps[NUM_TAPS]) {
    static type_t delay_lane[NUM_TAPS] = {};

    SHIFT: for (int i = NUM_TAPS - 1; i > 0; i--) {
        delay_lane[i] = delay_lane[i - 1];
    }
    delay_lane[0] = input;

    type_t result = 0;
    MAC: for (int i = 0; i < NUM_TAPS; i++) {
        // result += (type_t) (delay_lane[i] * taps[i]); // for my_int_t
        result.add(result, (type_t) (delay_lane[i] * taps[i])); // for my_float_t
        // result = result + (type_t) (delay_lane[i] * taps[i]); // for my_complex_float_t
    }

    CCS_RETURN(result);
}

void test(ac_channel<type_t> &in_channel, ac_channel<type_t> &out_channel, type_t taps[NUM_TAPS]) {
    for (int i = 0; i < NUM_SAMPLES; i++) {
        type_t in_sample = in_channel.read();
        type_t out_sample = fir(in_sample, taps);
        out_channel.write(out_sample);
    }
}
