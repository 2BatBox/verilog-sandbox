`timescale 100 ns / 10 ns
`include "../assert.v"

module Debouncer_tb();

parameter CLOCK_PERIOD = 1;
parameter CNT_WIDTH = 2;
parameter WAIT_PERIOD = $pow(2, CNT_WIDTH);
parameter ATTEMPT_CNT = 10;

reg r_clk = 0;
reg r_input = 0;
reg r_watch_dog = 0;
wire w_output;

// setup clock
always begin
	#CLOCK_PERIOD r_clk = ~r_clk;
end

// setup watchdog
always @(w_output) begin
	if(r_watch_dog)
		`assert_fail;
end

Debouncer #(.p_CNT_WIDTH(CNT_WIDTH)) uut(r_clk, r_input, w_output);

initial begin

	// operate in the tolerance period.
	// no changes of w_output should occure.
	#WAIT_PERIOD;
	r_watch_dog <= 1;

	repeat (ATTEMPT_CNT) begin
		@(negedge r_clk);
		r_input = ~r_input;
		repeat (WAIT_PERIOD - 1)
			@(posedge r_clk);	
	end
	r_input = w_output;

	// operate out of the tolerance period.
	#WAIT_PERIOD;
	repeat (ATTEMPT_CNT) begin
		r_watch_dog <= 1;
		@(negedge r_clk);
		r_input = ~r_input;
		repeat (WAIT_PERIOD - 1)
			@(posedge r_clk);
		r_watch_dog <= 0;
		@(posedge r_clk);
		@(negedge r_clk);
		`assert_eq(w_output, r_input);
	end

	#WAIT_PERIOD;
	`assert_pass;
end

initial begin
	$dumpfile("Debouncer_tb.vcd");
	$dumpvars(0, Debouncer_tb);
end

endmodule
