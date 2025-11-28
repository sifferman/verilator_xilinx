// from https://github.com/YosysHQ/yosys/blob/main/techlibs/xilinx/cells_sim.v
(* abc9_box, lib_whitebox *)
module RAM32X1D (
  output DPO, SPO,
  input  D,
  (* clkbuf_sink *)
  (* invertible_pin = "IS_WCLK_INVERTED" *)
  input  WCLK,
  input  WE,
  input  A0, A1, A2, A3, A4,
  input  DPRA0, DPRA1, DPRA2, DPRA3, DPRA4
);
  parameter INIT = 32'h0;
  parameter IS_WCLK_INVERTED = 1'b0;
  wire WE_AND_NONINVERTED = WE & ~IS_WCLK_INVERTED;
  wire WE_AND_INVERTED = WE &  IS_WCLK_INVERTED;
  wire [4:0] a = {A4, A3, A2, A1, A0};
  wire [4:0] dpra = {DPRA4, DPRA3, DPRA2, DPRA1, DPRA0};
  reg [31:0] mem = INIT;
  assign SPO = mem[a];
  assign DPO = mem[dpra];
  wire clk = WCLK ^ IS_WCLK_INVERTED;
  always @(posedge clk) if (WE) mem[a] <= D;
  specify
    // Max delay from: https://github.com/SymbiFlow/prjxray-db/blob/31f51ac5ec7448dd6f79a8267f147123e4413c21/artix7/timings/CLBLM_R.sdf#L986
    $setup(D , posedge WCLK &&& WE_AND_NONINVERTED, 453);
    $setup(D , negedge WCLK &&& WE_AND_INVERTED, 453);
    // Max delay from: https://github.com/SymbiFlow/prjxray-db/blob/31f51ac5ec7448dd6f79a8267f147123e4413c21/artix7/timings/CLBLM_R.sdf#L834
    $setup(WE, posedge WCLK &&& !IS_WCLK_INVERTED, 654);
    $setup(WE, negedge WCLK &&&  IS_WCLK_INVERTED, 654);
    // Max delay from: https://github.com/SymbiFlow/prjxray-db/blob/31f51ac5ec7448dd6f79a8267f147123e4413c21/artix7/timings/CLBLM_R.sdf#L800
    $setup(A0, posedge WCLK &&& WE_AND_NONINVERTED, 245);
    $setup(A0, negedge WCLK &&& WE_AND_INVERTED, 245);
    // Max delay from: https://github.com/SymbiFlow/prjxray-db/blob/31f51ac5ec7448dd6f79a8267f147123e4413c21/artix7/timings/CLBLM_R.sdf#L798
    $setup(A1, posedge WCLK &&& WE_AND_NONINVERTED, 208);
    $setup(A1, negedge WCLK &&& WE_AND_INVERTED, 208);
    // Max delay from: https://github.com/SymbiFlow/prjxray-db/blob/31f51ac5ec7448dd6f79a8267f147123e4413c21/artix7/timings/CLBLM_R.sdf#L796
    $setup(A2, posedge WCLK &&& WE_AND_NONINVERTED, 147);
    $setup(A2, negedge WCLK &&& WE_AND_INVERTED, 147);
    // Max delay from: https://github.com/SymbiFlow/prjxray-db/blob/31f51ac5ec7448dd6f79a8267f147123e4413c21/artix7/timings/CLBLM_R.sdf#L794
    $setup(A3, posedge WCLK &&& WE_AND_NONINVERTED, 68);
    $setup(A3, negedge WCLK &&& WE_AND_INVERTED, 68);
    // Max delay from: https://github.com/SymbiFlow/prjxray-db/blob/31f51ac5ec7448dd6f79a8267f147123e4413c21/artix7/timings/CLBLM_R.sdf#L792
    $setup(A4, posedge WCLK &&& WE_AND_NONINVERTED, 66);
    $setup(A4, posedge WCLK &&& WE_AND_INVERTED, 66);
    // Max delay from: https://github.com/SymbiFlow/prjxray-db/blob/31f51ac5ec7448dd6f79a8267f147123e4413c21/artix7/timings/CLBLM_R.sdf#L981
    if (!IS_WCLK_INVERTED) (posedge WCLK => (SPO : D))    = 1153;
    if (!IS_WCLK_INVERTED) (posedge WCLK => (DPO : 1'bx)) = 1153;
    if ( IS_WCLK_INVERTED) (posedge WCLK => (SPO : D))    = 1153;
    if ( IS_WCLK_INVERTED) (negedge WCLK => (DPO : 1'bx)) = 1153;
    (A0 => SPO) = 642; (DPRA0 => DPO) = 642;
    (A1 => SPO) = 632; (DPRA1 => DPO) = 631;
    (A2 => SPO) = 472; (DPRA2 => DPO) = 472;
    (A3 => SPO) = 407; (DPRA3 => DPO) = 407;
    (A4 => SPO) = 238; (DPRA4 => DPO) = 238;
  endspecify
endmodule
