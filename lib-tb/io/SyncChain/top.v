`include "lib-tb/assert.v"
`include "lib/io/SyncChain.v"

module top();

parameter WIDTH = 3;
parameter DEPTH = 3;
parameter CLOCK_PERIOD = 1;

reg r_clk = 0;
reg r_reset = 0;

reg  [WIDTH - 1:0] rv_input;
wire [WIDTH - 1:0] wv_output;

SyncChain #(.p_WIDTH(WIDTH), .p_DEPTH(DEPTH)) uut(r_clk, r_reset, rv_input, wv_output);

// setup clock
always begin
	#CLOCK_PERIOD r_clk = ~r_clk;
end

initial begin
	$dumpfile("SyncChain.vcd");
	$dumpvars(0, top);
	
	rv_input <= 0;
	
	// Reset the chain.
	@(negedge r_clk);
	r_reset = ~r_reset;
	@(negedge r_clk);
	r_reset = ~r_reset;
	@(negedge r_clk);
	
	
	
	`assert_pass;
end

endmodule // top
