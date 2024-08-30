`include "lib/basic_seq/CounterPeriod.v"

/////////////////////////////////////////////////////
//
//  An asynchronous serial transmitter.
//
/////////////////////////////////////////////////////
module SerialAsyncTx
	#(
		parameter p_WIDTH = 4, // Must be greater than one
		parameter p_PERIOD = 4 // Must be greater than one
	)(
		input i_clk,
		input i_reset,
		input [p_WIDTH-1:0] iv_data,
		input i_data_ready,
		output o_tx,
		output o_empty
	);
	
localparam lp_DATA_CNT_WIDTH = $clog2(p_WIDTH + 1);

reg [lp_DATA_CNT_WIDTH-1:0] rv_data_cnt;
reg [p_WIDTH-1:0] rv_data;

wire w_period_cnt_reset = i_reset | o_empty;
wire w_tx_next;

CounterPeriod
	#(
		.p_PERIOD(p_PERIOD)
	) period_counter(
		.i_clk(i_clk),
		.i_reset(w_period_cnt_reset),
		.o_period(w_tx_next)
	);

assign o_tx = rv_data[0];
assign o_empty = (rv_data_cnt == 0);

always @(posedge i_clk) begin
	if(i_reset) begin
		rv_data_cnt <= 0;
		rv_data <= 0;
	end else begin
		if(o_empty) begin
			if(i_data_ready) begin
				rv_data_cnt <= p_WIDTH;
				rv_data <= iv_data;
			end
		end else if(w_tx_next) begin
			rv_data <= rv_data >> 1;
			rv_data_cnt <= rv_data_cnt - 1;
		end
	end
end

endmodule // SerialAsyncTx


/////////////////////////////////////////////////////
//
//  An asynchronous serial receiver.
//
/////////////////////////////////////////////////////
module SerialAsyncRx
	#(
		parameter p_WIDTH = 4, // Must be greater than one
		parameter p_PERIOD = 4 // Must be greater than three
	)(
		input i_clk,
		input i_reset,
		input i_rx,
		input i_rx_enable,
		output [p_WIDTH-1:0] ov_data,
		output o_data_ready
	);
	
localparam lp_PERIOD_CNT_SAMPLE = (p_PERIOD / 2) - 1;
localparam lp_DATA_CNT_WIDTH = $clog2(p_WIDTH + 1);

reg [lp_DATA_CNT_WIDTH-1:0] rv_data_cnt;
reg [p_WIDTH-1:0] rv_data;

wire w_rx_sample = rv_period_cnt == lp_PERIOD_CNT_SAMPLE;
wire w_period_cnt_reset = i_reset | w_rx_next | o_full | ~i_rx_enable;

CounterHalfPeriod
	#(
		.p_PERIOD(lp_PERIOD_CNT_SAMPLE)
	) period_counter(
		.i_clk(i_clk),
		.i_reset(w_period_cnt_reset),
		.o_half_period(w_rx_sample)
	);

assign ov_data = rv_data;
assign o_full = (rv_data_cnt == p_WIDTH);

always @(posedge i_clk) begin

	if(i_reset) begin
		rv_data <= 0;
		rv_data_cnt <= 0;
	end else if(w_rx_sample & (~o_full)) begin
		rv_data <= {i_rx, rv_data[p_WIDTH-1:1]};
		rv_data_cnt <= rv_data_cnt + 1;
	end

end

endmodule // SerialAsyncRx
