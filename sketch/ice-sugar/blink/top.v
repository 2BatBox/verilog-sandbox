module top (
	input CLK,
	output LED_G,
	output LED_R,
	output LED_B
);

//-- Modify this value for changing the blink frequency
localparam N = 24;  //-- N<=21 Fast, N>=23 Slow

reg [N:0] counter;
always @(posedge CLK)
  counter <= counter + 1;

assign LED_G = counter[N];
assign LED_R = counter[N];
assign LED_B = counter[N];

endmodule // top
