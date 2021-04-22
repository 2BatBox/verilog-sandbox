`include "../assert.v"

module Seg7_tb();

parameter CLOCK_PERIOD = 1;
integer i;

reg r_clk = 0;
reg [3:0] rv_input = 0;
wire [6:0] wv_output_sync;
wire [6:0] wv_output_async;

// setup clock
always begin
	#CLOCK_PERIOD r_clk = ~r_clk;
end

Seg7Sync uut_sync(r_clk, rv_input, wv_output_sync);
Seg7Async uut_async(rv_input, wv_output_async);

initial begin

	for(i = 0; i < 'h0F; ++i) begin
		@(negedge r_clk);
		rv_input <= i;
		@(negedge r_clk);
		`assert_eq(wv_output_sync, wv_output_async);
	end

	`assert_pass;
end

initial begin
	$dumpfile("Seg7_tb.vcd");
	$dumpvars(0, Seg7_tb);
end

endmodule
