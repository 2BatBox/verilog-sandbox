/////////////////////////////////////////////////////
//
//  An asynchronous receiver.
//
/////////////////////////////////////////////////////

module UartRx
	#(
	parameter integer p_BITSLOT_HALF_PERIOD = 1,
	parameter integer p_DATA_BITS = 1,
	parameter integer p_STOP_BITS = 1,
	parameter [0:0] p_PARITY = 1,
	parameter [0:0] p_PARITY_ODD = 1
	)

	(
	input i_clk,
	input i_input,
	output [p_DATA_BITS-1:0] ov_data,
	output o_data_ready
	);

// Timing.
localparam integer BITSLOT_PERIOD = p_BITSLOT_HALF_PERIOD * 2;
localparam integer COUNTER_DELAY_WIDTH = $clog2(BITSLOT_PERIOD);

// Bits.
localparam integer COUNTER_REPEAT_MAX = p_DATA_BITS > p_STOP_BITS ? p_DATA_BITS : p_STOP_BITS;
localparam integer COUNTER_REPEAT_WIDTH = $clog2(COUNTER_REPEAT_MAX);

// States definition.
localparam [2:0] STATE_IDLE     = 3'b000;
localparam [2:0] STATE_START    = 3'b001;
localparam [2:0] STATE_SAMPLING = 3'b010;
localparam [2:0] STATE_PARITY   = 3'b011;
localparam [2:0] STATE_STOP     = 3'b100;
localparam [2:0] STATE_UNDEF    = 3'b101;

// 
reg [COUNTER_DELAY_WIDTH-1:0] rv_cnt_delay = 0;
reg [COUNTER_REPEAT_WIDTH-1:0] rv_cnt_repeat = 0;
reg [2:0] rv_state = STATE_IDLE;
reg [p_DATA_BITS-1:0] rv_output = 0;
reg r_data_ready = 0;
reg r_data_valid = 0;

assign ov_data = rv_output;
assign o_data_ready = r_data_ready;

// flags
wire w_delay = |rv_cnt_delay;
wire w_repeat_data_ready = rv_cnt_repeat == p_DATA_BITS - 1;
wire w_repeat_stop_ready = rv_cnt_repeat == p_STOP_BITS - 1;

always@(posedge i_clk) begin
	if(w_delay)
		rv_cnt_delay--;
	else begin

		case(rv_state)

			STATE_IDLE: begin
				if(~i_input) begin
					rv_cnt_delay <= p_BITSLOT_HALF_PERIOD - 1;
					rv_state <= STATE_START;
				end
			end

			STATE_START: begin
				r_data_valid <= 1'b1;

				if(~i_input) begin
					rv_cnt_delay <= BITSLOT_PERIOD - 1;
					rv_state <= STATE_SAMPLING;
				end else
					rv_state <= STATE_IDLE;
			end

			STATE_SAMPLING: begin
				rv_output <= rv_output << 1;
				rv_output[0] <= i_input;
				rv_data_cnt <= rv_data_cnt + 1;
				rv_ts_cnt <= TS_PERIOD - 1;

				if(w_data_done) begin
					rv_stop_cnt <= 0;
					rv_state <= STATE_STOP;
				end 
				r_debug_sampling <= 1'b1; // TODO:debug
			end

			STATE_STOP: begin
				rv_stop_cnt <= rv_stop_cnt + 1;
				rv_ts_cnt <= TS_PERIOD - 1;

				if(i_input) begin
					if(w_stop_done)
						rv_state <= STATE_IDLE;
				end else
					rv_state <= STATE_UNDEF;

				r_stop_sampling <= 1'b1; // TODO:debug					
			end

			STATE_UNDEF: begin
				rv_ts_cnt <= TS_PERIOD - 1;
				if(i_input) begin
					rv_stop_cnt <= 0;
					rv_state <= STATE_STOP;
				end
			end

		endcase

	end
end

initial begin

	$display("p_BITSLOT_HALF_PERIOD = %0d", p_BITSLOT_HALF_PERIOD);
	$display("BITSLOT_PERIOD        = %0d", BITSLOT_PERIOD);
	$display("p_DATA_BITS           = %0d", p_DATA_BITS);
	$display("p_STOP_BITS           = %0d", p_STOP_BITS);
	$display();
	$display("COUNTER_DELAY_WIDTH   = %0d", COUNTER_DELAY_WIDTH);
	$display("COUNTER_REPEAT_WIDTH  = %0d", COUNTER_REPEAT_WIDTH);


	if(p_BITSLOT_HALF_PERIOD < 1) begin
		$error("p_BITSLOT_HALF_PERIOD MUST BE positive");
		$finish;
	end

	if(p_DATA_BITS < 1) begin
		$error("p_DATA_BITS MUST BE positive");
		$finish;
	end

	if(p_STOP_BITS < 1) begin
		$error("p_STOP_BITS MUST BE positive");
		$finish;
	end

end

endmodule
