`timescale 1ps/1ps
module control_logic (
	input [6:0]		op_i,
	input [2:0]		funct3_i,
	input			funct7_i, zero,

	output			PC_src, mem_wr, ALU_src, reg_wr,
	output [2:0]	ALU_ctrl,
	output [1:0]	imm_src, result_src
);

wire branch, not_branch, jump;
assign branch = (op_i == 7'b1100011 && funct3_i == 3'b000)? 1'b1:1'b0;
assign not_branch = (op_i == 7'b1100011 && funct3_i == 3'b001)? 1'b1:1'b0;
assign jump = (op_i == 7'b1101111 | op_i == 7'b1100111)? 1'b1:1'b0;
assign result_src = (op_i == 7'b1101111)? 2'b10: (op_i == 7'b0000011)? 2'b01: 2'b00;
assign mem_wr = (op_i == 7'b0100011)? 1'b1:1'b0;
assign ALU_src = (op_i == 7'b0000011 | op_i == 7'b0100011 | op_i == 7'b1101111 | op_i == 7'b1100111 | op_i == 7'b0010011)? 1'b1:1'b0;
assign reg_wr = (op_i == 7'b0000011 | op_i == 7'b0110011 | op_i == 7'b0010011 | op_i == 7'b1101111 | op_i == 7'b1100111)? 1'b1:1'b0;
assign imm_src = (op_i == 7'b0010011 | op_i == 7'b0000011 | op_i == 7'b1100111)? 2'b00: (op_i == 7'b0100011)? 2'b01: (op_i == 7'b1100011)? 2'b10:2'b11;
assign ALU_ctrl = (op_i == 7'b0000011 | op_i == 7'b0100011 | op_i == 7'b1100111 | op_i == 7'b1101111 | (op_i == 7'b0110011 && funct3_i == 3'b000 && funct7_i == 1'b0) |
 				  (op_i == 7'b0010011 && funct3_i == 3'b000))? 3'b011: //add
				  (op_i == 7'b1100011 | (op_i == 7'b0110011 && funct3_i == 3'b000 && funct7_i == 1'b1))? 3'b100: //sub
				  ((op_i == 7'b0110011 && funct3_i == 3'b110) | (op_i == 7'b0010011 && funct3_i == 3'b110))? 3'b010: //or
				  ((op_i == 7'b0110011 && funct3_i == 3'b111) | (op_i == 7'b0010011 && funct3_i == 3'b111))? 3'b001: 3'b000;//and
assign PC_src = (branch & zero) | jump | (not_branch & !zero);

specify
(op_i *> result_src) =  (50, 50);
(op_i *> mem_wr) =  (50, 50);
(op_i *> ALU_src) =  (50, 50);
(op_i *> reg_wr) =  (50, 50);
(op_i *> imm_src) =  (50, 50);
(op_i, funct3_i, funct7_i *> ALU_ctrl) =  (50, 50);
(op_i, funct3_i, zero *> PC_src) =  (10, 10);
endspecify

endmodule : control_logic

