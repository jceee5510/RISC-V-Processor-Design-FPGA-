module reg_32 ( input						Clk, Reset, Load,
					input						[31:0] D,
					output logic 			[31:0] Data_Out);
					
		always_ff @ (posedge Clk or posedge Reset)
		begin
				// Setting the output Q[16..0] of the register to zeros as Reset is pressed
				if(Reset)
					Data_Out <= 32'b00000000000000000000000000000000;
				// Loading D into register when load button is pressed (will eiher be switches or result of sum)
				else if(Load)
					Data_Out <= D;
		end
		
endmodule