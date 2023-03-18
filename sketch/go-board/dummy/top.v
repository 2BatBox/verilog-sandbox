`default_nettype none

`include "../../../lib/io/SyncChain.v"

module top(
	input CLK,
	input SW1,
	output LED1,
	);

SyncChain sync0(CLK, SW1, LED1);

endmodule
