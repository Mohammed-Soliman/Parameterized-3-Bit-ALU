module FA 
(
  input wire x,
  input wire y,
  input wire z,
  output wire S,
  output wire C
);

  assign S = x ^ y ^ z;
  assign C = (x & y) | (y & z) | (z & x);

endmodule


module Ripple_adder 
(
	input [2:0] A, 
	input [2:0] B, 
	input Cin,
	output [2:0] Sum, 
	output Cout
);

wire c1, c2;

FA add1 (A[0], B[0], Cin, Sum[0], c1);
FA add2 (A[1], B[1], c1, Sum[1], c2);
FA add3 (A[2], B[2], c2, Sum[2], Cout);

endmodule


module Arithmitic_Unit
(
	input [2:0] A,
	input [2:0] B,
	input S0, S1,
	output [2:0] Y,
	output Cout
);

wire [2:0] d0;
wire [2:0] d1;

//wire A_bar;
ThreeBitMux2to1 g1 (B, 3'b000, S1, d0);

//B_bar g3 (A, A_bar);
//ThreeBitMux2to1 g2 (A, A_bar, S0, d1);
ThreeBitMux2to1 g2 (A, ~A, S0, d1);
Ripple_adder add1 (d0, d1, S0, Y, Cout);

endmodule



