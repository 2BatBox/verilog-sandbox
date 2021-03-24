`timescale 100 ns / 10 ns
`include "../assert.v"

module IRotaryEncoder_tb();

parameter CLOCK_PERIOD = 1;
parameter DELAY = CLOCK_PERIOD * 30;
parameter COUNTER_WIDTH = 2;
parameter COUNTER_RANGE = 2 ** COUNTER_WIDTH;
parameter COUNTER_MAX = COUNTER_RANGE - 1;

reg r_clk = 0;
reg r_phase_a = 0;
reg r_phase_b = 0;
reg [COUNTER_WIDTH - 1 : 0] ra_cnt = 0;
reg r_watch_dog = 0;
wire w_cnt;
wire w_cnt_cw;

// setup clock
always begin
	#CLOCK_PERIOD r_clk = 1'b0;
	#CLOCK_PERIOD r_clk = 1'b1;
end

// setup watchdog
always @(w_cnt or w_cnt_cw) begin
	if(r_watch_dog)
		`assert_fail;
end

always@(posedge r_clk) begin
	if(w_cnt)
		ra_cnt <= ra_cnt + (w_cnt_cw ? 1 : -1);
end

IRotaryEncoder uut(r_clk, r_phase_a, r_phase_b, w_cnt, w_cnt_cw);

initial begin

	#DELAY `assert_eq(ra_cnt, 0);

	// Rotate clockwise.
	repeat (COUNTER_MAX) begin
		#DELAY r_phase_a = 1;
		#DELAY r_phase_b = 1;
		#DELAY r_phase_a = 0;
		#DELAY r_phase_b = 0;
	end
	#DELAY `assert_eq(ra_cnt, COUNTER_MAX);

	// Rotate counterclockwise.
	repeat (COUNTER_MAX) begin
		#DELAY r_phase_b = 1;
		#DELAY r_phase_a = 1;
		#DELAY r_phase_b = 0;
		#DELAY r_phase_a = 0;
	end
	#DELAY `assert_eq(ra_cnt, 0);

	// Inconsistent input.
	// w_cnt and w_cnt_cw changes are not allowed anymore.
	r_watch_dog = 1;

	// Separate pulses.
	repeat (COUNTER_MAX) begin
		#DELAY r_phase_a = 1;
		#DELAY r_phase_a = 0;
	end

	repeat (COUNTER_MAX) begin
		#DELAY r_phase_b = 1;
		#DELAY r_phase_b = 0;
	end

	// Glitchy phases.
	repeat (COUNTER_MAX) begin
		#DELAY;
		r_phase_a = 1;
		r_phase_b = 1;
		#DELAY;
		r_phase_a = 0;
		r_phase_b = 0;
	end

	repeat (COUNTER_MAX) begin
		#DELAY r_phase_b = 1;
		#DELAY r_phase_a = 1;
		#DELAY r_phase_a = 0;
		#DELAY r_phase_b = 0;
	end

	repeat (COUNTER_MAX) begin
		#DELAY r_phase_a = 1;
		#DELAY r_phase_b = 1;
		#DELAY r_phase_b = 0;
		#DELAY r_phase_a = 0;
	end

	#DELAY;
	`assert_pass;
end

initial begin
	$dumpfile("IRotaryEncoder_tb.vcd");
	$dumpvars(0, IRotaryEncoder_tb);
end

endmodule
