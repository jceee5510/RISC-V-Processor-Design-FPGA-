`include "definitions.sv"

module alu (
    input        [3:0]  alu_sel,
    input signed [31:0] dataA,
    input signed [31:0] dataB,
    output logic [31:0] result,
	 output br_sig
);

	assign br_sig = ~(result == 32'b0);

     always_comb begin
        case (alu_sel)
            `ALU_ADD: result = dataA + dataB;
            `ALU_SUB: result = dataA - dataB;
            `ALU_SLL: result = dataA <<   dataB[4:0];
            `ALU_SRL: result = dataA >>   dataB[4:0];
            `ALU_SRA: result = dataA >>>  dataB[4:0];
            `ALU_SEQ: result = {31'b0, dataA == dataB};
            `ALU_SLT: result = {31'b0, dataA < dataB};      
            `ALU_SLTU: result = {31'b0, $unsigned(dataA) < $unsigned(dataB)};
            `ALU_XOR: result = dataA ^ dataB;
            `ALU_OR:  result = dataA | dataB;
            `ALU_AND: result = dataA & dataB;
            `ALU_PASS: result = dataB;
            default: result = 32'b0;
        endcase
     end
endmodule