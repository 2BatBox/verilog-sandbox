`include "lib-tb/assert.v"
`include "lib/io/SerialAsync.v"

module top;

localparam lp_WIDTH = 4;
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
wire w_tx_busy;

// rx
wire [lp_WIDTH - 1 : 0] wv_rx_data;
wire w_rx_full;

UartTx
	#(
		.p_DATA_WIDTH(lp_WIDTH),
		.p_PERIOD(lp_PERIOD)
	) stx(
		.i_clk(r_clk),
		.i_reset(r_reset),
		.iv_data(rv_tx_data),
		.i_data_ready(r_tx_data_ready),
		.o_tx(w_tx),
		.o_busy(w_tx_busy)
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
	wait(~w_tx_busy);
	@(negedge r_clk);
	
	rv_tx_data = 8'b0011;
	r_tx_data_ready = 1;
	
	wait(w_tx_busy);
	wait(~w_tx_busy);
	@(negedge r_clk);
	
//	for(i = 0; i < lp_ARG_RANGE; ++i) begin
	
//		rv_tx_data = i;
//		r_tx_data_ready = 1;
		//wait(~w_tx_last);
		//wait(w_tx_last);
//		@(negedge r_clk);
		
//		$display("| %b | %b | %b |", rv_in, wv_out_ref, wv_out);
//		`assert_eq(rv_tx_data, wv_rx_data);
//	end
	
	`assert_pass;

end

initial begin
	$dumpfile("SerialRxTx.vcd");
	$dumpvars(0, top);
end


endmodule // top


