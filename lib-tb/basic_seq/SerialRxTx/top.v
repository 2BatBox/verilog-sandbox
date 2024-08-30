`include "lib-tb/assert.v"
`include "lib/io/SerialAsync.v"

module top;

localparam lp_WIDTH = 8;
localparam lp_PERIOD = 2;
localparam lp_ARG_RANGE = 2 ** lp_WIDTH;

always begin
	#1 r_clk = ~r_clk;
end

reg r_clk = 0;
reg r_reset = 1;

// tx
reg [lp_WIDTH - 1 : 0] rv_tx_data = 0;
reg r_tx_data_ready = 0;
wire w_tx;
wire w_tx_empty;

// rx
wire [lp_WIDTH - 1 : 0] wv_rx_data;
wire w_rx_full;

SerialAsyncTx
	#(
		.p_WIDTH(lp_WIDTH),
		.p_PERIOD(lp_PERIOD)
	) stx(
		.i_clk(r_clk),
		.i_reset(r_reset),
		.iv_data(rv_tx_data),
		.i_data_ready(r_tx_data_ready),
		.o_tx(w_tx),
		.o_empty(w_tx_empty)
	);
	
	/*
SerialRx
	#(
		.p_WIDTH(lp_WIDTH)
	) srx(
		.i_clk(r_clk),
		.i_reset(r_reset),
		.i_rx_start(w_rx_tx_start),
		.i_rx_sync(w_rx_sync),
		.i_serial(w_serial),
		.ov_data(wv_data_out),
		.o_full(w_rx_full)
	);
	*/

initial begin

	integer i;
	
	@(negedge r_clk)
	r_reset = 0;
	@(negedge r_clk)
	wait(w_tx_empty);
	@(negedge r_clk);
	
	for(i = 0; i < lp_ARG_RANGE; ++i) begin
	
		rv_tx_data = 8'b10101010 + i;
		r_tx_data_ready = 1;
		wait(~w_tx_empty);
		@(negedge r_clk)
		r_tx_data_ready = 0;
		@(negedge r_clk)
		wait(w_tx_empty);
		#10;
		@(negedge r_clk);
		
//		$display("| %b | %b | %b |", rv_in, wv_out_ref, wv_out);
//		`assert_eq(rv_tx_data, wv_rx_data);
	end
	
	`assert_pass;

end

initial begin
	$dumpfile("SerialRxTx.vcd");
	$dumpvars(0, top);
end


endmodule // top


