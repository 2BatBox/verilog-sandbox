`include "../assert.v"

module Debouncer_tb();

parameter CLOCK_PERIOD = 1;
parameter CNT_WIDTH = 2;
parameter TOLERANCE_PERIOD = $pow(2, CNT_WIDTH);
parameter ATTEMPT_CNT = TOLERANCE_PERIOD * 3;

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

Debouncer #(.p_CNT_WIDTH(CNT_WIDTH), .p_INIT_VALUE(1'b0)) uut(r_clk, r_input, w_output);

initial begin

	// Toggle the the input every clock posedge.
	// No changes of w_output is allowed in this section.
	#TOLERANCE_PERIOD;
	r_watch_dog <= 1;
	repeat (ATTEMPT_CNT) begin
		@(negedge r_clk);
		r_input = ~r_input;
	end
	r_input = w_output;

	// Operate in the tolerance period minus one clock cycle.
	// No changes of w_output is allowed in this section.
	#TOLERANCE_PERIOD;
	r_watch_dog <= 1;
	repeat (ATTEMPT_CNT) begin
		@(negedge r_clk);
		r_input = ~r_input;
		repeat (TOLERANCE_PERIOD / 2)
			@(posedge r_clk);	
	end
	r_input = w_output;

	// Operate in a half a tolerance period.
	// No changes of w_output is allowed in this section.
	#TOLERANCE_PERIOD;
	r_watch_dog <= 1;
	repeat (ATTEMPT_CNT) begin
		@(negedge r_clk);
		r_input = ~r_input;
		repeat (TOLERANCE_PERIOD - 1)
			@(posedge r_clk);	
	end
	r_input = w_output;

	// Operate out of the tolerance period.
	// w_output changes should occure in this section.
	#TOLERANCE_PERIOD;
	repeat (ATTEMPT_CNT) begin
		r_watch_dog <= 1;
		@(negedge r_clk);
		r_input = ~r_input;
		repeat (TOLERANCE_PERIOD - 1)
			@(posedge r_clk);
		r_watch_dog <= 0;
		@(posedge r_clk);
		@(negedge r_clk);
		`assert_eq(w_output, r_input);
	end

	#TOLERANCE_PERIOD;
	`assert_pass;
end

initial begin
	$dumpfile("Debouncer_tb.vcd");
	$dumpvars(0, Debouncer_tb);
end

endmodule
