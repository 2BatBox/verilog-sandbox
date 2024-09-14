`default_nettype none

`include "../../../lib/interface/Uart.v"
`include "../../../lib/io/SyncChain.v"
`include "../../../lib/driver/Seg7.v"

module top(
	input CLK,
	input SW1,
	input RX,
	output TX,
	
	output LED1, LED2, LED3, LED4,
	output S1_A, S1_B, S1_C, S1_D, S1_E, S1_F, S1_G, // Seg7 first
	output S2_A, S2_B, S2_C, S2_D, S2_E, S2_F, S2_G  // Seg7 second
	);
	
localparam CLK_FREQ = 25_000_000;
localparam BAUD_RATE = 115_200;
localparam WIDTH = 8;
localparam IS_PARITY = 1;
localparam IS_PARITY_ODD = 1;
localparam WIDTH_STOP = 2;
localparam PERIOD = CLK_FREQ / BAUD_RATE;

wire w_reset = SW1;	
wire [7:0] wv_rx_data;
wire [7:0] wv_tx_data = wv_rx_data + 1;
wire [7:0] wv_display_data = w_rx_data_ready ? wv_rx_data : {8{1'b0}};
wire w_rx_data_ready;
wire w_rx_sync;
wire w_tx_send = (~r_rx_data_ready_last) & w_rx_data_ready;

reg r_rx_data_ready_last;

always @(posedge CLK) begin
	if(w_reset)
		r_rx_data_ready_last <= 0;
	else
		r_rx_data_ready_last <= w_rx_data_ready;
end
	
SyncChain #(.INIT_VALUE(1'b1)) syn_rx(.i_clk(CLK), .iv_input(RX), .ov_output(w_rx_sync));

UartRx
	#(
		.WIDTH_DATA(WIDTH),
		.IS_PARITY(IS_PARITY),
		.IS_PARITY_ODD(IS_PARITY_ODD),
		.WIDTH_STOP(WIDTH_STOP),
		.CLK_PERIOD(PERIOD)
	) uart_rx(
		.i_clk(CLK),
		.i_reset(w_reset),
		.i_rx(w_rx_sync),
		.ov_data(wv_rx_data),
		.o_data_ready(w_rx_data_ready)
	);
	
UartTx
	#(
		.WIDTH_DATA(WIDTH),
		.IS_PARITY(IS_PARITY),
		.IS_PARITY_ODD(IS_PARITY_ODD),
		.WIDTH_STOP(WIDTH_STOP),
		.CLK_PERIOD(PERIOD)
	) uart_tx(
		.i_clk(CLK),
		.i_reset(w_reset),
		.iv_data(wv_tx_data),
		.i_data_ready(w_tx_send),
		.o_tx(TX),
		.o_busy(LED4)
	);

Seg7 s0(wv_display_data[7:4], {S1_A, S1_B, S1_C, S1_D, S1_E, S1_F, S1_G});
Seg7 s1(wv_display_data[3:0], {S2_A, S2_B, S2_C, S2_D, S2_E, S2_F, S2_G});

assign LED1 = RX;
assign LED2 = SW1;
assign LED3 = w_rx_data_ready;

endmodule
