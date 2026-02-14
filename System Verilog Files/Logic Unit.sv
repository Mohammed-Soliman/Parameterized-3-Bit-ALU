module AxorB 
(
	input [2:0] A,
	input [2:0] B,
	output [2:0] Y
);

xor g1 (Y[0], A[0], B[0]);
xor g2 (Y[1], A[1], B[1]);
xor g3 (Y[2], A[2], B[2]);

endmodule


module AorB 
(
	input [2:0] A,
	input [2:0] B,
	output [2:0] Y
);

or g1 (Y[0], A[0], B[0]);
or g2 (Y[1], A[1], B[1]);
or g3 (Y[2], A[2], B[2]);

endmodule


module B_bar 
(
	input [2:0] B,
	output [2:0] Y
);

not g1 (Y[0], B[0]);
not g2 (Y[1], B[1]);
not g3 (Y[2], B[2]);

endmodule


module AandB 
(
	input [2:0] A,
	input [2:0] B,
	output [2:0] Y
);

and g1 (Y[0], A[0], B[0]);
and g2 (Y[1], A[1], B[1]);
and g3 (Y[2], A[2], B[2]);

endmodule


module Logic_Unit 
(
	input [2:0] A,
	input [2:0] B,
	input S1, S0,
	output [2:0] Y
);

wire [2:0] xor_result;
wire [2:0] or_result;
wire [2:0] and_result;
wire [2:0] B_result;
wire [2:0] mux1_result;
wire [2:0] mux2_result;

AandB g1 (A, B, and_result);
AxorB g2 (A, B, xor_result);
AorB g3 (A, B, or_result);
B_bar g4 (B, B_result);

ThreeBitMux2to1 g5 (and_result, xor_result, S0, mux1_result);
ThreeBitMux2to1 g6 (or_result, B_result, S0, mux2_result);
ThreeBitMux2to1 g7 (mux1_result, mux2_result, S1, Y);

endmodule