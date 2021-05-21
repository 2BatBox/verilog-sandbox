`default_nettype none

module top(
	input CLK,
	input RX,
	output TX,
	output PMOD1, PMOD2, PMOD3,
	input PMOD4
	);

assign PMOD1 = RX;
assign TX = RX;

UartRx #(.p_CLOCK_RATE(25000000), .p_BIT_RATE(115200), .p_DATA_BITS(8), .p_STOP_BITS(1)) uart_rx(CLK, RX, PMOD2, PMOD3);

endmodule
