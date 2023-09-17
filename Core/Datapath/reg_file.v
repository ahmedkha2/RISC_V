`timescale 1ps/1ps
module reg_file (
	input 			clk,
	input 			w_en,
	input [4:0]		rs1_add, rs2_add, rd_add,
	input [31:0]	w_data,
	
	output [31:0]	rs1_data, rs2_data 
);

reg [31:0] reg_mem [0:31];

always @(posedge clk) begin
	#50
	if(w_en)
		reg_mem[rd_add] <= w_data;
end

assign rs1_data = (rs1_add == 0)? 32'b0 : reg_mem[rs1_add];
assign rs2_data = (rs2_add == 0)? 32'b0 : reg_mem[rs2_add];

specify
(rs1_add *> rs1_data) =  (50, 50);
(rs1_add *> rs2_data) =  (50, 50);
endspecify

endmodule : reg_file
