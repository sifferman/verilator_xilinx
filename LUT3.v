`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// LUT3 primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

/* verilator coverage_off */
module LUT3
#(
    parameter [7:0] INIT = 8'b00000000
)
(
    input  wire I0, I1, I2,
    output wire O
);
    // from https://github.com/YosysHQ/yosys/blob/main/techlibs/xilinx/cells_sim.v
    wire [ 3: 0] s2 = I2 ? INIT[ 7: 4] : INIT[ 3: 0];
    wire [ 1: 0] s1 = I1 ?   s2[ 3: 2] :   s2[ 1: 0];
    assign O = I0 ? s1[1] : s1[0];

endmodule
/* verilator coverage_on */
