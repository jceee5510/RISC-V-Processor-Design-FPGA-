// definitions used in project

// ALU operations
`define ALU_ADD     4'b0001
`define ALU_SUB     4'b0010
`define ALU_SLL     4'b0011
`define ALU_SRL     4'b0100
`define ALU_SRA     4'b0101
`define ALU_SEQ      4'b0110
`define ALU_SLT      4'b0111
`define ALU_SLTU     4'b1000
`define ALU_XOR     4'b1001
`define ALU_OR      4'b1010
`define ALU_AND     4'b1011
`define ALU_PASS    4'b1100

// control ALU select
`define CTL_ALU_ADD 		3'b000
`define CTL_ALU_BR  		3'b001
`define CTL_ALU_REG  		3'b010
`define CTL_ALU_IMM  	3'b011
`define CTL_ALU_LUI         3'b100

// sources for ALU:
// mux A
`define CTL_RS1_SRC		1'b0
`define CTL_PC_SRC		1'b1
// mux B
`define CTL_RS2_SRC		1'b0
`define CTL_IMM_SRC		1'b1

// PC source
`define CTL_PC_PC4      1'b0
`define CTL_PC_ALU   	1'b1

// write back select
`define CTL_WB_PC4		2'b10
`define CTL_WB_ALU		2'b01
`define CTL_WB_DATA		2'b00

`define I_TYPE_OPCODE   7'b0010011
`define R_TYPE_OPCODE   7'b0110011
`define LUI_OPCODE      7'b0110111
`define AUI_OPCODE      7'b0010111
`define JAL_OPCODE      7'b1101111
`define JALR_OPCODE     7'b1100111
`define BRANCH_OPCODE   7'b1100011
`define LOAD_OPCODE     7'b0000011
`define STORE_OPCODE    7'b0100011

// Interpretations of the "funct3" field
`define FUNCT3_ALU_ADD_SUB  3'b000
`define FUNCT3_ALU_SLL      3'b001
`define FUNCT3_ALU_SLT      3'b010
`define FUNCT3_ALU_SLTU     3'b011
`define FUNCT3_ALU_XOR      3'b100
`define FUNCT3_ALU_SHIFTR   3'b101
`define FUNCT3_ALU_OR       3'b110
`define FUNCT3_ALU_AND      3'b111

// funct3 for BR
`define FUNCT3_BR_EQ    3'b000
`define FUNCT3_BR_NE    3'b001
`define FUNCT3_BR_LT    3'b100
`define FUNCT3_BR_GE    3'b101
`define FUNCT3_BR_LTU   3'b110
`define FUNCT3_BR_GEU   3'b111

//// ALU operations
//`define ALU_ADD     5'b00001
//`define ALU_SUB     5'b00010
//`define ALU_SLL     5'b00011
//`define ALU_SRL     5'b00100
//`define ALU_SRA     5'b00101
//`define ALU_SEQ     5'b00110
//`define ALU_SLT     5'b00111
//`define ALU_SLTU    5'b01000
//`define ALU_XOR     5'b01001
//`define ALU_OR      5'b01010
//`define ALU_AND     5'b01011
//`define ALU_MUL     5'b01100
//`define ALU_MULH    5'b01101
//`define ALU_MULHSU  5'b01110
//`define ALU_MULHU   5'b01111
//`define ALU_DIV     5'b10000
//`define ALU_DIVU    5'b10001
//`define ALU_REM     5'b10010
//`define ALU_REMU    5'b10011
//
//// control ALU select
//`define CTL_ALU_ADD 		2'b00
//`define CTL_ALU_BR  		2'b01
//`define CTL_ALU_REG_REG 2'b10
//`define CTL_ALU_REG_IMM	2'b11 
//
//// sources for ALU:
//// mux A
//`define CTL_RS1_SRC		1'b0
//`define CTL_PC_SRC		1'b1
//// mux B
//`define CTL_RS2_SRC		1'b0
//`define CTL_IMM_SRC		1'b1
//
//// PC source
//`define CTL_PC_PC4      2'b00
//`define CTL_PC_PC_IMM   2'b01
//`define CTL_PC_RS1_IMM  2'b10
//`define CTL_PC_PC4_BR   2'b11
//
//// write back select
//`define CTL_WB_PC4		2'b00
//`define CTL_WB_ALU		2'b01
//`define CTL_WB_DATA		2'b10
//`define CTL_WB_IMM		2'b11
//
//// opcode definitions
//`define I_TYPE_OPCODE   7'0010011
//`define R_TYPE_OPCODE   7'0110011
//`define LUI_OPCODE      7'0110111
//`define AUI_OPCODE      7'0010111
//`define JAL_OPCODE      7'1101111
//`define JALR_OPCODE     7'1100111
//`define BRANCH_OPCODE   7'1100011
//`define LOAD_OPCODE     7'0000011
//`define STORE_OPCODE    7'0100011
//
//// funct3 operation identities
//`define F3_ADD_SUB  3'b000
//`define F3_SLL      3'b001
//`define F3_SLT      3'b010
//`define F3_SLTU     3'b011
//`define F3_XOR      3'b100
//`define F3_SHIFTR   3'b101
//`define F3_OR       3'b110
//`define F3_AND      3'b111
//
//// funct3 opcode for BR
//`define F3_BR_EQ    3'b000
//`define F3_BR_NE    3'b001
//`define F3_BR_LT    3'b100
//`define F3_BR_GE    3'b101
//`define F3_BR_LTU   3'b110
//`define F3_BR_GEU   3'b111