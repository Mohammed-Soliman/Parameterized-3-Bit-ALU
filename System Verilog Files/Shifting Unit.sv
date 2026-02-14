module ShiftingLeft 
(
	input [2:0] A, 
	input [2:0] B, 
	output [2:0] Y
);

Multiplixer4to1 g1 (A[2], A[1], A[0], 1'b0, B, Y[2]);
Multiplixer4to1 g2 (A[1], A[0], 1'b0, 1'b0, B, Y[1]);
Multiplixer4to1 g3 (A[0], 1'b0, 1'b0, 1'b0, B, Y[0]);

endmodule


module ShiftingRight 
(
	input [2:0] A, 
	input [2:0] B, 
	output [2:0] Y
);

Multiplixer4to1 g1 (A[2], 1'b0, 1'b0, 1'b0, B, Y[2]);
Multiplixer4to1 g2 (A[1], A[2], 1'b0, 1'b0, B, Y[1]);
Multiplixer4to1 g3 (A[0], A[1], A[2], 1'b0, B, Y[0]);

endmodule


module Shifting_Unit
(
	input [2:0] A, 
	input [2:0] B,
	input S0, 
	output [2:0] Y
);

wire [3:0] ShiftRightResult;
wire [3:0] ShiftLefttResult;

ShiftingRight g1 (A, B, ShiftRightResult);
ShiftingLeft g2 (A, B, ShiftLefttResult);
ThreeBitMux2to1 g3 (ShiftLefttResult, ShiftRightResult, S0, Y);

endmodule