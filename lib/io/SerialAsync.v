/*

initial begin
	$display("UartTx");
	$display("---------------------------");
	$display("DATA_WIDTH  = %-d", DATA_WIDTH);
	$display("PARITY      = %-d", PARITY);
	$display("PARITY_ODD  = %-d", PARITY_ODD);
	$display("2_STOP_BITS = %-d", 2_STOP_BITS);
	$display("PERIOD      = %-d", PERIOD);
	$display("---------------------------");
	$display("TX_TOTAL        = %-d", TX_TOTAL);
	$display("TX_DATA_WIDTH   = %-d", TX_DATA_WIDTH);
	$display("TX_CNT_WIDTH    = %-d", TX_CNT_WIDTH);
	$display("DELAY_CNT_WIDTH = %-d", DELAY_CNT_WIDTH);
	$display("DELAY_PERIOD    = %-d", DELAY_PERIOD);
	$display("---------------------------");
	$display("IDX_START    = [%d]", IDX_START);
	$display("IDX_DATA     = [%d:%d]", IDX_DATA_MSB, IDX_DATA_LSB);
	$display("IDX_PARITY   = [%d]", IDX_PARITY);
	$display("IDX_STOP     = [%d:%d]", IDX_STOP_MSB, IDX_STOP_LSB);
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
		parameter DATA_WIDTH = 1, // Must be greater than zero.
		parameter PARITY = 1,
		parameter PARITY_ODD = 0,
		parameter 2_STOP_BITS = 1,
		parameter PERIOD = 4      // Must be greater than one.
	)(
		input i_clk,
		input i_reset,
		input [DATA_WIDTH-1:0] iv_data,
		input i_data_ready,
		output o_tx,
		output o_busy
	);

localparam BITS_STOP_TOTAL = (2_STOP_BITS ? 2 : 1);

localparam IDX_START = 0;
localparam IDX_DATA_LSB = 1;
localparam IDX_DATA_MSB = DATA_WIDTH;
localparam IDX_PARITY = IDX_DATA_MSB + 1;
localparam IDX_STOP_LSB = IDX_PARITY + 1;
localparam IDX_STOP_MSB = IDX_STOP_LSB + BITS_STOP_TOTAL - 1;

localparam TX_TOTAL = IDX_STOP_MSB + 1;
localparam TX_DATA_WIDTH = IDX_PARITY + 1;
localparam TX_CNT_WIDTH = $clog2(TX_TOTAL + 1);
localparam DELAY_CNT_WIDTH = $clog2(PERIOD);
localparam DELAY_PERIOD = PERIOD - 1;

reg [TX_DATA_WIDTH-1:0] rv_tx_data;
reg [TX_CNT_WIDTH-1:0] rv_tx_cnt;
reg [DELAY_CNT_WIDTH-1:0] rv_delay_cnt;

wire w_empty = (rv_tx_cnt == 0);
wire [TX_DATA_WIDTH-1:0] wv_tx_data;

assign o_tx = rv_tx_data[0];
assign o_busy = ~w_empty;

assign wv_tx_data[IDX_START] = 1'b0;
assign wv_tx_data[IDX_DATA_MSB:IDX_DATA_LSB] = iv_data;

generate
	if(PARITY) begin
		wire w_parity = ^iv_data;
		assign wv_tx_data[IDX_PARITY] = (PARITY_ODD ? (~w_parity) : w_parity);
	end
endgenerate


always @(posedge i_clk) begin

	if(i_reset) begin
		rv_tx_data[0] <= 1'b1;
		rv_tx_cnt <= 0;
		rv_delay_cnt <= DELAY_PERIOD;
	end else begin
	
		if(w_empty) begin
		
			if(i_data_ready) begin
				rv_tx_data <= wv_tx_data;
				rv_tx_cnt <= TX_TOTAL;
			end
			
		end else begin
		
			if(rv_delay_cnt == 0) begin
				rv_tx_data <= {1'b1, rv_tx_data[TX_DATA_WIDTH-1:1]};
				rv_tx_cnt <= rv_tx_cnt - 1;
				rv_delay_cnt <= DELAY_PERIOD;
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
		parameter WIDTH = 4, // Must be greater than one
		parameter PERIOD = 4 // Must be greater than three
	)(
		input i_clk,
		input i_reset,       // Sync reset.
		input i_rx_data,     // Serial data line.
		input i_rx_enable,   // Serial data line is active.
		output [WIDTH-1:0] ov_data,
		output o_data_ready // The output data is ready.
	);
	
localparam RX_CNT_WIDTH = $clog2(WIDTH + 1);
localparam PERIOD_WIDTH = $clog2(PERIOD);
localparam PERIOD_FULL = PERIOD - 1;
localparam PERIOD_HALF = (PERIOD / 2) - 1;

reg [RX_CNT_WIDTH-1:0] rv_rx_cnt;
reg [PERIOD_WIDTH-1:0] rv_delay_cnt;
reg [WIDTH-1:0] rv_data;

assign ov_data = rv_data;
assign o_last = (rv_rx_cnt == 1);
assign o_data_ready = r_data_ready;

always @(posedge i_clk) begin

	if(i_reset) begin
		rv_rx_cnt <= 0;
		rv_delay_cnt <= PERIOD_FULL;
		rv_data <= 0;
	end else begin
	
		if(rv_rx_cnt == 0) begin
		
			if(i_rx_start) begin
				rv_rx_cnt <= WIDTH;
				rv_delay_cnt <= PERIOD_FULL;
				rv_data <= iv_data;
				r_data_ready <= 0;
			end
			
		end else begin
		
			if(rv_period == 0) begin
			
				if(o_last && i_data_ready) begin
					rv_state <= STATE_FULL;
					rv_data <= iv_data;
				end else begin
					rv_state <= rv_state - 1;
					rv_data <= rv_data >> 1;
				end
				
				rv_delay_cnt <= PERIOD_FULL;
			end else begin
			
				rv_delay_cnt <= rv_delay_cnt - 1;
				if(rv_delay_cnt == PERIOD_HALF) begin
					rv_data <= {i_rx, rv_data[WIDTH-1:1]};
					r_data_ready <= (rv_rx_cnt == 1);
				end
				
			end
		end
	
//		rv_data <= {i_rx, rv_data[WIDTH-1:1]};
//		rv_data_cnt <= rv_data_cnt + 1;
	end

end

endmodule // SerialAsyncRx

*/
