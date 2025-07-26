`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// LUT2 primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

/* verilator coverage_off */
module LUT2
#(
    parameter [3:0] INIT = 4'b0000
)
(
    input  wire I0, I1,
    output wire O
);
    // from https://github.com/YosysHQ/yosys/blob/main/techlibs/xilinx/cells_sim.v
    wire [ 1: 0] s1 = I1 ? INIT[ 3: 2] : INIT[ 1: 0];
    assign O = I0 ? s1[1] : s1[0];

endmodule
/* verilator coverage_on */
