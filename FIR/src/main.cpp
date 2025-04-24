#include "fir.h"
#include <stdio.h>

CCS_MAIN(int argc, char *argv[]) {
    ac_channel<type_t> in_channel;
    ac_channel<type_t> out_channel;

    type_t taps[NUM_TAPS] = {-37, -90, -115, -85, 12,  152,  315, 470,
                             470, 315, 152,  12,  -85, -115, -90, -37};

    type_t signal[NUM_SAMPLES] = {1, 0, 0, 0, 0, 0, 0, 0,
                                  0, 0, 0, 0, 0, 0, 0, 0};

    for (int i = 0; i < NUM_SAMPLES; i++) {
        in_channel.write(signal[i]);
    }

    test(in_channel, out_channel, taps);

    // for (int i = 0; i < NUM_SAMPLES; i++) {
    //     if (!out_channel.empty()) {
    //         printf("Output[%d] = %d\n", i, out_channel.read().to_int()); //
    //         NOTE: need to use conversion method for correct output
    //     }
    // }

    CCS_RETURN(0);
}
