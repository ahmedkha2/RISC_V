`timescale 1ps/1ps
module extend (
	input [31:0]		imm_i,
	input [1:0]			imm_src,

	output [31:0]	imm_ext
);

assign imm_ext = (imm_src == 2'b00)? {{20{imm_i[31]}}, imm_i[31:20]} :
				 (imm_src == 2'b01)? {{20{imm_i[31]}}, imm_i[31:25], imm_i[11:7]} : 
				 (imm_src == 2'b10)? {{20{imm_i[31]}}, imm_i[7], imm_i[30:25], imm_i[11:8], 1'b0} : 
				 (imm_src == 2'b11)? {{12{imm_i[31]}}, imm_i[19:12], imm_i[20], imm_i[30:21], 1'b0} : 32'b0;
/*
always @(*) begin
	case(imm_src)
		00: imm_ext = {{20{imm_i[31]}}, imm_i[31:20]}; //I_type
		01: imm_ext = {{20{imm_i[31]}}, imm_i[31:25], imm_i[11:7]}; //S_type
		10: imm_ext = {{20{imm_i[31]}}, imm_i[7], imm_i[30:25], imm_i[11:8], 1'b0}; //B_type
		11: imm_ext = {{12{imm_i[31]}}, imm_i[19:12], imm_i[20], imm_i[30:21], 1'b0}; //J_type
	endcase
end
*/
specify
(imm_i *> imm_ext) =  (10, 10);
(imm_src *> imm_ext) =  (10, 10);
endspecify
endmodule : extend