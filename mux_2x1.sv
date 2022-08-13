module mux_2x1 #(parameter width = 32) 
					 (input logic S,
					  input logic [width - 1:0] A, B,
					  output logic [width - 1:0] Output);

	always_comb
	begin
		unique case(S)
			1'b0: Output = A;
			1'b1: Output = B;
			default: Output = 16'bx;
		endcase
	end
	
endmodule

module mux_4x1 (input logic [1:0]S,
								input logic [31:0] A, B, C, D,
								output logic [31:0] Output);

	always_comb
	begin
		unique case(S)
			2'b00: Output = A;
			2'b01: Output = B;
			2'b10: Output = C;
			2'b11: Output = D;
			default: Output = 16'bx;
		endcase
	end
	
endmodule