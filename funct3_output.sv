`include "definitions.sv"


module branch_function_output (  input br_result_from_alu,
											input [2:0] funct3,
											output yes_branch);
		// takes result from ALU and if depending on A and B operand comparison result
		// either takes branch or not
		always_comb
		begin
			case(funct3) :
				`F3_BR_EQ: yes_branch = !br_result_from_alu;
				`F3_BR_NE: yes_branch = br_result_from_alu;
				`F3_BR_LT: yes_branch = !br_result_from_alu;
				`F3_BR_GE: yes_branch = br_result_from_alu;
				`F3_BR_LTU: yes_branch = !br_result_from_alu;
				`F3_BR_GEU: yes_branch = br_result_from_alu;
				default: 1'bx;
			endcase
		end
endmodule
				
