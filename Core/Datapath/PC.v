`timescale 1ps/1ps
module PC (
	input 				clk, rst,
	input [31:0]		PC_next,
	output reg [31:0] 	PC
);

always @(posedge clk or negedge rst) begin : proc_
	#10
	if(~rst) begin
		 PC <= 32'b0;
	end else begin
		 PC <= PC_next;
	end
end

endmodule : PC
