module OneBitMux2to1 
(
	input A, 
	input B, 
	input S, 
	output Y
);

assign Y = S ? B:A;

endmodule 


module ThreeBitMux2to1 
(
	input [2:0] A, 
	input [2:0] B, 
	input S, 
	output [2:0] Y
);

OneBitMux2to1 g1 (A[0], B[0], S, Y[0]);
OneBitMux2to1 g2 (A[1], B[1], S, Y[1]);
OneBitMux2to1 g3 (A[2], B[2], S, Y[2]);

endmodule 


module Multiplixer4to1
(
	input A,
	input B,
	input C,
	input D,
	input [2:0] S,
	output reg Y
);

wire [1:0] shift_amount = S[1:0];
always @(*) begin
    case (shift_amount)
        2'b00: Y = A;
        2'b01: Y = B;
        2'b10: Y = C;
        2'b11: Y = D;
        default: Y = 1'b0;
    endcase
end

endmodule