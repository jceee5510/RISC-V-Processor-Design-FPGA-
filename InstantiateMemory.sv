`include "RISCV_Opcode_Constants.sv"
import RISCV_Opcode_Constants::*;


module InstantiateMemory(input Reset,
							input Clk,
							input logic [31:0] addr,
							output logic wren,
							output logic [31:0] data);
							
	logic [31:0] mem_out;
	logic [15:0] address;
	logic [31:0] out;
	logic acc;
							
	enum logic [1:0] {idle, active, done} state, next_state;
	
	always_ff@(posedge Clk or posedge Reset) 
		begin
			if (Reset)
				state <= active;
			else
				state <= next_state;
		end
	 
	 
	 always_ff@(posedge Clk or posedge Reset)
		begin
			if (Reset)
				address <= 16'h0;
			else if (acc)

					address <= address + 1;
				
			else
				address <= address;
			
		end
	 
	 always_comb begin
	 
		  next_state = state;
		  
		  unique case(state)
		  idle: ;
		  active: begin
			  if(address == 16'hff)
					next_state = done;
				else
					next_state = active;
				end
		  done:
				next_state = idle;

		 endcase
		 
	 end
	 
	 always_comb begin
				wren = 1'b0;
				acc = 1'b0;
	 
			unique case(state)
				idle: ;

				active:begin
					wren = 1'b1;
					acc = 1'b1;
				end
				done:;
			endcase
		end
	
	always_comb
	begin
		case(address)
			16'd0: data = opCLR(x1);
			16'd1: data = opLD(x1, x0, inSW);
			16'd2: data = opST(x1, x0, outHEX);
			16'd3: data = opJAL(x2, -3);
			default: data = 32'h00000000;
		endcase
	end
		

endmodule 