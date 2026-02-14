module ALU 
(
	      input [2:0] A,
	      input [2:0] B,
	      input [3:0] S,
	      output [2:0] F,
	      output V,
	      output Z,
	      output GreaterThan, 
	      output LessThan,
	      output Equal
);
wire [2:0] Arith_result;
wire [2:0] logic_result;
wire [2:0] shift_result;
wire [2:0] mux1_result;
wire Cout;
wire overflow;

Arithmitic_Unit g1 (A, B, S[0], S[1], Arith_result, Cout);
Logic_Unit g2 (A, B, S[1], S[0], logic_result);
Shifting_Unit g3 (A, B, S[0], shift_result);
ThreeBitMux2to1 g4 (logic_result, shift_result, S[2], mux1_result);
ThreeBitMux2to1 g5 (Arith_result, mux1_result, S[3], F);
Compare_Unit g6 (A, B, GreaterThan, LessThan, Equal);
xor g7 (overflow, Cout, S[0]);
OneBitMux2to1 g8 (overflow, 1'b0, S[3], V);
nor g9 (Z, F[2], F[1], F[0]);

endmodule


module ALU_tb();
    logic [2:0] A;
    logic [2:0] B;
    logic [3:0] S;
    logic [2:0] y;
    logic Z;
    logic V;
    logic LessThan;
    logic GreaterThan;
    logic Equal;
    logic LessThan_expected;
    logic GreaterThan_expected;
    logic Equal_expected;
    logic [2:0] y_expected;
    logic V_expected;
    logic Z_expected;
    ALU DUT (.A(A), .B(B), .S(S), .F(y), .V(V), .Z(Z), .GreaterThan(GreaterThan), .LessThan(LessThan), .Equal(Equal));

    initial 
     begin
	// Test 1: Add (0000)
        A = 3'b001; B = 3'b000; S = 4'b0000;
        y_expected = 3'b001; V_expected = 0; Z_expected = 0; LessThan_expected = 0; GreaterThan_expected = 1; Equal_expected = 0; #100;
        assert (y === y_expected && Z === Z_expected && V === V_expected && Equal == Equal_expected && GreaterThan == GreaterThan_expected && LessThan == LessThan_expected) 
	else $error("Add failed. F = %b (expected = %b), V = %b (expected = %b), Z = %b (expected = %b), GreaterThan = %b (expected = %b), LessThan = %b (expected = %b), Equal = %b (expected = %b)", 
	y, y_expected, V, V_expected, Z, Z_expected, GreaterThan, GreaterThan_expected, LessThan, LessThan_expected, Equal, Equal_expected);
        
	// Test 2: Subtract (0001): B - A = 000 - 001 = 111 
        A = 3'b001; B = 3'b000; S = 4'b0001;
        y_expected = 3'b111; V_expected = 0; Z_expected = 0; LessThan_expected = 0; GreaterThan_expected = 1; Equal_expected = 0; #100;
        assert (y === y_expected && Z === Z_expected && V === V_expected && Equal == Equal_expected && GreaterThan == GreaterThan_expected && LessThan == LessThan_expected) 
	else $error("Subtract failed. F = %b (expected = %b), V = %b (expected = %b), Z = %b (expected = %b), GreaterThan = %b (expected = %b), LessThan = %b (expected = %b), Equal = %b (expected = %b)", 
	y, y_expected, V, V_expected, Z, Z_expected, GreaterThan, GreaterThan_expected, LessThan, LessThan_expected, Equal, Equal_expected);
        
        // Test 3: 2's Complement of A (0011): A' + 1 = ~001 + 1 = 110 + 1 = 111
        A = 3'b001; B = 3'b000; S = 4'b0011;
        y_expected = 3'b111; V_expected = 0; Z_expected = 0; LessThan_expected = 0; GreaterThan_expected = 1; Equal_expected = 0; #100;
        assert (y === y_expected && Z === Z_expected && V === V_expected && Equal == Equal_expected && GreaterThan == GreaterThan_expected && LessThan == LessThan_expected) 
	else $error("2's compliment failed. F = %b (expected = %b), V = %b (expected = %b), Z = %b (expected = %b), GreaterThan = %b (expected = %b), LessThan = %b (expected = %b), Equal = %b (expected = %b)", 
	y, y_expected, V, V_expected, Z, Z_expected, GreaterThan, GreaterThan_expected, LessThan, LessThan_expected, Equal, Equal_expected);
        
        // Test 4: A AND B (1000)
        A = 3'b101; B = 3'b011; S = 4'b1000;
        y_expected = 3'b001; V_expected = 0; Z_expected = 0; LessThan_expected = 0; GreaterThan_expected = 1; Equal_expected = 0; #100;
        assert (y === y_expected && Z === Z_expected && V === V_expected && Equal == Equal_expected && GreaterThan == GreaterThan_expected && LessThan == LessThan_expected) 
	else $error("AND failed. F = %b (expected = %b), V = %b (expected = %b), Z = %b (expected = %b), GreaterThan = %b (expected = %b), LessThan = %b (expected = %b), Equal = %b (expected = %b)", 
	y, y_expected, V, V_expected, Z, Z_expected, GreaterThan, GreaterThan_expected, LessThan, LessThan_expected, Equal, Equal_expected);
        
        // Test 5: A XOR B (1001)
        A = 3'b101; B = 3'b011; S = 4'b1001;
        y_expected = 3'b110; V_expected = 0; Z_expected = 0; LessThan_expected = 0; GreaterThan_expected = 1; Equal_expected = 0; #100;
        assert (y === y_expected && Z === Z_expected && V === V_expected && Equal == Equal_expected && GreaterThan == GreaterThan_expected && LessThan == LessThan_expected) 
	else $error("XOR failed. F = %b (expected = %b), V = %b (expected = %b), Z = %b (expected = %b), GreaterThan = %b (expected = %b), LessThan = %b (expected = %b), Equal = %b (expected = %b)", 
	y, y_expected, V, V_expected, Z, Z_expected, GreaterThan, GreaterThan_expected, LessThan, LessThan_expected, Equal, Equal_expected);
        
        // Test 6: A OR B (1010)
        A = 3'b101; B = 3'b011; S = 4'b1010;
        y_expected = 3'b111; V_expected = 0; Z_expected = 0; LessThan_expected = 0; GreaterThan_expected = 1; Equal_expected = 0; #100;
        assert (y === y_expected && Z === Z_expected && V === V_expected && Equal == Equal_expected && GreaterThan == GreaterThan_expected && LessThan == LessThan_expected) 
	else $error("OR failed. F = %b (expected = %b), V = %b (expected = %b), Z = %b (expected = %b), GreaterThan = %b (expected = %b), LessThan = %b (expected = %b), Equal = %b (expected = %b)", 
	y, y_expected, V, V_expected, Z, Z_expected, GreaterThan, GreaterThan_expected, LessThan, LessThan_expected, Equal, Equal_expected);
        
        // Test 7: B' (1?s Complement) (1011)
        A = 3'b000; B = 3'b101; S = 4'b1011;
        y_expected = 3'b010; V_expected = 0; Z_expected = 0; LessThan_expected = 1; GreaterThan_expected = 0; Equal_expected = 0; #100;
        assert (y === y_expected && Z === Z_expected && V === V_expected && Equal == Equal_expected && GreaterThan == GreaterThan_expected && LessThan == LessThan_expected) 
	else $error("NOT failed. F = %b (expected = %b), V = %b (expected = %b), Z = %b (expected = %b), GreaterThan = %b (expected = %b), LessThan = %b (expected = %b), Equal = %b (expected = %b)", 
	y, y_expected, V, V_expected, Z, Z_expected, GreaterThan, GreaterThan_expected, LessThan, LessThan_expected, Equal, Equal_expected);
        
        // Test 8: Logical Shift Left (1100)
        A = 3'b101; B = 3'b000; S = 4'b1100; 
        y_expected = 3'b101; V_expected = 0; Z_expected = 0; LessThan_expected = 0; GreaterThan_expected = 1; Equal_expected = 0; #100;
        assert (y === y_expected && Z === Z_expected && V === V_expected && Equal == Equal_expected && GreaterThan == GreaterThan_expected && LessThan == LessThan_expected) 
	else $error("Logical shift left failed. F = %b (expected = %b), V = %b (expected = %b), Z = %b (expected = %b), GreaterThan = %b (expected = %b), LessThan = %b (expected = %b), Equal = %b (expected = %b)", 
	y, y_expected, V, V_expected, Z, Z_expected, GreaterThan, GreaterThan_expected, LessThan, LessThan_expected, Equal, Equal_expected);
        
        A = 3'b101; B = 3'b001; S = 4'b1100; 
        y_expected = 3'b010; V_expected = 0; Z_expected = 0; LessThan_expected = 0; GreaterThan_expected = 1; Equal_expected = 0; #100;
        assert (y === y_expected && Z === Z_expected && V === V_expected && Equal == Equal_expected && GreaterThan == GreaterThan_expected && LessThan == LessThan_expected) 
	else $error("Logical shift left failed. F = %b (expected = %b), V = %b (expected = %b), Z = %b (expected = %b), GreaterThan = %b (expected = %b), LessThan = %b (expected = %b), Equal = %b (expected = %b)", 
	y, y_expected, V, V_expected, Z, Z_expected, GreaterThan, GreaterThan_expected, LessThan, LessThan_expected, Equal, Equal_expected);
        
        // Test 9: Logical Shift Right (1101)
        A = 3'b101; B = 3'b000; S = 4'b1101; 
        y_expected = 3'b101; V_expected = 0; Z_expected = 0; LessThan_expected = 0; GreaterThan_expected = 1; Equal_expected = 0; #100;
        assert (y === y_expected && Z === Z_expected && V === V_expected && Equal == Equal_expected && GreaterThan == GreaterThan_expected && LessThan == LessThan_expected) 
	else $error("Logical shift right failed. F = %b (expected = %b), V = %b (expected = %b), Z = %b (expected = %b), GreaterThan = %b (expected = %b), LessThan = %b (expected = %b), Equal = %b (expected = %b)", 
	y, y_expected, V, V_expected, Z, Z_expected, GreaterThan, GreaterThan_expected, LessThan, LessThan_expected, Equal, Equal_expected);
         
	$display("All test cases finished.");
    end

endmodule
