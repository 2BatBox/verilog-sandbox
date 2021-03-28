/////////////////////////////////////////////////////
//
//  A synchronous incremental rotary encoder driver.
//  No debouncer is necessary.
// 
/////////////////////////////////////////////////////

module IRotaryEncoder(
	input i_clk,
	input i_phase_a,
	input i_phase_b,
	output o_cnt,
	output o_cnt_cw
	);

/**

Pipeline.

Clock	| State transition
----------------------------------------------------------------------------
+0		| {i_phase_a, i_phase_b} -> ra_phase_input
+1		| ra_phase_input -> ra_phase
+2		| ra_phase -> ra_phase_prev
		| {ra_phase, ra_phase_prev} -> {ra_leave_zero}
+3		| {ra_leave_zero, ra_phase} -> {r_cnt, r_cnt_cw}
		| {r_cnt, r_cnt_cw} -> {o_cnt, o_cnt_cw}
----------------------------------------------------------------------------

Reaction delay is 4 clock cycles.

**/

reg [1:0] ra_phase_input = 0;
reg [1:0] ra_phase = 0;
reg [1:0] ra_phase_prev = 0;
reg [1:0] ra_leave_zero = 0;
reg r_cnt = 0;
reg r_cnt_cw = 0;

// output wires
assign o_cnt = r_cnt;
assign o_cnt_cw = r_cnt_cw;

always@(posedge i_clk) begin

	// The input registers are necessary here since i_phase_a and i_phase_b
	// are extarnal async signals.
	ra_phase_input <= {i_phase_a, i_phase_b};
	ra_phase <= ra_phase_input;
		
	// Save the previous state.
	ra_phase_prev <= ra_phase;

	// Leaving zero phase transition.
	// Transition 0:0 -> 1:1 is inconsistent.
	if(ra_phase != 2'b11 && ra_phase_prev == 2'b00)
		ra_leave_zero <= ra_phase;

	// Enter zero phase transition with ra_leave_zero set previously.
	if(ra_phase == 2'b00 && ra_leave_zero != 2'b00) begin
		if(ra_phase_prev == ~ra_leave_zero) begin
			r_cnt <= 1'b1;
			r_cnt_cw <= ra_leave_zero[1];
		end
		ra_leave_zero <= 2'b00;
	end else
		r_cnt <= 1'b0;

end

endmodule
