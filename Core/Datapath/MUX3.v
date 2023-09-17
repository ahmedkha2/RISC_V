`timescale 1ps/1ps
module MUX3 #(parameter width = 32)(
  input [1:0]				sel,
  input [width-1:0]	 		a0, a1, a2,
  output reg [width-1:0] 	out
);

always @(*)
begin
  #10
  case(sel)
    2'b00: out = a0;
    2'b01: out = a1;
    2'b10: out = a2;
    default: out = 1'b0;
  endcase
end

endmodule