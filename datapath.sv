// module datapath(input logic Clk, Reset,
// 						input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
// 						input logic GatePC, GateMDR, GateALU, GateMARMUX,
// 						input logic SR2MUX, ADDR1MUX, MARMUX,
// 						input logic MIO_EN, DRMUX, SR1MUX,
// 						input logic [1:0] PCMUX, ADDR2MUX, ALUK,
// 						input logic [31:0] MDR_In,
// 						output logic [31:0] MAR, MDR, IR, PC,
// 						output logic BEN,
// 						output logic [9:0] LED);
// 						//output logic [3:0] HEX0, HEX1, HEX2, HEX3);

module datapath(input logic Clk, Reset,
						input logic LD_MAR, LD_MDR, LD_IR, regW_en, LD_PC, LD_LED,
						input logic a_sel, b_sel, marmux_sel, pcmux_sel,
						input logic [1:0] writeback_sel,
						input logic [3:0] alu_sel,
						input logic [31:0] data_mem_R,
						output logic [6:0] opcode,
    					output logic [2:0] funct3,
    					output logic [6:0] funct7,
						output logic br_sig,
						output logic [31:0] MAR, MDR, IR, PC,
						output logic [31:0] data_mem_W, data_mem_addr,
						output logic [9:0] LED);
						//output logic [3:0] HEX0, HEX1, HEX2, HEX3);
	// logic [15:0] MDR_MUX, PC_MUX;
	// logic [15:0] BUS;
	// logic [15:0] MAR_OUT, MDR_OUT, IR_OUT, PC_OUT, ALU_OUT;
	
	// logic [2:0] SR1MUX_OUT, DRMUX_OUT;
	// logic [15:0] OUT1, OUT2, SR2MUX_OUT; 
	
	// logic [15:0] ADDR1MUX_OUT, ADDR2MUX_OUT;

	// ALU
	logic [31:0] ALU_OUT;

	// immediate
	logic [31:0] imm, inst;

	// regfile
	logic [31:0] dataA, dataB;

	logic [31:0] AMUXOUT, BMUXOUT, MARMUX_OUT, writeback;
	logic [31:0] PC_MUX, PC_OUT;
	
	
	logic [31:0] MAR_OUT, MDR_OUT;
	logic [4:0] rd, rs1, rs2;

    logic N,Z,P;
	 
	assign data_mem_W = dataB;
	assign data_mem_addr = ALU_OUT;

	immediate_generator IG(.inst(inst), .imm(imm));

   alu ALU(.alu_sel(alu_sel), .dataA(AMUXOUT), .dataB(BMUXOUT), .result(ALU_OUT), .br_sig(br_sig));

	mux_2x1	AMUX(.S(a_sel), .A(dataA), .B(PC_OUT), .Output(AMUXOUT));

	mux_2x1	BMUX(.S(b_sel), .A(dataB), .B(imm), .Output(BMUXOUT));

	mux_2x1	MARMUX(.S(marmux_sel), .A(PC_OUT), .B(ALU_OUT), .Output(MARMUX_OUT));

	mux_4x1 writeback_mux(.S(writeback_sel), .A(data_mem_R), .B(ALU_OUT), .C(PC_OUT + 32'h00000001), .D(1'b0), .Output(writeback));

    //REG FILE
   registerfile reg_file(.Clk(Clk), .Reset(Reset), .Load(regW_en), .D(writeback), .addrD(rd), 
									.addrA(rs1), .addrB(rs2), .dataA(dataA), .dataB(dataB));

   reg_32	MDRR(.Clk(Clk), .Reset(Reset), .Load(LD_MDR), .D(data_mem_R), .Data_Out(MDR_OUT));
	
	reg_32	IRR(.Clk(Clk), .Reset(Reset), .Load(LD_IR), .D(MDR_OUT), .Data_Out(inst));
	
	reg_32	MARR(.Clk(Clk), .Reset(Reset), .Load(LD_MAR), .D(MARMUX_OUT), .Data_Out(MAR_OUT));

   reg_32	PCR(.Clk(Clk), .Reset(Reset), .Load(LD_PC), .D(PC_MUX), .Data_Out(PC_OUT));    

	mux_2x1 PCMUX(.S(pcmux_sel), .A(PC_OUT + 32'h00000001), .B(ALU_OUT), .Output(PC_MUX));

	instruction_decoder inst_decoder(.inst(inst), .opcode(opcode), .funct7(funct7), .funct3(funct3),
        							.rd(rd), .rs1(rs1), .rs2(rs2));
									
	always_comb
	begin
		MAR = MAR_OUT;
		MDR = MDR_OUT;
		IR = inst;
		PC = PC_MUX;
		LED = inst[31:24];
	end
                        
endmodule