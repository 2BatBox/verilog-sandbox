/////////////////////////////////////////////////////
//
//  An asynchronous 7 segment display driver.
// 
/////////////////////////////////////////////////////

module Seg7Async(
	input [3:0] iv_input,
	output [6:0] ov_output
	);

wire x = iv_input[3];
wire y = iv_input[2];
wire z = iv_input[1];
wire w = iv_input[0];

assign ov_output[6] = ((~x & ~y & ~z & w) | (~x & y & ~z & ~w) | (x & ~y & z & w) | (x & y & ~z & w));
assign ov_output[5] = ((x & z & w) | (x & y & ~w) | (y & z & ~w) + (~x & y & ~z & w));
assign ov_output[4] = ((x & y & ~w) | (x & y & z) | (~x & ~y & z & ~w));
assign ov_output[3] = ((y & z & w) | (~y & ~z & w) | (~x & y & ~z & ~w) | (x & ~y & z & ~w));
assign ov_output[2] = ((~x & w) | (~x & y & ~z) | (~y & ~z & w));
assign ov_output[1] = ((~x & ~y & w) | (~x & ~y & z) | (~x & z & w) | (x & y & ~z & w));
assign ov_output[0] = ((~x & ~y & ~z) | (~x & y & z & w) | (x & y & ~z & ~w));

endmodule

