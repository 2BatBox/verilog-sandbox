`default_nettype none

`include "../../../lib/alu/CmpZelg.v"

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
	
localparam WIDTH = 2;

//assign LED1 = rv_x > rv_y;
//assign LED3 = rv_x < rv_y;

wire [WIDTH - 1 : 0] wv_x  = {SW1, SW2};
wire [WIDTH - 1 : 0] wv_y  = {SW3, SW4};

CmpZelg #(.p_WIDTH(WIDTH)) cmp0(wv_x, wv_y, LED1, LED2, LED3, LED4);

endmodule
