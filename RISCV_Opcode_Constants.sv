
`ifndef _RISCV_Opcode_Constants__SV
`define _RISCV_Opcode_Constants__SV


package RISCV_Opcode_Constants;

	parameter outHEX = -1;
	parameter inSW = -1;
	
	// opcode 
	parameter I_TYPE_OPCODE = 7'b0010011;
	parameter R_TYPE_OPCODE  =7'b0110011;
	parameter LUI_OPCODE     =7'b0110111;
	parameter AUI_OPCODE    = 7'b0010111;
	parameter JAL_OPCODE    = 7'b1101111;
	parameter JALR_OPCODE   = 7'b1100111;
	parameter BRANCH_OPCODE = 7'b1100011;
	parameter LOAD_OPCODE   = 7'b0000011;
	parameter STORE_OPCODE  = 7'b0100011;
	
	parameter F3_ADD_SUB = 3'b000;
	parameter F3_SLL     = 3'b001;
	parameter F3_SLT     = 3'b010;
	parameter F3_SLTU    = 3'b011;
	parameter F3_XOR     = 3'b100;
	parameter F3_SHIFTR  = 3'b101;
	parameter F3_OR      = 3'b110;
	parameter F3_AND     = 3'b111;
	
	parameter F3_BR_EQ  = 3'b000;
	parameter F3_BR_NE  = 3'b001;
	parameter F3_BR_LT  = 3'b100;
	parameter F3_BR_GE  = 3'b101;
	parameter F3_BR_LTU = 3'b110;
	parameter F3_BR_GEU = 3'b111;
	
	parameter x0 = 5'b00000;      // register aliases
   parameter x1 = 5'b00001;
   parameter x2 = 5'b00010;
   parameter x3 = 5'b00011;
   parameter x4 = 5'b00100;
   parameter x5 = 5'b00101;
   parameter x6 = 5'b00110;
   parameter x7 = 5'b00111;
	parameter x8 = 5'b01000;      // register aliases
   parameter x9 = 5'b01001;
   parameter x10 = 5'b01010;
   parameter x11 = 5'b01011;
   parameter x12 = 5'b01100;
   parameter x13 = 5'b01101;
   parameter x14 = 5'b01110;
   parameter x15 = 5'b01111;
	parameter x16 = 5'b10000;      // register aliases
   parameter x17 = 5'b10001;
   parameter x18 = 5'b10010;
   parameter x19 = 5'b10011;
   parameter x20 = 5'b10100;
   parameter x21 = 5'b10101;
   parameter x22 = 5'b10110;
   parameter x23 = 5'b10111;
	parameter x24 = 5'b11000;      // register aliases
   parameter x25 = 5'b11001;
   parameter x26 = 5'b11010;
   parameter x27 = 5'b11011;
   parameter x28 = 5'b11100;
   parameter x29 = 5'b11101;
   parameter x30 = 5'b11110;
   parameter x31 = 5'b11111;
	
	
	//opCLR
	function [31:0] opCLR ( input [4:0] RD);
		opCLR[31:20] = 12'h000;
		opCLR[19:15] = RD;
		opCLR[14:12] = F3_AND;
		opCLR[11:7] = RD;
		opCLR[6:0] = I_TYPE_OPCODE;
	endfunction
	//IMM TYPE
	//opADDI
	function [31:0] opADDI ( input [4:0] RS1, RD, integer imm12);
		opADDI[31:20] = imm12[11:0];
		opADDI[19:15] = RS1;
		opADDI[14:12] = F3_ADD_SUB;
		opADDI[11:7] = RD;
		opADDI[6:0] = I_TYPE_OPCODE;
	endfunction
	
	//opSLTI
	function [31:0] opSLTI ( input [4:0] RS1, RD, integer imm12);
		opSLTI[31:20] = imm12[11:0];
		opSLTI[19:15] = RS1;
		opSLTI[14:12] = F3_SLT;
		opSLTI[11:7] = RD;
		opSLTI[6:0] = I_TYPE_OPCODE;
	endfunction
	
	//opANDI
	function [31:0] opANDI ( input [4:0] RS1, RD, integer imm12);
		opANDI[31:20] = imm12[11:0];
		opANDI[19:15] = RS1;
		opANDI[14:12] = F3_AND;
		opANDI[11:7] = RD;
		opANDI[6:0] = I_TYPE_OPCODE;
	endfunction
	
	//opORI
	function [31:0] opORI ( input [4:0] RS1, RD, integer imm12);
		opORI[31:20] = imm12[11:0];
		opORI[19:15] = RS1;
		opORI[14:12] = F3_OR;
		opORI[11:7] = RD;
		opORI[6:0] = I_TYPE_OPCODE;
	endfunction
	
	//opXORI
	function [31:0] opXORI ( input [4:0] RS1, RD, integer imm12);
		opXORI[31:20] = imm12[11:0];
		opXORI[19:15] = RS1;
		opXORI[14:12] = F3_XOR;
		opXORI[11:7] = RD;
		opXORI[6:0] = I_TYPE_OPCODE;
	endfunction
	
	//opSLLI
	function [31:0] opSLLI ( input [4:0] shftamt, RS1, RD);
		opSLLI[31:25] = 7'b0;
		opSLLI[24:20] = shftamt;
		opSLLI[19:15] = RS1;
		opSLLI[14:12] = F3_AND;
		opSLLI[11:7] = RD;
		opSLLI[6:0] = I_TYPE_OPCODE;
	endfunction
	
	//opSRLI
	function [31:0] opSRLI ( input [4:0] shftamt, RS1, RD);
		opSRLI[31:25] = 7'b0;
		opSRLI[24:20] = shftamt;
		opSRLI[19:15] = RS1;
		opSRLI[14:12] = F3_SHIFTR;
		opSRLI[11:7] = RD;
		opSRLI[6:0] = I_TYPE_OPCODE;
	endfunction
	
	//opSRAI
	function [31:0] opSRAI ( input [4:0] shftamt, RS1, RD);
		opSRAI[31:25] = 7'b0100000;
		opSRAI[24:20] = shftamt[4:0];
		opSRAI[19:15] = RS1;
		opSRAI[14:12] = F3_SHIFTR;
		opSRAI[11:7] = RD;
		opSRAI[6:0] = I_TYPE_OPCODE;
	endfunction
	// U TYPE
	//opLUI
	function [31:0] opLUI ( input integer immU, RD);
		opLUI[31:12] = immU[19:0];
		opLUI[11:7] = RD;
		opLUI[6:0] = LUI_OPCODE;
	endfunction
	
	//opAUI
	function [31:0] opAUI ( input [4:0] RD, integer immU);
		opAUI[31:12] = immU[19:0];
		opAUI[11:7] = RD;
		opAUI[6:0] = AUI_OPCODE;
	endfunction
	// REG TYPE
	//opADD
	function [31:0] opADD ( input [4:0] RS2, RS1, RD);
		opADD[31:25] = 7'b0;
		opADD[24:20] = RS2;
		opADD[19:15] = RS1;
		opADD[14:12] = F3_ADD_SUB;
		opADD[11:7] = RD;
		opADD[6:0] = R_TYPE_OPCODE;
	endfunction
	
	//opSLT
	function [31:0] opSLT ( input [4:0] RS2, RS1, RD);
		opSLT[31:25] = 7'b0;
		opSLT[24:20] = RS2;
		opSLT[19:15] = RS1;
		opSLT[14:12] = F3_SLT;
		opSLT[11:7] = RD;
		opSLT[6:0] = R_TYPE_OPCODE;
	endfunction
	
	//opSLTU
	function [31:0] opSLTU ( input [4:0] RS2, RS1, RD);
		opSLTU[31:25] = 7'b0;
		opSLTU[24:20] = RS2;
		opSLTU[19:15] = RS1;
		opSLTU[14:12] = F3_SLTU;
		opSLTU[11:7] = RD;
		opSLTU[6:0] = R_TYPE_OPCODE;
	endfunction
	
	//opAND
	function [31:0] opAND ( input [4:0] RS2, RS1, RD);
		opAND[31:25] = 7'b0;
		opAND[24:20] = RS2;
		opAND[19:15] = RS1;
		opAND[14:12] = F3_AND;
		opAND[11:7] = RD;
		opAND[6:0] = R_TYPE_OPCODE;
	endfunction
	
	//opOR
	function [31:0] opOR ( input [4:0] RS2, RS1, RD);
		opOR[31:25] = 7'b0;
		opOR[24:20] = RS2;
		opOR[19:15] = RS1;
		opOR[14:12] = F3_OR;
		opOR[11:7] = RD;
		opOR[6:0] = R_TYPE_OPCODE;
	endfunction
	
	//opXOR
	function [31:0] opXOR ( input [4:0] RS2, RS1, RD);
		opXOR[31:25] = 7'b0;
		opXOR[24:20] = RS2;
		opXOR[19:15] = RS1;
		opXOR[14:12] = F3_XOR;
		opXOR[11:7] = RD;
		opXOR[6:0] = R_TYPE_OPCODE;
	endfunction
	
	//opSLL
	function [31:0] opSLL ( input [4:0] RS2, RS1, RD);
		opSLL[31:25] = 7'b0;
		opSLL[24:20] = RS2;
		opSLL[19:15] = RS1;
		opSLL[14:12] = F3_SLL;
		opSLL[11:7] = RD;
		opSLL[6:0] = R_TYPE_OPCODE;
	endfunction
	
	//opSRL
	function [31:0] opSRL ( input [4:0] RS2, RS1, RD);
		opSRL[31:25] = 7'b0;
		opSRL[24:20] = RS2;
		opSRL[19:15] = RS1;
		opSRL[14:12] = F3_SHIFTR;
		opSRL[11:7] = RD;
		opSRL[6:0] = R_TYPE_OPCODE;
	endfunction
	
	//opSUB
	function [31:0] opSUB ( input [4:0] RS2, RS1, RD);
		opSUB[31:25] = 7'b0100000;
		opSUB[24:20] = RS2;
		opSUB[19:15] = RS1;
		opSUB[14:12] = F3_SHIFTR;
		opSUB[11:7] = RD;
		opSUB[6:0] = R_TYPE_OPCODE;
	endfunction
	
	//opSRA
	function [31:0] opSRA ( input [4:0] RS2, RS1, RD);
		opSRA[31:25] = 7'b0100000;
		opSRA[24:20] = RS2;
		opSRA[19:15] = RS1;
		opSRA[14:12] = F3_SHIFTR;
		opSRA[11:7] = RD;
		opSRA[6:0] = R_TYPE_OPCODE;
	endfunction
	
	//opJAL
	function [31:0] opJAL (input [4:0] RD, integer offset20);
		opJAL[31:12] = offset20[19:0];
		opJAL[11:7] = RD;
		opJAL[6:0] = JAL_OPCODE;
	endfunction
	
	//opJALR
	function [31:0] opJALR (input [4:0] RS1, RD, input [11:0] offset12);
		opJALR[31:20] = offset12;
		opJALR[19:15] = RS1;
		opJALR[14:12] = 3'b0;
		opJALR[11:7] = RD;
		opJALR[6:0] = JALR_OPCODE;
	endfunction
	
	//opBEQ
	function [31:0] opBEQ (input [4:0] RS1, RS2, input [11:0] offset12);
		opBEQ[31] = offset12[11];
		opBEQ[30:25] = offset12[9:4];
		opBEQ[24:20] = RS2;
		opBEQ[19:15] = RS1;
		opBEQ[14:12] = F3_BR_EQ;
		opBEQ[11:8] = offset12[3:0];
		opBEQ[7] = offset12[10];
		opBEQ[6:0] = BRANCH_OPCODE;
	endfunction
	
	//opBNE
	function [31:0] opBNE (input [4:0] RS1, RS2, input [11:0] offset12);
		opBNE[31] = offset12[11];
		opBNE[30:25] = offset12[9:4];
		opBNE[24:20] = RS2;
		opBNE[19:15] = RS1;
		opBNE[14:12] = F3_BR_NE;
		opBNE[11:8] = offset12[3:0];
		opBNE[7] = offset12[10];
		opBNE[6:0] = BRANCH_OPCODE;
	endfunction
	
	//opBLT
	function [31:0] opBLT (input [4:0] RS1, RS2, input [11:0] offset12);
		opBLT[31] = offset12[11];
		opBLT[30:25] = offset12[9:4];
		opBLT[24:20] = RS2;
		opBLT[19:15] = RS1;
		opBLT[14:12] = F3_BR_LT;
		opBLT[11:8] = offset12[3:0];
		opBLT[7] = offset12[10];
		opBLT[6:0] = BRANCH_OPCODE;
	endfunction
	
	//opBLTU
	function [31:0] opBLTU (input [4:0] RS1, RS2, input [11:0] offset12);
		opBLTU[31] = offset12[11];
		opBLTU[30:25] = offset12[9:4];
		opBLTU[24:20] = RS2;
		opBLTU[19:15] = RS1;
		opBLTU[14:12] = F3_BR_LTU;
		opBLTU[11:8] = offset12[3:0];
		opBLTU[7] = offset12[10];
		opBLTU[6:0] = BRANCH_OPCODE;
	endfunction
	
	//opBGE
	function [31:0] opBGE (input [4:0] RS1, RS2, input [11:0] offset12);
		opBGE[31] = offset12[11];
		opBGE[30:25] = offset12[9:4];
		opBGE[24:20] = RS2;
		opBGE[19:15] = RS1;
		opBGE[14:12] = F3_BR_GE;
		opBGE[11:8] = offset12[3:0];
		opBGE[7] = offset12[10];
		opBGE[6:0] = BRANCH_OPCODE;
	endfunction
	
	//opBGEU
	function [31:0] opBGEU (input [4:0] RS1, RS2, input [11:0] offset12);
		opBGEU[31] = offset12[11];
		opBGEU[30:25] = offset12[9:4];
		opBGEU[24:20] = RS2;
		opBGEU[19:15] = RS1;
		opBGEU[14:12] = F3_BR_GEU;
		opBGEU[11:8] = offset12[3:0];
		opBGEU[7] = offset12[10];
		opBGEU[6:0] = BRANCH_OPCODE;
	endfunction
	
	//opLD
	function [31:0] opLD (input [4:0] RD, RS1, input [11:0] offset12);
		opLD[31:20] = offset12;
		opLD[19:15] = RS1;
		opLD[14:12] = 3'b0;
		opLD[11:7] = RD;
		opLD[6:0] = LOAD_OPCODE;
	endfunction
	
	//opST
	function [31:0] opST (input [4:0] RS1, RS2, input [11:0] offset12);
		opST[31:25] = offset12[11:5];
		opST[24:20] = RS2;
		opST[19:15] = RS1;
		opST[14:12] = 3'b0;
		opST[11:7] = offset12[4:0];
		opST[6:0] = STORE_OPCODE;
	endfunction
	
endpackage

`endif
	
	
	
	
	
	