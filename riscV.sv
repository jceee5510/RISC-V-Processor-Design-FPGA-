//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Lab 5 Given Code - SLC-3 top-level (Physical RAM)
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//------------------------------------------------------------------------------


module riscV(
	input logic [9:0] SW,
	input logic	Clk, Reset, Run, Continue,
	output logic [9:0] LED,
	input logic [31:0] Data_from_SRAM,
	output logic OE, WE,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
	output logic [31:0] ADDR,
	output logic [31:0] Data_to_SRAM
);


// An array of 4-bit wires to connect the hex_drivers efficiently to wherever we want
// For Lab 1, they will direclty be connected to the IR register through an always_comb circuit
// For Lab 2, they will be patched into the MEM2IO module so that Memory-mapped IO can take place
logic [5:0][3:0] hex_6; 
//HexDriver hex_drivers[3:0] (hex_6, {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0});
// This works thanks to http://stackoverflow.com/questions/1378159/verilog-can-we-have-an-array-of-custom-modules



// Internal connections
logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED;
logic GatePC, GateMDR, GateALU, GateMARMUX;
logic SR2MUX, ADDR1MUX, MARMUX;
logic BEN, MIO_EN, DRMUX, SR1MUX;

logic a_sel, b_sel, marmux_sel, pcmux_sel, regW_en;
logic [2:0] alu_funct;
logic [1:0] writeback_sel;
logic [3:0] alu_sel;
logic [31:0] MAR, MDR, IR, PC;
logic br_en, br_sig;
logic [6:0] opcode;
logic [2:0] funct3;
logic [6:0] funct7;
logic [31:0] data_mem_W, data_mem_addr, data_mem_R;

HexDriver hex0 (.In0(hex_6[0][3:0]), .Out0(HEX0));
HexDriver hex1 (.In0(hex_6[1][3:0]), .Out0(HEX1));
HexDriver hex2 (.In0(hex_6[2][3:0]), .Out0(HEX2));
HexDriver hex3 (.In0(hex_6[3][3:0]), .Out0(HEX3));
HexDriver hex4 (.In0(hex_6[4][3:0]), .Out0(HEX4));
HexDriver hex5 (.In0(hex_6[5][3:0]), .Out0(HEX5));

// Connect MAR to ADDR, which is also connected as an input into MEM2IO
//	MEM2IO will determine what gets put onto Data_CPU (which serves as a potential
//	input into MDR)
assign ADDR = MAR; 
assign MIO_EN = OE;

// Connect everything to the data path (you have to figure out this part)
datapath d0 (.*/*, .MAR_OUT(MAR), .MDR_OUT(MDR), .IR_OUT(IR), .PC_OUT(PC), .HEX0(hex_4[0]), .HEX1(hex_4[1]), .HEX2(hex_4[2]), .HEX3(hex_4[3])*/);

// Our SRAM and I/O controller (note, this plugs into MDR/MAR)

mem2IO memory_subsystem(
    .*, .Reset(Reset), .addr(ADDR), .SW(SW),
    .HEX0(hex_6[0][3:0]), .HEX1(hex_6[1][3:0]), .HEX2(hex_6[2][3:0]), .HEX3(hex_6[3][3:0]),
	 .HEX4(hex_6[4][3:0]), .HEX5(hex_6[5][3:0]),
    .Data_from_CPU(MDR), .Data_to_CPU(data_mem_R),
    .Data_from_SRAM(Data_from_SRAM), .Data_to_SRAM(Data_to_SRAM)
);

// State machine, you need to fill in the code here as well
control state_controller(
	.Clk(Clk), .Reset(Reset), .Run(Run), .Continue(Continue), .Opcode(opcode), .br_en(br_en), .LD_IR(LD_IR), 
	.LD_MDR(LD_MDR), .LD_MAR(LD_MAR), .marmux_sel(marmux_sel), .alu_funct(alu_funct), .a_sel(a_sel), .b_sel(b_sel),
	.regW_en(LD_REG), .writeback_sel(writeback_sel), .memW_En(WE), .memR_En(OE), .pcmux_sel(pcmux_sel), 
	.LD_PC(LD_PC)
);

alu_control alu_control(
        .alu_funct     (alu_funct),
        .funct3        (funct3),
        .funct7        (funct7),
        .alu_sel       (alu_sel)
    );

control_transfer control_trans(
	.br_sig(br_sig), .funct3(funct3), .br_en(br_en)
);

// SRAM WE register
//logic SRAM_WE_In, SRAM_WE;
//// SRAM WE synchronizer
//always_ff @(posedge Clk or posedge Reset_ah)
//begin
//	if (Reset_ah) SRAM_WE <= 1'b1; //resets to 1
//	else 
//		SRAM_WE <= SRAM_WE_In;
//end

	
endmodule
