module IRotaryEncoder(
	input i_clk,
	input i_phase_a,
	input i_phase_b,
	output o_cnt,
	output o_cnt_cw
	);

/**
*
*  A synchronous incremental rotary encoder driver.
*  No debouncer is necessary.
* 
*  Clockwise rotation.
*      _    _    _        _    _
*  \__/ \__/ \__/ \__..._/ \__/ \_ <- i_clk
*    _________
*  _/         \______...__________  <- i_phase_a
*         _________
*  ______/         \_...__________  <- i_phase_b
*                         ____
*  __________________..._/    \___  -> o_cnt
*                         ____
*  __________________..._/    \___  -> o_cnt_cw
*
*
*  Counterclockwise rotation.
*      _    _    _        _    _
*  \__/ \__/ \__/ \__..._/ \__/ \_ <- i_clk
*    _________
*  _/         \______...__________  <- i_phase_a
*         _________
*  ______/         \_...__________  <- i_phase_b
*                         ____
*  __________________..._/    \___  -> o_cnt
*
*  __________________...__________  -> o_cnt_cw
*
*/

reg [1:0] ra_phase_dirty = 0;
reg [1:0] ra_phase = 0;
reg [1:0] ra_phase_prev = 0;
reg [1:0] ra_leave_zero_dir = 0;
reg [1:0] ra_enter_zero_dir = 0;
reg r_cnt = 0;
reg r_cnt_cw = 0;

// internal wires
wire w_update_rotation = (ra_leave_zero_dir == ~ra_enter_zero_dir);

// output wires
assign o_cnt = r_cnt;
assign o_cnt_cw = r_cnt_cw;

always@(posedge i_clk) begin

	// The dirty registers are necessary here since i_phase_a and i_phase_b
	// are extarnal async signals.
	ra_phase_dirty <= {i_phase_a, i_phase_b};
	ra_phase <= ra_phase_dirty;
	
	// Save the previous state.
	ra_phase_prev <= ra_phase;

	// Update 'leave zero' direction.
	if(ra_phase_prev == 2'b00 && ra_phase != 2'b11)
		ra_leave_zero_dir <= ra_phase;

	// Update 'enter zero' direction.
	if(ra_phase_prev != 2'b11 && ra_phase == 2'b00)
		ra_enter_zero_dir <= ra_phase_prev;

	// Update rotation signals.
	r_cnt <= w_update_rotation;
	r_cnt_cw <= w_update_rotation & ra_enter_zero_dir[0];

end

endmodule
