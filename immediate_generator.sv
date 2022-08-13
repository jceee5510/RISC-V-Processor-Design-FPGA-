`include "definitions.sv"

module immediate_generator ( input [31:0] inst, ImmSel,
                                
								 output logic [31:0] imm);
										
				
	always_comb
	begin
		imm = 32'b0;
		case (inst[6:0])
			// I type
			`LOAD_OPCODE, `I_TYPE_OPCODE, `JALR_OPCODE :
				imm = { {21{inst[31]}}, inst[30:25], inst[24:20] };
			// S type
			`STORE_OPCODE: 
				imm = { {21{inst[31]}}, inst[30:25], inst[11:7] };
			// B type
         `BRANCH_OPCODE:
				imm = { {21{inst[31]}}, inst[7], inst[30:25], inst[11:8]};
			// U type
			`LUI_OPCODE, `AUI_OPCODE :
				imm = { {1{inst[31]}}, inst[30:20], inst[19:12], 12'b0 };
			// J type
			`JAL_OPCODE:
				imm = { {13{inst[31]}}, inst[19:12], inst[20], inst[30:25], inst[24:21]};
				
			default :
				imm = 32'b0;
		endcase
	end
endmodule

