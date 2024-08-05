`default_nettype none

module top(
	input SW1,
	input SW2,
	input SW3,
	input SW4,
	
	output LED1,
	output LED2,
	output LED3,
	output LED4,
	);
	
assign LED1 = SW1;
assign LED2 = SW2;
assign LED3 = SW3;
assign LED4 = SW4;

endmodule
