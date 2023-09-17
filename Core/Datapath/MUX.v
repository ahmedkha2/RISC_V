`timescale 1ps/1ps
module MUX #(parameter width = 8)(
	input [width-1:0] 		i0_i, i1_i,
	input 					select,
	output reg [width-1:0]	mux_out
);

always @(*) begin
	#10
	if (select)
		mux_out = i1_i;
	else
		mux_out = i0_i;
end

endmodule : MUX