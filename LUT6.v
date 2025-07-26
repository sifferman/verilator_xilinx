`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// LUT6 primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

/* verilator coverage_off */
module LUT6
#(
    parameter [63:0] INIT = 64'h0000000000000000
)
(
    input  wire I0, I1, I2, I3, I4, I5,
    output wire O
);
    // from https://github.com/YosysHQ/yosys/blob/main/techlibs/xilinx/cells_sim.v
    wire [31: 0] s5 = I5 ? INIT[63:32] : INIT[31: 0];
    wire [15: 0] s4 = I4 ?   s5[31:16] :   s5[15: 0];
    wire [ 7: 0] s3 = I3 ?   s4[15: 8] :   s4[ 7: 0];
    wire [ 3: 0] s2 = I2 ?   s3[ 7: 4] :   s3[ 3: 0];
    wire [ 1: 0] s1 = I1 ?   s2[ 3: 2] :   s2[ 1: 0];
    assign O = I0 ? s1[1] : s1[0];

endmodule
/* verilator coverage_on */
