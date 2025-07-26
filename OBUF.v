module OBUF(
    output O,
    input I);
  parameter CAPACITANCE = "DONT_CARE";
  parameter IOSTANDARD = "DEFAULT";
  parameter DRIVE = 12;
  parameter SLEW = "SLOW";
  assign O = I;
endmodule
