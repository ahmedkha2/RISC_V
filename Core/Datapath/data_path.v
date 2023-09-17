module data_path (
	input 			clk, rst,
	input 			PC_src, mem_wr, ALU_src, reg_wr,
	input [2:0]		ALU_ctrl,
	input [1:0]		imm_src, result_src,
	input [31:0]	instr,
	input [31:0]	rd_data,

	output 			zero,
	output [31:0]	PC,
	output [31:0]	ALU_out, wr_data
);

wire [31:0]	PC_next, PC_4, PC_br;
wire [31:0] alu_a, alu_b;
wire [31:0]	reg_wr_data;
wire [31:0]	imm_ext;

//PC
PC 			pc_reg(.clk(clk), .rst(rst), .PC_next(PC_next), .PC(PC));
adder#(32)	pc_add4(.a_i(PC), .b_i(32'd4), .c_o(PC_4));
adder#(32)	pc_add_imm(.a_i(PC), .b_i(imm_ext), .c_o(PC_br));
MUX #(32)	mux_pc(.i0_i(PC_4), .i1_i(PC_br), .select(PC_src), .mux_out(PC_next));

//reg_file
reg_file	reg_f(.clk(clk), .w_en(reg_wr), .rs1_add(instr[19:15]),
	 		.rs2_add(instr[24:20]), .rd_add(instr[11:7]), .w_data(reg_wr_data),
	 		.rs1_data(alu_a), .rs2_data(wr_data));

//sign extenstion
extend		sign_ext(.imm_i(instr), .imm_src(imm_src), .imm_ext(imm_ext));

//ALU
ALU 		alu(.a_i(alu_a), .b_i(alu_b), .alu_ctrl(ALU_ctrl), .zero_o(zero), .alu_out(ALU_out));
MUX#(32)	mux_alu(.i0_i(wr_data), .i1_i(imm_ext), .select(ALU_src), .mux_out(alu_b));

//wr data mux
MUX3		mux_data(.sel(result_src), .a0(ALU_out), .a1(rd_data), .a2(PC_4), .out(reg_wr_data));

endmodule : data_path
