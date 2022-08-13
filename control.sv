`include "definitions.sv"

module control (input logic Clk, 
									 Reset,
									 Run,
									 Continue,	
					 input logic [6:0]    Opcode, // 7-bit opcode
					 // branch
					 input logic br_en,
					 // fetch
					 output logic LD_IR,
					 output logic LD_MDR,
					 output logic LD_MAR, 
					 output logic marmux_sel,
					 // ALU
					 output logic [2:0] alu_funct, // select which alu operation
					 output logic a_sel,
					 output logic b_sel,
					 // register file signals
					 output logic regW_en,
					 output logic [1:0] writeback_sel,
					 // data memory
					 output logic memW_En,
					 output logic memR_En,
					 // PC
					 output logic pcmux_sel,
					 output logic LD_PC
					 
				);

	enum logic [4:0] {Halted,
							Fetch_1,
							Fetch_2,
							Fetch_3,
							Decode,
							IMM,
							REG,
							LUI,
							BR,
							AUIPC,
							JAL,
							JALR,
							LD_ADDR,
							LD_1,
							LD_2,
							ST_ADDR,
							ST}   State, Next_state;   // Internal state logic
		
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			State <= Halted;
		else 
			State <= Next_state;
	end
	
	
	always_comb
	begin
		case (Opcode)
			`BRANCH_OPCODE: pcmux_sel = br_en ? `CTL_PC_ALU : `CTL_PC_PC4;
			`JAL_OPCODE: 	 pcmux_sel = `CTL_PC_ALU;
			`JALR_OPCODE: 	 pcmux_sel = `CTL_PC_ALU;
			default: 		 pcmux_sel = `CTL_PC_PC4;
		endcase
	end
		
	always_comb
	begin 
		// Default next state is staying at current state
		Next_state = State;
		// Default controls signal values
		alu_funct = 3'bx; 
		a_sel = 1'bx;
		b_sel = 1'bx;
		regW_en = 1'b0;
		writeback_sel= 2'bx;
		memW_En = 1'b0;
		memR_En = 1'b0;
		marmux_sel = 1'bx;
		LD_MAR = 1'b0;
		LD_MDR = 1'b0;
		LD_IR = 1'b0;
		LD_PC = 1'b0;
	
		// Assign next state
		unique case (State)
			Halted : 
				if (Run) 
					Next_state = Fetch_1;                      
			Fetch_1 :
				Next_state = Fetch_2;
			Fetch_2 : 
				Next_state = Fetch_3;
			Fetch_3 :
				Next_state = Decode;
			// PauseIR1 and PauseIR2 are only for Week 1 such that TAs can see 
			// the values in IR.
//			PauseIR1 : 
//				if (~Continue) 
//					Next_state = PauseIR1;
//				else 
//					Next_state = PauseIR2;
//			PauseIR2 : 
//				if (Continue) 
//					Next_state = PauseIR2;
//				else 
//					Next_state = S_18;
			Decode : 
				case (Opcode)
					`I_TYPE_OPCODE : 
						Next_state = IMM;
					`R_TYPE_OPCODE :
                        Next_state = REG;
					`LUI_OPCODE :
						Next_state = LUI;
					`BRANCH_OPCODE :
						Next_state = BR;
					`AUI_OPCODE :
						Next_state = AUIPC;
					`JAL_OPCODE :
						Next_state = JAL;
					`JALR_OPCODE :
						Next_state = JALR;
					default : 
						Next_state = Fetch_1;
				endcase
			IMM :
				Next_state = Fetch_1;
			REG : 
				Next_state = Fetch_1;
			LUI :
				Next_state = Fetch_1;
			BR :
				Next_state = Fetch_1;
			AUIPC :
				Next_state = Fetch_1;
			JAL : 
				Next_state = Fetch_1;
			JALR :
				Next_state = Fetch_1;
			LD_ADDR :
				Next_state = LD_1;
			LD_1 :
				Next_state = LD_2;
			LD_2 :
				Next_state = Fetch_1;
			ST_ADDR :
				Next_state = ST;
			ST :
				Next_state = Fetch_1;
			default : ;

		endcase
		
		// Assign control signals based on current state
		case (State)
			Halted: ;
			Fetch_1 : 
				begin 
					marmux_sel = 1'b0;
					LD_MAR = 1'b1;
				end
			Fetch_2 : 
				begin 
					memR_En = 1'b1;
					LD_MDR = 1'b1;
				end
			Fetch_3 : 
				begin 
					LD_IR = 1'b1;
				end
//			PauseIR1: 
//				LD_LED = 1'b1;
//			PauseIR2: ;
			Decode : ;
				
			IMM : 
				begin
					alu_funct = `CTL_ALU_IMM;
					a_sel = `CTL_RS1_SRC;
					b_sel = `CTL_IMM_SRC;
					regW_en = 1'b1;
					writeback_sel = `CTL_WB_ALU;
					LD_PC = 1'b1;
				end
			REG :
				begin
					alu_funct = `CTL_ALU_REG;
					a_sel = `CTL_RS1_SRC;
					b_sel = `CTL_RS2_SRC;
					writeback_sel = `CTL_WB_ALU;
					regW_en = 1'b1;
                    LD_PC = 1'b1;
				end
			LUI :
				begin
                    alu_funct = `CTL_ALU_LUI;
					a_sel = `CTL_RS1_SRC;
					b_sel = `CTL_IMM_SRC;
					regW_en = 1'b1;
					writeback_sel = `CTL_WB_ALU;
                    LD_PC = 1'b1;
				end
			AUIPC :
				begin
               alu_funct = `CTL_ALU_ADD;
					a_sel = `CTL_PC_SRC;
					b_sel = `CTL_IMM_SRC;
					regW_en = 1'b1;
					writeback_sel = `CTL_WB_ALU;
               LD_PC = 1'b1;
				end
			BR :
				begin
					alu_funct = `CTL_ALU_BR;
					a_sel = `CTL_PC_SRC;
					b_sel = `CTL_IMM_SRC;
               LD_PC = 1'b1;
				end
			JAL :
				begin
					regW_en = 1'b1;
					writeback_sel = `CTL_WB_PC4;
					a_sel = `CTL_PC_SRC;
					b_sel = `CTL_IMM_SRC;
					alu_funct = `CTL_ALU_ADD;
               LD_PC = 1'b1;
				end
			JALR :
				begin
					regW_en = 1'b1;
					writeback_sel = `CTL_WB_PC4;
					a_sel = `CTL_RS1_SRC;
					b_sel = `CTL_IMM_SRC;
					alu_funct = `CTL_ALU_ADD;
               LD_PC = 1'b1;
				end
			LD_ADDR :
				begin
					marmux_sel = 1'b1;
					LD_MAR = 1'b1;
					a_sel = `CTL_RS1_SRC;
					b_sel = `CTL_IMM_SRC;
					alu_funct = `CTL_ALU_ADD;
				end
			LD_1 :
				begin 
					memR_En = 1'b1;
					LD_MDR = 1'b1;
				end
			LD_2 :
				begin
					regW_en = 1'b1;
					writeback_sel = `CTL_WB_DATA;
               LD_PC = 1'b1;
				end
			ST_ADDR :
				begin
					marmux_sel = 1'b1;
					LD_MAR = 1'b1;
				end
			ST :
				begin
					a_sel = `CTL_RS1_SRC;
					b_sel = `CTL_IMM_SRC;
					alu_funct = `CTL_ALU_ADD;
					memW_En = 1'b1;
               LD_PC = 1'b1;
				end
			default : 
				begin 
					LD_PC = 1'bx;
					regW_en = 1'bx;
					memW_En = 1'bx;
					memR_En = 1'bx;
				end
		endcase
	end 

	
endmodule
