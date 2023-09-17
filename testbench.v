`timescale 1ns/1ps
module RISC_V_tb;
	reg 			clk, rst;

//internal signals
	wire [31:0]		instr;
	wire [31:0]		rd_data;
	wire [31:0]		PC;
	wire [31:0]		ALU_out, wr_data;
	wire 			mem_wr;

//variables
	integer period = 10;


/////////////////initial////////////////////
initial
begin
// Save Waveform
   $dumpfile("RISC_V_tb.vcd") ;
   $dumpvars;

//initial values
    initialize();

//reset
	reset();
end

always @(negedge clk)
begin
 	if(mem_wr) begin
 		if((ALU_out === 32'h60 & wr_data === 32'h2) | (ALU_out === 32'h5c & wr_data === 32'h4))
 			$display("memory write succeeded"); 
 	end 
 	else if (instr == 32'h00910133 & PC == 32'd64)
 		$display("jal succeeded");
 	else if (PC == 32'd72 & instr == 32'h00210063) begin
 		$display("simulation succeeded");
 		$stop;
 	end
end

/////////////////////////////TASKS/////////////////////

task initialize;
  begin
  	clk <= 1'b0;
  end
endtask

task reset;
  begin
    rst = 1'b1;
    #0.5
    rst = 1'b0;
    #0.5
    rst = 1'b1;
  end
endtask

///////////////////////Clock Generator////////////////
always #0.5 clk = !clk;

//instantiation////////////////////////////////////////
RISC_V			DUT (.clk(clk), .rst(rst), .instr(instr),
				.rd_data(rd_data), .PC(PC), .ALU_out(ALU_out),
				.wr_data(wr_data), .mem_wr(mem_wr));

inst_memory 	inst_mem(.address(PC[9:2]), .data_out(instr));

data_memory		data_mem(.clk(clk), .w_en(mem_wr), .address(ALU_out[7:0]),
				.wr_data(wr_data), .rd_data(rd_data));

endmodule


