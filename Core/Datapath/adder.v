`timescale 1ps/1ps
module adder #(parameter width = 32)(
	input [width-1:0]	a_i, b_i,
	output [width-1:0]	c_o
);

assign c_o = a_i + b_i;

specify
(a_i *> c_o) =  (10, 10);
(b_i *> c_o) =  (10, 10);
endspecify

endmodule : adder
