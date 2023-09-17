`timescale 1ps/1ps
module data_memory (
	input 			clk, w_en,
	input [7:0]		address,
	input [31:0]	wr_data,

	output [31:0]	rd_data
);

reg [31:0] ram [0:255];

initial begin
	$readmemh("D:/-/ITI/RISC V/memfiledat.hex", ram);
end

always @(posedge clk) begin
	if (w_en)
		ram[address] <= wr_data;
end

assign rd_data = ram[address];

specify
(address *> rd_data) =  (100, 100);
endspecify

endmodule : data_memory