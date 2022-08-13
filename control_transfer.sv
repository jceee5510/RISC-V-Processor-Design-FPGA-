`include "definitions.sv"

module control_transfer (
    input        br_sig,
    input [2:0]  funct3,
    output logic br_en
);

    always_comb
	 begin
        case (funct3)
            `FUNCT3_BR_EQ:  br_en = br_sig;
            `FUNCT3_BR_NE:  br_en = !br_sig;
            `FUNCT3_BR_LT:  br_en = br_sig;
            `FUNCT3_BR_GE:  br_en = !br_sig;
            `FUNCT3_BR_LTU: br_en = br_sig;
            `FUNCT3_BR_GEU: br_en = !br_sig;
            default: br_en = 1'bx;
        endcase
	end

endmodule