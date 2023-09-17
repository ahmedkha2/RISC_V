`timescale 1ps/1ps
module ALU (
	input [31:0]		a_i, b_i,
	input [2:0]			alu_ctrl,

	output				zero_o,
	output reg [31:0]	alu_out
);

always@(*) begin
	#50
	case(alu_ctrl)
		4'b000: alu_out = 33'b0; //no_op
		4'b001: alu_out = a_i & b_i; //AND
		4'b010: alu_out = a_i | b_i; //OR
		4'b011: alu_out = a_i + b_i; //add
		4'b100: alu_out = a_i - b_i; //sub
	endcase
end

assign zero_o = (alu_out == 32'b0)? 1'b1:1'b0;



endmodule : ALU