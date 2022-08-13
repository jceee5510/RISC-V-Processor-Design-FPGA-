module registerfile(input logic Clk, Reset, Load,
							input logic [31:0] D,
							input logic [4:0] addrD, addrA, addrB,
							output logic [31:0] dataA, dataB);
	
	
	logic [31:0] reg_files [31:0];

	always_ff @ (posedge Clk or posedge Reset)
	begin
				// Setting the output Q[16..0] of the register to zeros as Reset is pressed
		if(Reset)
		begin
			reg_files <= '{default:32'b00000000000000000000000000000000};
		end
		else if(Load)
			reg_files[addrD] <= D;
	end
		
	assign dataA = reg_files[addrA];
	assign dataB = reg_files[addrB];
	
endmodule