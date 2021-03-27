module Debouncer
	#(parameter PERIOD = 1)
	(
	input i_clk,
	input i_input,
	output o_output
	);

`define STATE_RESET 2'b00
`define STATE_WAIT_CHANGES 2'b01
`define STATE_WAIT_STABLE 2'b10
`define STATE_SET_NEW_VALUE 2'b11

parameter COUNTER_WIDTH = $clog2(PERIOD);

reg [COUNTER_WIDTH-1:0] ra_counter = 0;
reg r_input_dirty = 0;
reg r_input = 0;
reg r_output = 0;
reg [1:0] ra_state = `STATE_SET_NEW_VALUE;

always@(posedge i_clk) begin
	r_input_dirty <= i_input;
	r_input <= r_input_dirty;

	case(ra_state)
		`STATE_RESET: begin
			ra_counter <= 0;
			ra_state <= `STATE_WAIT_CHANGES;
		end

		`STATE_WAIT_CHANGES: begin
			if(r_input != r_output)
				ra_state <= `STATE_WAIT_STABLE;
		end

		`STATE_WAIT_STABLE: begin
			if(r_input == r_output)
				ra_state <= `STATE_RESET;
			else begin
				if(ra_counter < PERIOD)
					ra_counter <= ra_counter + 1;
				else
					ra_state <= `STATE_SET_NEW_VALUE;
			end
		end

		`STATE_SET_NEW_VALUE: begin
			r_output <= r_input;
			ra_state <= `STATE_RESET;
		end
		
	endcase

end

assign o_output = r_output;

endmodule
