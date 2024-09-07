/*

initial begin
	$display("UartTx");
	$display("---------------------------");
	$display("p_DATA_WIDTH  = %-d", p_DATA_WIDTH);
	$display("p_PARITY      = %-d", p_PARITY);
	$display("p_PARITY_ODD  = %-d", p_PARITY_ODD);
	$display("p_2_STOP_BITS = %-d", p_2_STOP_BITS);
	$display("p_PERIOD      = %-d", p_PERIOD);
	$display("---------------------------");
	$display("lp_TX_TOTAL        = %-d", lp_TX_TOTAL);
	$display("lp_TX_DATA_WIDTH   = %-d", lp_TX_DATA_WIDTH);
	$display("lp_TX_CNT_WIDTH    = %-d", lp_TX_CNT_WIDTH);
	$display("lp_DELAY_CNT_WIDTH = %-d", lp_DELAY_CNT_WIDTH);
	$display("lp_DELAY_PERIOD    = %-d", lp_DELAY_PERIOD);
	$display("---------------------------");
	$display("IDX_START    = [%d]", lp_IDX_START);
	$display("IDX_DATA     = [%d:%d]", lp_IDX_DATA_MSB, lp_IDX_DATA_LSB);
	$display("IDX_PARITY   = [%d]", lp_IDX_PARITY);
	$display("IDX_STOP     = [%d:%d]", lp_IDX_STOP_MSB, lp_IDX_STOP_LSB);
	$display("---------------------------");
	$display("wv_tx_data     = %b", wv_tx_data);
end

*/


/////////////////////////////////////////////////////
//
//  UART transmitter.
//
/////////////////////////////////////////////////////
module UartTx
	#(
		parameter p_DATA_WIDTH = 1, // Must be greater than zero.
		parameter p_PARITY = 1,
		parameter p_PARITY_ODD = 0,
		parameter p_2_STOP_BITS = 1,
		parameter p_PERIOD = 4      // Must be greater than one.
	)(
		input i_clk,
		input i_reset,
		input [p_DATA_WIDTH-1:0] iv_data,
		input i_data_ready,
		output o_tx,
		output o_busy
	);

localparam lp_BITS_STOP_TOTAL = (p_2_STOP_BITS ? 2 : 1);

localparam lp_IDX_START = 0;
localparam lp_IDX_DATA_LSB = 1;
localparam lp_IDX_DATA_MSB = p_DATA_WIDTH;
localparam lp_IDX_PARITY = lp_IDX_DATA_MSB + 1;
localparam lp_IDX_STOP_LSB = lp_IDX_PARITY + 1;
localparam lp_IDX_STOP_MSB = lp_IDX_STOP_LSB + lp_BITS_STOP_TOTAL - 1;

localparam lp_TX_TOTAL = lp_IDX_STOP_MSB + 1;
localparam lp_TX_DATA_WIDTH = lp_IDX_PARITY + 1;
localparam lp_TX_CNT_WIDTH = $clog2(lp_TX_TOTAL + 1);
localparam lp_DELAY_CNT_WIDTH = $clog2(p_PERIOD);
localparam lp_DELAY_PERIOD = p_PERIOD - 1;

reg [lp_TX_DATA_WIDTH-1:0] rv_tx_data;
reg [lp_TX_CNT_WIDTH-1:0] rv_tx_cnt;
reg [lp_DELAY_CNT_WIDTH-1:0] rv_delay_cnt;

wire w_empty = (rv_tx_cnt == 0);
wire [lp_TX_DATA_WIDTH-1:0] wv_tx_data;

assign o_tx = rv_tx_data[0];
assign o_busy = ~w_empty;

assign wv_tx_data[lp_IDX_START] = 1'b0;
assign wv_tx_data[lp_IDX_DATA_MSB:lp_IDX_DATA_LSB] = iv_data;

generate
	if(p_PARITY) begin
		wire w_parity = ^iv_data;
		assign wv_tx_data[lp_IDX_PARITY] = (p_PARITY_ODD ? (~w_parity) : w_parity);
	end
endgenerate


always @(posedge i_clk) begin

	if(i_reset) begin
		rv_tx_data[0] <= 1'b1;
		rv_tx_cnt <= 0;
		rv_delay_cnt <= lp_DELAY_PERIOD;
	end else begin
	
		if(w_empty) begin
		
			if(i_data_ready) begin
				rv_tx_data <= wv_tx_data;
				rv_tx_cnt <= lp_TX_TOTAL;
			end
			
		end else begin
		
			if(rv_delay_cnt == 0) begin
				rv_tx_data <= {1'b1, rv_tx_data[lp_TX_DATA_WIDTH-1:1]};
				rv_tx_cnt <= rv_tx_cnt - 1;
				rv_delay_cnt <= lp_DELAY_PERIOD;
			end else begin
				rv_delay_cnt <= rv_delay_cnt - 1;
			end
			
		end
		
	end
end

endmodule // SerialAsyncTx



/////////////////////////////////////////////////////
//
//  An asynchronous serial receiver.
//
/////////////////////////////////////////////////////

/*

module SerialAsyncRx
	#(
		parameter p_WIDTH = 4, // Must be greater than one
		parameter p_PERIOD = 4 // Must be greater than three
	)(
		input i_clk,
		input i_reset,       // Sync reset.
		input i_rx_data,     // Serial data line.
		input i_rx_enable,   // Serial data line is active.
		output [p_WIDTH-1:0] ov_data,
		output o_data_ready // The output data is ready.
	);
	
localparam lp_RX_CNT_WIDTH = $clog2(p_WIDTH + 1);
localparam lp_PERIOD_WIDTH = $clog2(p_PERIOD);
localparam lp_PERIOD_FULL = p_PERIOD - 1;
localparam lp_PERIOD_HALF = (p_PERIOD / 2) - 1;

reg [lp_RX_CNT_WIDTH-1:0] rv_rx_cnt;
reg [lp_PERIOD_WIDTH-1:0] rv_delay_cnt;
reg [p_WIDTH-1:0] rv_data;

assign ov_data = rv_data;
assign o_last = (rv_rx_cnt == 1);
assign o_data_ready = r_data_ready;

always @(posedge i_clk) begin

	if(i_reset) begin
		rv_rx_cnt <= 0;
		rv_delay_cnt <= lp_PERIOD_FULL;
		rv_data <= 0;
	end else begin
	
		if(rv_rx_cnt == 0) begin
		
			if(i_rx_start) begin
				rv_rx_cnt <= p_WIDTH;
				rv_delay_cnt <= lp_PERIOD_FULL;
				rv_data <= iv_data;
				r_data_ready <= 0;
			end
			
		end else begin
		
			if(rv_period == 0) begin
			
				if(o_last && i_data_ready) begin
					rv_state <= lp_STATE_FULL;
					rv_data <= iv_data;
				end else begin
					rv_state <= rv_state - 1;
					rv_data <= rv_data >> 1;
				end
				
				rv_delay_cnt <= lp_PERIOD_FULL;
			end else begin
			
				rv_delay_cnt <= rv_delay_cnt - 1;
				if(rv_delay_cnt == lp_PERIOD_HALF) begin
					rv_data <= {i_rx, rv_data[p_WIDTH-1:1]};
					r_data_ready <= (rv_rx_cnt == 1);
				end
				
			end
		end
	
//		rv_data <= {i_rx, rv_data[p_WIDTH-1:1]};
//		rv_data_cnt <= rv_data_cnt + 1;
	end

end

endmodule // SerialAsyncRx

*/
