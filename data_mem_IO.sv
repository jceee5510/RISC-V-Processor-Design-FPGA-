//`include "definitions.sv"
//
//module data_mem_IO (input clock,
//							input [31:0] addr,
//							input read_En,
//							input write_En,
//							input [31:0] write_data,
//							input [2:0] data_type, // byte, half, word
//							input [31:0] reg_read_data, //bus_read_data
//							output [31:0] mem_data,	//read_data
//							// to bus
//							// prob can replace in upperlevel
//							output bus_addr, 
//							output bus_W_En,
//							output bus_R_En,
//							output bus_write_data,
//							output logic [3:0] byte_sel);
//	
//	local [31:0] aligned;
//	
//	assign mem_data = sext;
//	assign bus_write_data = write_data << (8*addr[1:0]);
//
//	always_comb
//	begin
//		byte_sel = 4'b0000;
//		case (data_type[1:0])
//			// byte
//			2'b00: byte_sel = 4'b0001 << addr[1:0];
//			// half
//			2'b01: byte_sel = 4'b0011 << addr[1:0];
//			//word
//			2'b10: byte_sel = 4'b1111 << addr[1:0];
//			default: byte_sel = 4'b0000;
//		endcase
//	end
//	
//	always_comb
//	begin
//		aligned = reg_read_data >> (8*addr[1:0]);
//	end
//	
//	always_comb
//	begin
//		case (data_type[1:0])
//			2'b00: sext = {{24{~data_type[2] & aligned[7]}}, aligned[7:0]};
//			2'b01: sext = {{16{~data_type[2] & aligned[15]}}, aligned[15:0]};
//			2'b10: sext = aligned[31:0];
//			default: sext = 32'bx;
//		endcase
//	end
//			
//
//	
//endmodule
//							
//							