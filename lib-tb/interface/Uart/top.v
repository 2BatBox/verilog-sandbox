`include "lib-tb/assert.v"
`include "lib/interface/Uart.v"

module top;

localparam WIDTH = 4;
localparam IS_PARITY = 1;
localparam IS_PARITY_ODD = 1;
localparam WIDTH_STOP = 2;
localparam PERIOD = 16;
localparam ARG_RANGE = 2 ** WIDTH;

always begin
	#1 r_clk = ~r_clk;
end

reg r_clk = 0;
reg r_reset = 1;

reg [WIDTH - 1 : 0] rv_tx_data = 0;
reg r_tx_data_ready = 0;
wire w_tx_busy;

wire w_rx_tx;
wire [WIDTH - 1 : 0] wv_rx_data;
wire w_rx_data_ready;


UartTx
	#(
		.WIDTH_DATA(WIDTH),
		.IS_PARITY(IS_PARITY),
		.IS_PARITY_ODD(IS_PARITY_ODD),
		.WIDTH_STOP(WIDTH_STOP),
		.CLK_PERIOD(PERIOD)
	) uart_tx(
		.i_clk(r_clk),
		.i_reset(r_reset),
		.iv_data(rv_tx_data),
		.i_data_ready(r_tx_data_ready),
		.o_tx(w_rx_tx),
		.o_busy(w_tx_busy)
	);
	
UartRx
	#(
		.WIDTH_DATA(WIDTH),
		.IS_PARITY(IS_PARITY),
		.IS_PARITY_ODD(IS_PARITY_ODD),
		.WIDTH_STOP(WIDTH_STOP),
		.CLK_PERIOD(PERIOD)
	) uart_rx(
		.i_clk(r_clk),
		.i_reset(r_reset),
		.i_rx(w_rx_tx),
		.ov_data(wv_rx_data),
		.o_data_ready(w_rx_data_ready)
	);
	
task tx_rx_check;
input [WIDTH:0] in;
begin
	
	// TX
	wait(~w_tx_busy);
	rv_tx_data <= in;
	@(negedge r_clk);
	r_tx_data_ready <= 1;
	@(negedge r_clk);
	r_tx_data_ready <= 0;
	
	// RX
	wait(~w_rx_data_ready);
	wait(w_rx_data_ready);

	// Check	
	`assert_eq(wv_rx_data, rv_tx_data);
	
end
endtask

initial begin

	integer i;
	
	@(negedge r_clk)
	r_reset = 0;
	@(negedge r_clk)
	wait(~w_tx_busy);
	wait(~w_rx_data_ready);
	@(negedge r_clk)
	#PERIOD;
	
	for(i = 0; i < ARG_RANGE; ++i) begin
		tx_rx_check(i);
	end
	`assert_pass;

end

initial begin
	$dumpfile("Uart.vcd");
	$dumpvars(0, top);
end


endmodule // top


