`include "definitions.sv"

module alu_control(
    input        [2:0] alu_funct,
    input        [2:0] funct3,
    input        [6:0] funct7,
    output logic [3:0] alu_sel
);

    logic [3:0] default_funct;
    logic [3:0] secondary_funct;
    logic [3:0] branch_func;
    logic [3:0] reg_func;
    logic [3:0] imm_func;
    
    always_comb
    begin
        case (alu_funct)
            `CTL_ALU_ADD:           alu_sel = `ALU_ADD;
            `CTL_ALU_REG:           alu_sel = reg_func;
            `CTL_ALU_IMM:           alu_sel = imm_func;
            `CTL_ALU_BR:        alu_sel = branch_func;
            `CTL_ALU_LUI:           alu_sel = `ALU_PASS;
            default:                alu_sel = 4'bx;
        endcase
    end
    always_comb
    begin
        if (funct7[5])     
            reg_func = secondary_funct;
        else                    
            reg_func = default_funct;
        
        if (funct7[5] && funct3[1:0] == 2'b01)
            imm_func = secondary_funct;
        else    
            imm_func = default_funct;
    end
    always_comb
    begin
        case (funct3)
            `FUNCT3_ALU_ADD_SUB:    default_funct = `ALU_ADD;
            `FUNCT3_ALU_SLL:        default_funct = `ALU_SLL;
            `FUNCT3_ALU_SLT:        default_funct = `ALU_SLT;
            `FUNCT3_ALU_SLTU:       default_funct = `ALU_SLTU;
            `FUNCT3_ALU_XOR:        default_funct = `ALU_XOR;
            `FUNCT3_ALU_SHIFTR:     default_funct = `ALU_SRL;
            `FUNCT3_ALU_OR:         default_funct = `ALU_OR;
            `FUNCT3_ALU_AND:        default_funct = `ALU_AND;
            default:                default_funct = 4'bx;
        endcase

        case (funct3)
            `FUNCT3_ALU_ADD_SUB:    secondary_funct = `ALU_SUB;
            `FUNCT3_ALU_SHIFTR:     secondary_funct = `ALU_SRA;
            default:                secondary_funct = 4'bx;
        endcase

        case (funct3)
            `FUNCT3_BR_EQ:  branch_func = `ALU_SEQ;
            `FUNCT3_BR_NE:  branch_func = `ALU_SEQ;
            `FUNCT3_BR_LT:  branch_func = `ALU_SLT;
            `FUNCT3_BR_GE:  branch_func = `ALU_SLT;
            `FUNCT3_BR_LTU: branch_func = `ALU_SLTU;
            `FUNCT3_BR_GEU: branch_func = `ALU_SLTU;
            default:            branch_func = 4'bx;
        endcase
    end
endmodule