
/*
/////////////////////////////////////////////////////
//
//  UART RX sample pulse generator.
//
/////////////////////////////////////////////////////
module __UartBitSampler
	#(
		parameter p_HALF_PERIOD_CLK = 4
	)
	(
		input i_clk,
		input i_reset,
		output o_bit_sample,
		output o_bit_next
	);

localparam lp_PERIOD_CLK = p_HALF_PERIOD_CLK * 2;	
localparam lp_HALF_PERIOD_VALUE = p_HALF_PERIOD_CLK - 1;
localparam lp_PERIOD_VALUE = lp_PERIOD_CLK - 1;
localparam lp_WIDTH = $clog2(lp_PERIOD_CLK);
	
reg [lp_WIDTH-1:0] rv_counter;

always @(posedge i_clk) begin
	if(i_reset | o_bit_next)
		rv_counter <= 0;
	else
		rv_counter <= rv_counter + 1;
end

assign o_bit_sample = (rv_counter == lp_HALF_PERIOD_VALUE);
assign o_bit_next = (rv_counter == lp_PERIOD_VALUE);

endmodule // __UartBitSampler


/////////////////////////////////////////////////////
//
//  UART RX bit sampler.
//
/////////////////////////////////////////////////////
module __UartBitAccumulator
	#(
		parameter p_WIDTH = 4
	)
	(
		input i_clk,
		input i_reset,
		input i_input,
		input i_sample,
		output [p_WIDTH-1:0] ov_data,
		output o_data_ready
	);
	
localparam lp_BITS_COUNTER_WIDTH = $clog2(p_WIDTH + 1);
	
reg [p_WIDTH-1:0] rv_acc;
reg [lp_BITS_COUNTER_WIDTH-1:0] rv_bit_counter;

always @(posedge i_clk) begin
	if(i_reset) begin
		rv_acc <= 0;
		rv_bit_counter <= 0;
	end else begin
		if(i_sample) begin
			rv_acc <= {i_input, rv_acc[p_WIDTH-1:1]};
			rv_bit_counter <= rv_bit_counter + 1;
		end
	end
end

assign ov_data = rv_acc;
assign o_data_ready = rv_bit_counter == p_WIDTH;

endmodule // __UartBitAccumulator



/////////////////////////////////////////////////////
//
//  UART receiver.
//
/////////////////////////////////////////////////////
module UartRx
	#(
		parameter p_CLK_FREQUENCY = 12000000,
		parameter p_BAUD_RATE = 115200,
		parameter p_DATA_BITS = 8,
		parameter p_STOP_BITS = 1,
		parameter [0:0] p_PARITY = 1,
		parameter [0:0] p_PARITY_ODD = 1
	)
	(
		input i_clk,
		input i_reset,
		input i_input,
		output [p_DATA_BITS-1:0] ov_data,
		output o_data_ready
	);

// Half period in clock cycles. Must be greater than one.
localparam lp_HALF_PERIOD_CLK = (p_CLK_FREQUENCY / p_BAUD_RATE) / 2;	

// Bits
localparam lp_BITS_TOTAL = p_DATA_BITS + p_PARITY + p_STOP_BITS;
	
// State definition.
localparam [1:0] STATE_IDLE     = 2'b00;
localparam [1:0] STATE_START    = 2'b01;
localparam [1:0] STATE_RECEIVE  = 2'b11;

reg [1:0] rv_state;

wire w_bit_sampler_reset = i_reset | (rv_state == STATE_IDLE);
wire w_bit_sample;
wire w_bit_next;

wire w_bit_acc_reset = i_reset | (rv_state == STATE_START);
wire [lp_BITS_TOTAL-1:0] wv_bit_acc_data;
wire w_bit_acc_data_ready;

wire wv_bits_data = wv_bit_acc_data[lp_BITS_TOTAL-1:p_PARITY+p_STOP_BITS];
wire wv_bits_stop = wv_bit_acc_data[p_STOP_BITS-1:0];

wire w_parity_ok;
wire w_stop_bits_ok = ~(|wv_bits_stop);

generate

	if(p_PARITY) begin
		assign w_parity_ok = 1'b1; // TODO: parity checking		
	end else begin
		assign w_parity_ok = 1'b1;
	end

endgenerate

assign o_data = wv_bits_data;
assign o_data_ready = w_bit_acc_data_ready & w_parity_ok & w_stop_bits_ok;
	
__UartBitSampler
	#(
	.p_HALF_PERIOD_CLK(lp_HALF_PERIOD_CLK)
	)
	sample_gen
	(
		.i_clk(i_clk),
		.i_reset(w_bit_sampler_reset),
		.o_bit_sample(w_bit_sample),
		.o_bit_next(w_bit_next)
	);
		
__UartBitAccumulator
	#(
	.p_WIDTH(lp_BITS_TOTAL)
	)
	shift_acc
	(
		.i_clk(i_clk),
		.i_reset(w_bit_acc_reset),
		.i_input(i_input),
		.i_sample(w_bit_sample),
		.ov_data(wv_bit_acc_data),
		.o_data_ready(w_bit_acc_data_ready)
	);


always @(posedge i_clk) begin
	if(i_reset) begin
	
		rv_state <= STATE_IDLE;
		
	end else begin
	
		case(rv_state)

			STATE_IDLE: begin
				if(~i_input) begin
					rv_state <= STATE_START;
				end
			end

			STATE_START: begin
				if(i_input) begin
					rv_state <= STATE_IDLE;
				end else begin
					if(w_bit_sample) begin
						rv_state <= STATE_RECEIVE;
					end 
				end
			end
			
			STATE_RECEIVE: begin
				if(w_bit_acc_data_ready & w_bit_next) begin
					rv_state <= STATE_IDLE;
				end 
			end

		endcase
	
	end
end

endmodule // __UartRxSampler



*/



/////////////////////////////////////////////////////
//
//  UART transmitter.
//
/////////////////////////////////////////////////////
module __UartTx
	#(
		parameter p_DATA_BITS = 8,
		parameter [0:0] p_2_STOP_BITS = 1,
		parameter [0:0] p_PARITY = 1,
		parameter [0:0] p_PARITY_ODD = 1
	)
	(
		input i_clk,
		input i_reset,
		input [p_DATA_BITS-1:0] iv_data,
		input i_data_ready,
		input i_bit_next,
		output o_output,
		output o_busy
	);
	
// State definition.
localparam [2:0] STATE_IDLE     = 2'b000;
localparam [2:0] STATE_START    = 2'b001;
localparam [2:0] STATE_SENDING  = 2'b011;
localparam [2:0] STATE_PARITY   = 2'b111;
localparam [2:0] STATE_STOP_0   = 2'b010;
localparam [2:0] STATE_STOP_1   = 2'b110;

reg [1:0] rv_state;
reg [p_DATA_BITS-1:0] rv_data;

assign o_busy = rv_state != STATE_IDLE;

always @(posedge i_clk) begin
	if(i_reset) begin
		rv_state <= STATE_IDLE;
	end else begin
	
		case(rv_state)

			STATE_IDLE: begin
				if(i_data_ready) begin
					rv_state <= STATE_START;
					rv_data <= iv_data;
				end
			end

			STATE_START: begin
				if(i_input) begin
					rv_state <= STATE_IDLE;
				end else begin
					if(w_bit_sample) begin
						rv_state <= STATE_RECEIVE;
					end 
				end
			end
			
			STATE_RECEIVE: begin
				if(w_bit_acc_data_ready & w_bit_next) begin
					rv_state <= STATE_IDLE;
				end 
			end

		endcase
		
	end
end
	
endmodule // __UartTx










