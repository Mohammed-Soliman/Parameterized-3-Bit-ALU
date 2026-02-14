module Comparator 
(
	input A, B,
	output G_T, Eq
);

wire B_bar;

xnor g1 (Eq, A, B);
not g2 (B_bar, B);
and g3 (G_T, A, B_bar);

endmodule


module Compare_Unit 
(
	input [2:0] A,
	input [2:0] B,
	output G_T, L_T, Eq
);

wire g1, g2, g3, e1, e2, e3, d1, d2;

Comparator a1 (A[0], B[0], g1, e1);
Comparator a2 (A[1], B[1], g2, e2);
Comparator a3 (A[2], B[2], g3, e3);

and a4 (Eq, e3, e2, e1);
and a5 (d1, e2, e3, g1);
and a6 (d2, e1, g2);
or a7 (G_T, g3, d1, d2);
nor a8 (L_T, Eq, G_T);

endmodule