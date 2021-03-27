`timescale 100 ns / 10 ns
`include "../assert.v"

module Debouncer_tb();

parameter CLOCK_PERIOD = 1;
parameter DELAY_PERIOD = CLOCK_PERIOD * 10;
parameter WAIT_PERIOD = DELAY_PERIOD * 4;

reg r_clk = 0;
reg r_input = 0;
reg r_watch_dog = 0;
wire w_output;

// setup clock
always begin
	#CLOCK_PERIOD r_clk = 1'b0;
	#CLOCK_PERIOD r_clk = 1'b1;
end

// setup watchdog
always @(w_output) begin
	if(r_watch_dog)
		`assert_fail;
end

Debouncer #(.PERIOD(DELAY_PERIOD)) uut(r_clk, r_input, w_output);

initial begin

//	repeat (10) begin
		#DELAY_PERIOD r_input = 1;
		#DELAY_PERIOD r_input = 0;
	//end
	
	#WAIT_PERIOD;	

	#WAIT_PERIOD;
	`assert_pass;
end

initial begin
	$dumpfile("Debouncer_tb.vcd");
	$dumpvars(0, Debouncer_tb);
end

endmodule
