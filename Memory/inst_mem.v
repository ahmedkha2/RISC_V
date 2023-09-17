`timescale 1ps/1ps
module inst_memory (
	input [7:0]		address,

	output [31:0]	data_out
);

reg [31:0] rom [0:255];

initial begin
	$readmemh("D:/-/ITI/RISC V/memfile.hex", rom);
end

assign data_out = rom[address];

specify
(address *> data_out) =  (100, 100);
endspecify

endmodule : inst_memory
