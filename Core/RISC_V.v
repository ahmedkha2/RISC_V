module RISC_V (
	input 			clk, rst,
	input [31:0]	instr,
	input [31:0]	rd_data,

	output [31:0]	PC,
	output [31:0]	ALU_out, wr_data,
	output 			mem_wr
);

wire 		zero, ALU_src, reg_wr, PC_src;
wire [1:0]	imm_src, result_src;
wire [2:0]	ALU_ctrl;

control_logic	controller(.op_i(instr[6:0]), .funct3_i(instr[14:12]), .funct7_i(instr[30]),
				.zero(zero), .PC_src(PC_src), .mem_wr(mem_wr), .ALU_src(ALU_src), .reg_wr(reg_wr),
				.ALU_ctrl(ALU_ctrl), .imm_src(imm_src), .result_src(result_src));

data_path		data(.clk(clk), .rst(rst), .PC_src(PC_src), .mem_wr(mem_wr), .ALU_src(ALU_src),
				.reg_wr(reg_wr), .ALU_ctrl(ALU_ctrl), .imm_src(imm_src), .result_src(result_src),
				.instr(instr), .rd_data(rd_data), .zero(zero), .PC(PC), .ALU_out(ALU_out), .wr_data(wr_data));

endmodule : RISC_V
